//
//  HRSelectView.m
//  TravelWithFavors
//
//  Created by cushiro on 2018/4/24.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "HRSelectView.h"
#import "HDSelectCell.h"
static NSString *const cellID = @"HDSelectCell";
@interface HRSelectView()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
@implementation HRSelectView

+(instancetype)initFromNib:(CGRect)frame{
    HRSelectView *view = [[[NSBundle mainBundle] loadNibNamed:@"HRSelectView" owner:self options:nil] lastObject];
    view.frame = frame;
    view.centerView.frame = CGRectMake(0, frame.size.height - 300, SCREEN_WIDTH, 300);
    
    view.centerView.layer.cornerRadius = 5;
    view.centerView.layer.masksToBounds = YES;
    view.tableView.delegate = view;
    view.tableView.dataSource = view;
    view.tableView.tableFooterView = [UIView new];
    view.tableView.rowHeight = HDSelecteTableRowHeight;
    return view;
}
#pragma mark --UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count + 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HDSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:cellID owner:self options:nil] objectAtIndex:0];
    }
    if (indexPath.row == 0) {
        cell.titleLabel.text = @"不携带宠物";
    }else{
        cell.titleLabel.text = self.dataSource[indexPath.row - 1];
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
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelected:)]) {
        [self.delegate didSelected:indexPath.row];
    }
}
-(void)setDataSource:(NSMutableArray *)dataSource{
    _dataSource = dataSource;
    self.hidden = NO;
    [self.tableView reloadData];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.userInteractionEnabled) {
        CGPoint point=[[touches anyObject] locationInView:self];
        if (![self.tableView.layer containsPoint:point]) {
            
//            [UIView animateWithDuration:0.2 animations:^{
//
//                self.centerView.frame = CGRectMake(0, self.frame.size.height, SCREEN_WIDTH, 300);
//
//            } completion:^(BOOL finished) {
//
                self.hidden = YES;
//            }];
            
        }
    }
}

@end
