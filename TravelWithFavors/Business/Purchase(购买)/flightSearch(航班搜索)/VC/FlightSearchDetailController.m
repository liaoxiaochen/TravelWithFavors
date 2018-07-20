//
//  FlightSearchDetailController.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/6.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "FlightSearchDetailController.h"
#import "FlightSearchDetailHeaderView.h"
#import "FlightSearchJourneyDetailCell.h"
#import "OrderCreateController.h"
#import "OrderDetailInfoController.h"
#import "RulePopupView.h"
#import "FlightDetailInfo.h"
#import "FlightOrderInfoModel.h"
#import "CityInfo.h"
#import "RMCalendarModel.h"

#import "HROrderChangeViewController.h"

static NSString *const cellID = @"FlightSearchJourneyDetailCell";
@interface FlightSearchDetailController ()
@property (nonatomic, strong) FlightSearchDetailHeaderView *headerView;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) FlightDetailInfo *detailInfo;
@end

@implementation FlightSearchDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = [NSString stringWithFormat:@"%@-%@",self.startCity.city_name,self.endCity.city_name];
    self.view.backgroundColor = [UIColor hdMainColor];
    [self configView];
    [self getDetailData];
}
- (void)configView{
    self.tableView.rowHeight = 76;
    self.tableView.backgroundColor = [UIColor clearColor];
//    self.tableView.tableFooterView = self.footerView;
    
}
- (void)moreBtnClick{
    
}
- (void)ruleClick:(NSArray *)lists{
    RulePopupView *view = [[RulePopupView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT)];
    view.headerLabel.text = @"退改签规则";
    view.dataLists = lists;
    [view showPopupView];
}
- (void)getDetailData{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *url = [HttpNetRequestTool requestUrlString:@"/ticket/flight/search"];
    NSString *time = [NSString stringWithFormat:@"%.2lu-%.2lu-%.2lu",self.startTime.year,self.startTime.month,self.startTime.day];
    NSString *user_type = (self.isPet ? @"2" : @"1");
    NSDictionary *dict = @{@"ride_type":@"1",@"to":self.aircode1,@"user_type":user_type};
//@"start_city":self.startCity.city_code,@"choose_time1":time,@"to_city":self.endCity.city_code,
    [HttpNetRequestTool netRequest:HttpNetRequestPost urlString:url paraments:dict success:^(id Json) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        BaseModel *model = [BaseModel yy_modelWithJSON:Json];
        if (model.code == 1) {
            self.detailInfo = [FlightDetailInfo getFlightDetailInfoData:model.data];
            self.headerView.startTime = self.startTime;
            self.headerView.info = self.detailInfo;
            self.tableView.tableHeaderView = self.headerView;
            [self.tableView reloadData];
        }else{
            [HSToast hsShowBottomWithText:model.msg];
        }
    } failure:^(NSString *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [HSToast hsShowBottomWithText:error];
    }];
}

- (void)createOrder:(NSString *)positionId{
    if (self.isChange) {//改签
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSString *url = [HttpNetRequestTool requestUrlString:@"/ticket/flight/detail2"];
        NSDictionary *dict = @{@"flight_id":self.aircode1,@"position_id":positionId};
        HRLog(@"%@",dict)
        [HttpNetRequestTool netRequest:HttpNetRequestPost urlString:url outTime:20 paraments:dict isHeader:YES success:^(id Json) {
            HRLog(@"%@",Json)
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            BaseModel *model = [BaseModel yy_modelWithJSON:Json];
            if (model.code == 1) {
                HRorderModel *orderModel = [HRorderModel yy_modelWithJSON:model.data];
                HROrderChangeViewController *vc = [[HROrderChangeViewController alloc] init];
                vc.orderModel = orderModel;
                vc.orderno = self.orderno;
                vc.aircode1 = self.aircode1;
                vc.positionId = positionId;
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                [HSToast hsShowBottomWithText:model.msg];
            }
        } failure:^(NSString *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [HSToast hsShowBottomWithText:error];
        }];
    }else{//下单
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSString *url = [HttpNetRequestTool requestUrlString:@"/ticket/flight/detail"];
        NSString *user_type = (self.isPet ? @"2" : @"1");
        NSDictionary *dict = @{@"ride_type":@"1",@"to":self.aircode1,@"user_type":user_type,@"to_pos":positionId};
        [HttpNetRequestTool netRequest:HttpNetRequestPost urlString:url outTime:20 paraments:dict isHeader:YES success:^(id Json) {
            HRLog(@"%@",Json)
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            BaseModel *model = [BaseModel yy_modelWithJSON:Json];
            if (model.code == 1) {
                OrderCreateController *vc = [[OrderCreateController alloc] init];
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
    FlightDetailAirInfo *info = self.detailInfo.position[indexPath.section];
    __weak typeof(self) weakSelf = self;
    cell.ruleBlock = ^{
        debugLog(@"点击了规则");
        [weakSelf ruleClick:@[info.change_text,info.refund_text,info.change_date_text]];
    };
    cell.orderBlock = ^{
        debugLog(@"点击了%ld",(long)indexPath.section);
        [weakSelf createOrder:info.pid];
    };
    cell.airInfo = info;
    return cell;
}
#pragma mark --UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 12;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    OrderDetailInfoController *vc = [[OrderDetailInfoController alloc] init];
//    vc.isPet = self.isPet;
//    vc.isJourney = NO;
//    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark --load--
- (FlightSearchDetailHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[[NSBundle mainBundle] loadNibNamed:@"FlightSearchDetailHeaderView" owner:self options:nil] objectAtIndex:0];
        _headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 190);
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
- (void)dealloc{
    NSLog(@"%@该释放了",[self class]);
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
