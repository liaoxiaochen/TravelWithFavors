//
//  RulePopupView.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/7.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "RulePopupView.h"
#import "RulePopupViewCell.h"
static NSString *const cellID = @"RulePopupViewCell";
@interface RulePopupView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *lists;
@end
@implementation RulePopupView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
//        self.userInteractionEnabled = YES;
        
        self.bgView.userInteractionEnabled = YES;
        self.bgView.frame = CGRectMake(35, (frame.size.height - 300)/2, frame.size.width - 70, 300);
        self.bgView.layer.cornerRadius = 5;
        self.bgView.layer.masksToBounds = YES;
        [self addSubview:self.bgView];
        
        self.headerLabel.frame = CGRectMake(0, 0, self.bgView.bounds.size.width, 40);
        [self.bgView addSubview:self.headerLabel];
        
        self.tableView.frame = CGRectMake(0, CGRectGetMaxY(self.headerLabel.frame), self.bgView.bounds.size.width, self.bgView.bounds.size.height - CGRectGetMaxY(self.headerLabel.frame) - 2);
        [self.bgView addSubview:self.tableView];
        
//        UITapGestureRecognizer *yap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
//        [self addGestureRecognizer:yap];
    }
    return self;
}
- (void)setDataLists:(NSArray *)dataLists{
    _dataLists = dataLists;
    self.lists = dataLists;
    [self.tableView reloadData];
}
- (void)showPopupView{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}
- (void)dismiss{
    [self removeFromSuperview];
}
//- (void)tapAction{
//    [self dismiss];
//}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [[event allTouches] anyObject];
//    CGPoint point=[touch locationInView:self];
//    CGPoint point1 = [self.bgView.layer convertPoint:point fromLayer:self.layer];
    CGPoint point3 = [touch locationInView:self.bgView];
    if (![self.bgView.layer containsPoint:point3]) {
        [self dismiss];
    }
}
#pragma mark --UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.lists.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RulePopupViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.titleStr = self.lists[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
#pragma mark --load--
- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}
- (UILabel *)headerLabel{
    if (!_headerLabel) {
        _headerLabel = [[UILabel alloc] init];
        _headerLabel.backgroundColor = [UIColor whiteColor];
        _headerLabel.text = @"改签规则";
        _headerLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _headerLabel.textAlignment = NSTextAlignmentCenter;
        _headerLabel.font = [UIFont systemFontOfSize:15.0f];
    }
    return _headerLabel;
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
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}
- (NSArray *)lists{
    if (!_lists) {
        //[@[@"退改签规则",@"退改签规则改签规则改签规则",@"退改签规则改签规则",@"退改签规则改签规则改签规则改签规则改签规则改签规则改签规则改签规则改签规则改签规则改签规则改签规则"]];
        _lists = [[NSArray alloc] init];
    }
    return _lists;
}
- (void)dealloc{
    debugLog(@"释放了%@",[self class]);
}
@end
