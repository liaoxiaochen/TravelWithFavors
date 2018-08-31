//
//  FlightSearchJourneyDetailController.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/6.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "FlightSearchJourneyDetailController.h"
#import "FlightSearchJourneyDetailHeaderView.h"
#import "FlightSearchJourneyDetailCell.h"
#import "OrderDetailInfoController.h"
#import "RulePopupView.h"
#import "CityInfo.h"
#import "RMCalendarModel.h"
#import "FlightSearchDetailInfo.h"
#import "OrderCreateController.h"

static NSString *const cellID = @"FlightSearchJourneyDetailCell";
@interface FlightSearchJourneyDetailController ()
@property (nonatomic, strong) FlightSearchJourneyDetailHeaderView *headerView;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) FlightSearchDetailInfo *detailInfo;
@end

@implementation FlightSearchJourneyDetailController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor hdMainColor]];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    UIView *sysView = [[UIView alloc] initWithFrame:self.view.frame];
    [sysView.layer addSublayer:[UIColor setGradualChangingColor:self.view]];
    [self.view insertSubview:sysView atIndex:0];
    [self setCustomNavigationTitleView];
    [self configView];
    [self getDetailData];
}
- (void)setCustomNavigationTitleView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [AppConfig getNavigationBarHeight])];
    view.backgroundColor = [UIColor hdMainColor];
    
    UIView *bgview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, view.bounds.size.width, view.bounds.size.height)];
    
    UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    leftLabel.text = self.startCity.city_name;
    leftLabel.textColor = [UIColor whiteColor];
    [leftLabel sizeToFit];
    
    UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    rightLabel.text = self.endCity.city_name;
    rightLabel.textColor = [UIColor whiteColor];
    [rightLabel sizeToFit];
    
    CGFloat bgW = leftLabel.bounds.size.width + rightLabel.bounds.size.width + 18 + 14;
    bgview.frame = CGRectMake((view.bounds.size.width - bgW)/2, [AppConfig getStatusBarHeight], bgW, [AppConfig getNavigationBarHeight] - [AppConfig getStatusBarHeight]);
    [view addSubview:bgview];
    
    leftLabel.frame = CGRectMake(0, 0, leftLabel.bounds.size.width, bgview.bounds.size.height);
    [bgview addSubview:leftLabel];
    
    UIImageView *flight = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ss_wf2"]];
    flight.frame = CGRectMake(CGRectGetMaxX(leftLabel.frame) + 7, (bgview.bounds.size.height - 18)/2, 18, 18);
    [bgview addSubview:flight];
    
    rightLabel.frame = CGRectMake(bgview.bounds.size.width - rightLabel.bounds.size.width, 0, rightLabel.bounds.size.width, bgview.bounds.size.height);
    [bgview addSubview:rightLabel];
    
    [self.view addSubview:view];
}
- (void)configView{
    self.tableView.rowHeight = 76;
    self.tableView.backgroundColor = [UIColor clearColor];
//    self.tableView.tableHeaderView = self.headerView;
//    self.tableView.tableFooterView = self.footerView;
}
- (void)getDetailData{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *url = [HttpNetRequestTool requestUrlString:@"/ticket/flight/search"];
//    NSString *startTime = [NSString stringWithFormat:@"%.2lu-%.2lu-%.2lu",self.startTime.year,self.startTime.month,self.startTime.day];
//     NSString *endTime = [NSString stringWithFormat:@"%.2lu-%.2lu-%.2lu",self.startTime.year,self.startTime.month,self.startTime.day];
    NSString *user_type = (self.isPet ? @"2" : @"1");
    NSDictionary *dict = @{@"ride_type":@"2",@"to":self.aircode1,@"back":self.aircode2,@"user_type":user_type};
    [HttpNetRequestTool netRequest:HttpNetRequestPost urlString:url paraments:dict success:^(id Json) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        BaseModel *model = [BaseModel yy_modelWithJSON:Json];
        if (model.code == 1) {
            self.detailInfo = [FlightSearchDetailInfo getFlightSearchDetailInfoData:model.data];
            if (self.detailInfo.position.count > 0) {
                self.detailInfo.position = [NSArray yy_modelArrayWithClass:[FlightSearchDetailPosition class] json:self.detailInfo.position];
                NSMutableArray *tmpArray = [NSMutableArray array];
                for (FlightSearchDetailPosition *position in self.detailInfo.position) {
                    if ([position.to.position_name isEqualToString:position.back.position_name] && [position.to.position_code isEqualToString:position.back.position_code]) {
                        [tmpArray addObject:position];
                    }
                }
                self.detailInfo.position = tmpArray;
                if (self.detailInfo.position.count > 0) {
                    self.headerView.toTime = self.startTime;
                    self.headerView.backTime = self.endTime;
                    self.headerView.to = self.detailInfo.to;
                    self.headerView.back = self.detailInfo.back;
                    self.tableView.tableHeaderView = self.headerView;
//                    self.tableView.tableFooterView = self.footerView;
                    [self.tableView reloadData];
                }
            }else{
                [HSToast hsShowBottomWithText:@"没有订单数据"];
            }
        }else{
            [HSToast hsShowBottomWithText:model.msg];
        }
    } failure:^(NSString *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [HSToast hsShowBottomWithText:error];
    }];
}
- (void)moreBtnClick{
    
}

- (void)ruleClick:(NSArray *)lists{
    RulePopupView *view = [[RulePopupView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT)];
    view.headerLabel.text = @"退改签规则";
    view.dataLists = lists;
    [view showPopupView];
}

- (void)createOrderWithTo:(NSString *)toPositionId back:(NSString *)backPositionId{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *url = [HttpNetRequestTool requestUrlString:@"/ticket/flight/detail"];
    NSString *user_type = (self.isPet ? @"2" : @"1");
    NSDictionary *dict = @{@"ride_type":@"2",@"to":self.aircode1,@"back":self.aircode2,
                           @"user_type":user_type,@"to_pos":toPositionId,@"back_pos":backPositionId};
    [HttpNetRequestTool netRequest:HttpNetRequestPost urlString:url outTime:20 paraments:dict isHeader:YES success:^(id Json) {
        HRLog(@"%@",Json)
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        BaseModel *model = [BaseModel yy_modelWithJSON:Json];
        if (model.code == 1) {
            OrderCreateController *vc = [[OrderCreateController alloc] init];
            vc.isJourney = YES;
            vc.flightOrderInfoModel = [FlightOrderInfoModel yy_modelWithJSON:model.data];
            vc.isPet = self.isPet;
            vc.startCity = self.startCity;
            vc.endCity = self.endCity;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            [HSToast hsShowBottomWithText:model.msg];
        }
    } failure:^(NSString *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [HSToast hsShowBottomWithText:error];
    }];
}

#pragma mark --UITableViewDatasouce
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.detailInfo ? self.detailInfo.position.count : 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FlightSearchJourneyDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:cellID owner:self options:nil] objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.section == 0) {
        cell.buttomLayout.constant = 0;
    }else{
        cell.buttomLayout.constant = 16;
    }
    FlightSearchDetailPosition *info  = self.detailInfo.position[indexPath.section];
    cell.info = info;
    WeakObj(self)
    cell.ruleBlock = ^{
        debugLog(@"点击了规则");
        [weakself ruleClick:@[@"出发航班规则如下：",info.to.change_text,info.to.refund_text,info.to.change_date_text,
                              @"返程航班规则如下：",info.back.change_text,info.back.refund_text,info.back.change_date_text]];
    };
    cell.orderBlock = ^{
        NSInteger index = indexPath.section;
        debugLog(@"点击了%ld",(long)index);
        [weakself createOrderWithTo:info.to.pid back:info.back.pid];
    };
    return cell;
}
#pragma mark --UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    OrderDetailInfoController *vc = [[OrderDetailInfoController alloc] init];
//    vc.isPet = self.isPet;
//    vc.isJourney = YES;
//    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark --load--
- (FlightSearchJourneyDetailHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[[NSBundle mainBundle] loadNibNamed:@"FlightSearchJourneyDetailHeaderView" owner:self options:nil] objectAtIndex:0];
        _headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 285 );
        _headerView.backgroundColor = [UIColor clearColor];
    }
    return _headerView;
}
- (UIView *)footerView{
    if (!_footerView) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 90)];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(10, 25, _footerView.bounds.size.width - 20, 40);
        button.adjustsImageWhenHighlighted = NO;
        [button setTitle:@"查看更多舱位" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [button addTarget:self action:@selector(moreBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_footerView addSubview:button];
    }
    return _footerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
