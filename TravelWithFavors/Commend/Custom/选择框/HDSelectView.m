//
//  HDSelectView.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/2.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "HDSelectView.h"
#import "HDSelectCell.h"
static NSString *const cellID = @"HDSelectCell";
@interface HDSelectView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray *lists;
@property (nonatomic, strong) NSArray *colors;
@property (nonatomic, strong) UITableView *tableView;
@end
@implementation HDSelectView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
        [self addSubview:self.tableView];
    }
    return self;
}
- (void)setColorLists:(NSArray *)colorLists{
    _colorLists = colorLists;
    self.colors = colorLists;
    [self.tableView reloadData];
}
- (void)showSelectView:(NSArray *)dataLists{
    self.lists = dataLists;
    self.tableView.frame = CGRectMake(40, self.bounds.size.height - dataLists.count * HDSelecteTableRowHeight - 96, self.bounds.size.width - 80, dataLists.count * HDSelecteTableRowHeight);
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}
- (void)hide{
    [self removeFromSuperview];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.isAutoDismiss) {
        if (self.userInteractionEnabled) {
            CGPoint point=[[touches anyObject] locationInView:self];
            if (![self.tableView.layer containsPoint:point]) {
                [self hide];
            }
        }
    }
}

#pragma mark --UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.lists.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HDSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:cellID owner:self options:nil] objectAtIndex:0];
    }
    cell.titleLabel.text = self.lists[indexPath.row];
    if (self.colors) {
        cell.titleLabel.textColor = self.colors[indexPath.row];
    }
    if (indexPath.row == self.selectedRow) {
        cell.selelctedImageView.hidden = NO;
    }else{
        cell.selelctedImageView.hidden = YES;
    }
    return cell;
}
#pragma mark --UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectView:didSelected:)]) {
        [self.delegate selectView:self didSelected:indexPath.row];
    }
}
#pragma mark -- 培养在willDisplayCell方法中处理数据的习惯
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
     if (indexPath.section == 0)
     {
     FourTableViewCell *fourCell = (FourTableViewCell *)cell;
     [fourCell setModel:_model];
     }
     else
     {
     cell.textLabel.text = _listArray[indexPath.section][indexPath.row];
     cell.imageView.image = [UIImage imageNamed:_imageArray[indexPath.section][indexPath.row]];
     }
     */
    //以上是描述cell内容的代码，以下是绘制cell分割线占满整个屏幕宽度的代码
    if (indexPath.row < self.lists.count) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }else{
        [cell setSeparatorInset:UIEdgeInsetsMake(0, tableView.bounds.size.width, 0, 0)];
    }
}
#pragma mark --load--
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.layer.cornerRadius = 5;
        _tableView.layer.masksToBounds = YES;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
        _tableView.rowHeight = HDSelecteTableRowHeight;
    }
    return _tableView;
}
- (NSArray *)lists{
    if (!_lists) {
        _lists = [[NSArray alloc] init];
    }
    return _lists;
}

- (void)dealloc{
    debugLog(@"%@ 释放了",[self class]);
}
@end
