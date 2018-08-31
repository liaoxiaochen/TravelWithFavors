//
//  OrderDetailInfoController.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/7.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "OrderDetailInfoController.h"
#import "OrderDetailInfoCell.h"
#import "OrderDetailPetInfoCell.h"
#import "OrderDetailFlightInfoCell.h"
#import "OrderDetailChangeCell.h"
#import "OrderChangeController.h"
#import "OrderBackController.h"
#import "OrderBackApplyPopupView.h"
#import "OrderPayController.h"
#import "HRorderRefundModel.h"
#import "FlightInfoSearchController.h"
#import "NSDate+RMCalendarLogic.h"
#import "RMCalendarModel.h"
#import "CityInfo.h"
#import "HRorderChangeModel.h"
#import "HRPassengerInfoCell.h"
#import "HRPassengerInfoTitleCell.h"

@interface OrderDetailInfoController ()
@property (nonatomic, strong) OrderBackApplyPopupView *applyView ;
/** 标记刷新 */
@property (nonatomic,assign) BOOL updateFlag;
@end

@implementation OrderDetailInfoController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.updateFlag) {
        [self.tableView reloadData];
        self.updateFlag = false;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"订单详情";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateData) name:@"orderDetailPage" object:nil];
}
-(void)updateData{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *url = [HttpNetRequestTool requestUrlString:@"/user/order/detail"];
    HRorderModel *model = self.orderModel;
    NSDictionary *dict = @{@"order_id":model.pid};
    [HttpNetRequestTool netRequest:HttpNetRequestPost urlString:url outTime:20 paraments:dict isHeader:YES success:^(id Json) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        BaseModel *model = [BaseModel yy_modelWithJSON:Json];
        if (model.code == 1) {
            HRorderModel *orderModel = [HRorderModel getOrderInfo:model.data];
            self.isPet = [@"2" isEqualToString: orderModel.user_type] ? YES : NO;
            self.orderModel = orderModel;
            self.updateFlag = YES;
            [self.tableView reloadData];
        }else{
            [HSToast hsShowBottomWithText:model.msg];
        }
    } failure:^(NSString *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [HSToast hsShowBottomWithText:error];
    }];
}
#pragma mark --支付 改签 退票
//- (void)orderBackApply{
//    if ([@[@"-7",@"31",@"32",@"33"] containsObject:self.orderModel.flight_status]) {
//        [self ticketRefundDetail];//退票详情
//    }else if ([self.orderModel.flight_status integerValue] == -1) {
//        [self repay];//重新支付
//    }else if ([@[@"-3",@"-4",@"-5"] containsObject:self.orderModel.flight_status]){
//        [self orderChangeDetail];//改签详情
//    }
//}
- (void)orderBackApply{
    if ([@[@"8",@"9",@"10"] containsObject:self.orderModel.order_status]) {
        [self ticketRefundDetail];//退票详情
    }else if ([self.orderModel.order_status integerValue] == 0) {
        [self repay];//重新支付
    }else if ([@[@"3",@"4",@"5"] containsObject:self.orderModel.order_status]){
        [self orderChangeDetail];//改签详情
    }
}
//重新支付
-(void)repay{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *url = [HttpNetRequestTool requestUrlString:@"/user/order/pay"];
    NSDictionary *dict = @{@"order_id":self.orderModel.pid};
    [HttpNetRequestTool netRequest:HttpNetRequestPost urlString:url outTime:20 paraments:dict isHeader:YES success:^(id Json) {
        HRLog(@"%@",Json)
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        BaseModel *model = [BaseModel yy_modelWithJSON:Json];
        if (model.code == 1) {
            HRorderModel *orderModel = [HRorderModel yy_modelWithJSON:model.data];
            orderModel.passengers = [NSArray yy_modelArrayWithClass:[passengerModel class] json:orderModel.passengers];
            OrderPayController *vc = [[OrderPayController alloc] init];
            vc.orderModel = orderModel;
            vc.isJourney = self.isJourney;
            vc.isPet = self.isPet;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            [HSToast hsShowBottomWithText:model.msg];
        }
    } failure:^(NSString *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [HSToast hsShowBottomWithText:error];
    }];
}
//退票申请
-(void)ticketRefund{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"确认退票？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSString *url = [HttpNetRequestTool requestUrlString:@"/user/order/exitTicket"];
        NSDictionary *dict = @{@"orderno":self.orderModel.orderno?:@"",@"type":@"3"};
        [HttpNetRequestTool netRequest:HttpNetRequestPost urlString:url outTime:20 paraments:dict isHeader:YES success:^(id Json) {
            HRLog(@"%@",Json)
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            BaseModel *model = [BaseModel yy_modelWithJSON:Json];
            if (model.code == 1) {
                HRorderRefundModel *orderRefundModel = [HRorderRefundModel getOrderRefundInfo:model.data];
                OrderBackController *vc = [[OrderBackController alloc] init];
                vc.orderRefundModel = orderRefundModel;
                vc.start_city_name = self.start_city_name;
                vc.to_city_name = self.to_city_name;
                [self.navigationController pushViewController:vc animated:YES];
                [self updateData];
            }else{
                [HSToast hsShowBottomWithText:model.msg];
            }
        } failure:^(NSString *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [HSToast hsShowBottomWithText:error];
        }];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVC addAction:action1];
    [alertVC addAction:cancelAction];
    [self presentViewController:alertVC animated:YES completion:nil];
    
    //__weak typeof(self) weakSelf = self;
    //        weakSelf.applyView = [[OrderBackApplyPopupView alloc] initWithFrame:CGRectMake(0, SCREENH_HEIGHT, SCREEN_WIDTH, SCREENH_HEIGHT)];
    //        weakSelf.applyView.applyBlock = ^{
    //            [weakSelf.applyView removeFromSuperview];
    //            OrderBackController *vc = [[OrderBackController alloc] init];
    //            [weakSelf.navigationController pushViewController:vc animated:YES];
    //        };
    //        [weakSelf.view addSubview:weakSelf.applyView];
    //        [UIView animateWithDuration:0.2 animations:^{
    //
    //        }];
    //        weakSelf.applyView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT);
}
//退票申请详情
-(void)ticketRefundDetail{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *url = [HttpNetRequestTool requestUrlString:@"/user/order/refundList"];
    NSDictionary *dict = @{@"order_id":self.orderModel.pid};
    [HttpNetRequestTool netRequest:HttpNetRequestPost urlString:url outTime:20 paraments:dict isHeader:YES success:^(id Json) {
        HRLog(@"%@",Json)
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        BaseModel *model = [BaseModel yy_modelWithJSON:Json];
        if (model.code == 1) {
            HRorderRefundModel *orderRefundModel = [HRorderRefundModel getOrderRefundInfo:model.data];
            OrderBackController *vc = [[OrderBackController alloc] init];
            vc.orderRefundModel = orderRefundModel;
            vc.start_city_name = self.start_city_name;
            vc.to_city_name = self.to_city_name;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            
            
            
            [HSToast hsShowBottomWithText:model.msg];
        }
    } failure:^(NSString *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [HSToast hsShowBottomWithText:error];
    }];
}
//申请改签
- (void)orderChange{
    FlightInfoSearchController *vc = [[FlightInfoSearchController alloc] init];
    vc.isPet = self.isPet;
    //NSDate *detaildate = [NSDate dateWithTimeIntervalSince1970:[self.orderModel.take_off_time doubleValue]];
    NSDateComponents *component = [[NSDate date] YMDComponents];
    RMCalendarModel *model = [RMCalendarModel calendarWithYear:component.year month:component.month day:component.day];
    
    CityInfo *startCity = [[CityInfo alloc] init];
    startCity.city_code = self.orderModel.start_city;
    startCity.city_name = self.orderModel.start_city_name;
    
    CityInfo *endCity = [[CityInfo alloc] init];
    endCity.city_code = self.orderModel.to_city;
    endCity.city_name = self.orderModel.to_city_name;
    
    vc.startTime = model;
    vc.endCity = endCity;
    vc.startCity = startCity;
    vc.ride_type = @"1";
    vc.isChange = YES;
    vc.isPet = self.isPet;
    vc.orderno = self.orderModel.orderno;
    [self.navigationController pushViewController:vc animated:YES];
}
//改签详情
-(void)orderChangeDetail{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *url = [HttpNetRequestTool requestUrlString:@"/user/order/changeDetail"];
    NSDictionary *dict = @{@"order_id":self.orderModel.pid};
    [HttpNetRequestTool netRequest:HttpNetRequestPost urlString:url outTime:20 paraments:dict isHeader:YES success:^(id Json) {
        HRLog(@"%@",Json)
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        BaseModel *model = [BaseModel yy_modelWithJSON:Json];
        if (model.code == 1) {
            HRorderChangeModel *orderChangeModel = [HRorderChangeModel getOrderChangeInfo:model.data];
            OrderChangeController *vc = [[OrderChangeController alloc] init];
            vc.orderChangeModel = orderChangeModel;
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
    return 3;
}
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    if (section == 0) {
//        if ([self.orderModel.flight_status integerValue] == -6 ||[self.orderModel.flight_status integerValue] == 10 ||[self.orderModel.flight_status integerValue] == 2 ||[self.orderModel.flight_status integerValue] == -2) {
//            return 1;
//        }else{
//            return 2;
//        }
//    }else if (section == 1){
//        if (self.orderModel.passengers.count <= 0) {
//            return 0;
//        }else{
//            return self.orderModel.passengers.count + 1;
//        }
//    }
//    return 1;
//}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        if ([self.orderModel.order_status integerValue] == 6 ||[self.orderModel.order_status integerValue] == 7 ||[self.orderModel.order_status integerValue] == 2 ||[self.orderModel.order_status integerValue] == 1) {
            return 1;
        }else{
            return 2;
        }
    }else if (section == 1){
        if (self.orderModel.passengers.count <= 0) {
            return 0;
        }else{
            return self.orderModel.passengers.count + 1;
        }
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            static NSString *const infoCellID = @"OrderDetailInfoCell";
            OrderDetailInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:infoCellID];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:infoCellID owner:self options:nil] objectAtIndex:0];
            }
            cell.orderModel = self.orderModel;
            return cell;
        }
        //订单过期 订单关闭 不显示操作按钮
//        if ([self.orderModel.flight_status integerValue] != -6 && [self.orderModel.flight_status integerValue] != 10 && [self.orderModel.flight_status integerValue] != -2 && [self.orderModel.flight_status integerValue] != 2) {
       if ([self.orderModel.order_status integerValue] != 6 && [self.orderModel.order_status integerValue] != 10 && [self.orderModel.order_status integerValue] != 1 && [self.orderModel.order_status integerValue] != 2) {
        if (indexPath.row == 1){
                static NSString *const backCellID = @"OrderDetailChangeCell";
                OrderDetailChangeCell *cell = [tableView dequeueReusableCellWithIdentifier:backCellID];
                if (!cell) {
                    cell = [[[NSBundle mainBundle] loadNibNamed:backCellID owner:self options:nil] objectAtIndex:0];
                }
//                cell.isCompletePayment = [self.orderModel.flight_status integerValue] == -1 ? NO : YES;
//                if ([@[@"-7",@"31",@"32",@"33"] containsObject:self.orderModel.flight_status]) {//退票详情
//                    cell.isCompletePayment = NO;
//                    [cell.repayBtn setTitle:@"退票详情" forState:UIControlStateNormal];
//                }else if ([@[@"-3",@"-4",@"-5"] containsObject:self.orderModel.flight_status]) {//改签详情
//                    cell.isCompletePayment = NO;
//                    [cell.repayBtn setTitle:@"改签详情" forState:UIControlStateNormal];
//                }
            cell.isCompletePayment = [self.orderModel.order_status integerValue] == 0 ? NO : YES;

            if ([@[@"8",@"9",@"10"] containsObject:self.orderModel.order_status]) {//退票详情
                cell.isCompletePayment = NO;
                [cell.repayBtn setTitle:@"退票详情" forState:UIControlStateNormal];
            }else if ([@[@"3",@"4",@"5"] containsObject:self.orderModel.order_status]) {//改签详情
                cell.isCompletePayment = NO;
                [cell.repayBtn setTitle:@"改签详情" forState:UIControlStateNormal];
            }
            __weak typeof(self) weakSelf = self;
                //退票
                cell.backBlock = ^{
                    [weakSelf ticketRefund];
                };
                //改签
                cell.changeBlock = ^{
                    [weakSelf orderChange];
                };
                //重新支付
                cell.repayBlock = ^{
                    [weakSelf orderBackApply];
                };
                return cell;
            }
        }
    }else if (indexPath.section == 1){//乘客信息
        if (indexPath.row == 0) {
            static NSString *const flightCellID = @"HRPassengerInfoTitleCell";
            HRPassengerInfoTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:flightCellID];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:flightCellID owner:self options:nil] objectAtIndex:0];
            }
            return cell;
        }else{
            static NSString *const flightCellID = @"HRPassengerInfoCell";
            HRPassengerInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:flightCellID];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:flightCellID owner:self options:nil] objectAtIndex:0];
            }
            cell.passengerModel = self.orderModel.passengers[indexPath.row - 1];
            return cell;
        }
    }
    static NSString *const flightCellID = @"OrderDetailFlightInfoCell";
    OrderDetailFlightInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:flightCellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:flightCellID owner:self options:nil] objectAtIndex:0];
    }
    cell.orderModel = self.orderModel;
    return cell;
}
#pragma mark --UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 188;
        }
        return 50;
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            return 40;
        }else{
            passengerModel *pModel = self.orderModel.passengers[indexPath.row - 1];
            if (pModel.pet) {
                return 92;
            }
            return 65;
        }
    }
    return 210;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
