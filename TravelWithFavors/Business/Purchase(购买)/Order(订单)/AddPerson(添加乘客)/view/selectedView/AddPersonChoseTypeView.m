//
//  AddPersonChoseTypeView.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/7.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "AddPersonChoseTypeView.h"
#import "AddPersonChoseTypeCell.h"
static NSString *const cellID = @"AddPersonChoseTypeCell";
static CGFloat const rowHight = 50;
static CGFloat const headerH = 56;
@interface AddPersonChoseTypeView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *header;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *list;
@end

@implementation AddPersonChoseTypeView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
        [self addSubview:self.bgView];
        [self.bgView addSubview:self.header];
        [self.bgView addSubview:self.tableView];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat H = self.list.count *rowHight + headerH;
    self.bgView.frame = CGRectMake(36, (self.bounds.size.height - H)/2, self.bounds.size.width - 72, H);
    self.header.frame = CGRectMake(0, 0, self.bgView.bounds.size.width, headerH);
    self.tableView.frame = CGRectMake(0, headerH, self.bgView.bounds.size.width, self.bgView.bounds.size.height - headerH);
}
- (void)setTitleString:(NSString *)titleString{
    _titleString = titleString;
    self.header.text = titleString;
}
- (void)setDataLists:(NSArray *)dataLists{
    _dataLists = dataLists;
    if (dataLists) {
        self.list = dataLists;
        [self.tableView reloadData];
        [self layoutIfNeeded];
    }
}
- (void)showAddPersonChoseTypeView{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}
- (void)dismiss{
    [self removeFromSuperview];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint point = [touch locationInView:self.bgView];
    if (![self.bgView.layer containsPoint:point]) {
        [self dismiss];
    }
}
#pragma mark --UITableViewDatasouce
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.list.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AddPersonChoseTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.typeLabel.text = self.list[indexPath.row];
    cell.typeImageView.hidden = !(self.selectedIndex == indexPath.row);
    return cell;
}
#pragma mark --UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.selectedIndex != indexPath.row) {
        __block typeof(self) weakSelf = self;
        if (self.selectedBlock) {
            NSString *type = weakSelf.list[indexPath.row];
            self.selectedBlock(indexPath.row,type);
        }
    }
    [self dismiss];
}
#pragma mark - load-
- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.cornerRadius = 5;
        _bgView.layer.masksToBounds = YES;
    }
    return _bgView;
}
- (UILabel *)header{
    if (!_header) {
        _header = [[UILabel alloc] init];
        _header.text = @"选择证件类型";
        _header.textColor = [UIColor colorWithHexString:@"#333333"];
        _header.font = [UIFont systemFontOfSize:14.0f];
        _header.textAlignment = NSTextAlignmentCenter;
    }
    return _header;
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
        _tableView.rowHeight = rowHight;
        [_tableView registerNib:[UINib nibWithNibName:cellID bundle:nil] forCellReuseIdentifier:cellID];
    }
    return _tableView;
}
- (NSArray *)list{
    if (!_dataLists) {
        _list = @[@"身份证",@"护照",@"港澳台通行证",@"台胞证"];
    }
    return _list;
}
@end
