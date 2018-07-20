//
//  OrderChangePopupView.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/7.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "OrderChangePopupView.h"
#import "OrderChangePopupCell.h"
static NSString *const cellID = @"OrderChangePopupCell";
@interface OrderChangePopupView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *header;
@property (nonatomic, strong) UIButton *closeBtn;
@property (nonatomic, strong) UITableView *tableView;
@end
@implementation OrderChangePopupView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
        self.bgView.frame = CGRectMake(40, (frame.size.height - 280 - 48)/2, frame.size.width - 80, 280);
        self.header.frame = CGRectMake(0, 0, self.bgView.bounds.size.width, 50);
        self.tableView.frame = CGRectMake(0, 50, self.bgView.bounds.size.width, self.bgView.bounds.size.height - 50);
        self.closeBtn.frame = CGRectMake((frame.size.width - 60)/2, CGRectGetMaxY(self.bgView.frame) + 8, 60, 40);
        [self addSubview:self.bgView];
        [self.bgView addSubview:self.header];
        [self.bgView addSubview:self.tableView];
        [self addSubview:self.closeBtn];
        
    }
    return self;
}
- (void)showPopupView{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}
- (void)closeClick{
    [self dismiss];
}
- (void)dismiss{
    [self removeFromSuperview];
}
#pragma mark --UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataLists.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderChangePopupCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.titleLabel.text = self.dataLists[indexPath.row];
    return cell;
}
#pragma mark --load--
- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.layer.cornerRadius = 5;
        _bgView.layer.masksToBounds = YES;
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}
- (UILabel *)header{
    if (!_header) {
        _header = [[UILabel alloc] init];
        _header.backgroundColor = [UIColor whiteColor];
        _header.text = @"退票改签规则";
        _header.textColor = [UIColor colorWithHexString:@"#333333"];
        _header.textAlignment = NSTextAlignmentCenter;
        _header.font = [UIFont systemFontOfSize:15.0f];
    }
    return _header;
}
- (UIButton *)closeBtn{
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeBtn.adjustsImageWhenHighlighted = NO;
        [_closeBtn setImage:[UIImage imageNamed:@"gqtj_gb"] forState:UIControlStateNormal];
//        _closeBtn.backgroundColor = [UIColor redColor];
//        _closeBtn.imageView.contentMode = UIViewContentModeBottom;
        [_closeBtn addTarget:self action:@selector(closeClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.layer.cornerRadius = 5;
        _tableView.layer.masksToBounds = YES;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerNib:[UINib nibWithNibName:cellID bundle:nil] forCellReuseIdentifier:cellID];
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 40;
    }
    return _tableView;
}
- (NSArray *)dataLists{
    if (!_dataLists) {
        _dataLists = @[@"退票条件：以航空公司最新规定为准",@"改期条件：以航空公司最新规定为准以航空公司最新规定为准",@"改签条件：以航空公司最新规定为准以航空公司最新规定为准以航空公司最新规定为准以航空公司最新规定为准"];
    }
    return _dataLists;
}
@end
