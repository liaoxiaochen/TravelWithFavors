//
//  OrderChangeController.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/7.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "OrderChangeController.h"
#import "OrderChangeTypeCell.h"
#import "OrderChangeFlightInfoCell.h"
#import "OrderChnageTitleCell.h"
#import "ProgressCell.h"
#import "RulePopupView.h"
#import "OrderChangeJourneyCell.h"
#import "OrderChangeTypePetCell.h"
#import "OrderDetailChangeCell.h"
#import "OrderPayController.h"
@interface OrderChangeController ()

/** 标记刷新 */
@property (nonatomic,assign) BOOL updateFlag;
@end

@implementation OrderChangeController

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
    self.navigationItem.title = @"改签详情";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateData) name:@"orderChangePage" object:nil];
}
- (void)ruleAction{
    RulePopupView *view = [[RulePopupView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT)];
    view.headerLabel.text = @"改签规则";
    view.dataLists = @[self.orderChangeModel.cur.change_text];
    [view showPopupView];
}
#pragma mark --UITableViewDataSouce
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        if ([self.orderChangeModel.changestate integerValue] == 7) {
            return 2;
        }
        return 1;
    }
    if (section == 1) {
        return self.orderChangeModel.change_list.count + 1;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            static NSString *const backCellID = @"OrderDetailChangeCell";
            OrderDetailChangeCell *cell = [tableView dequeueReusableCellWithIdentifier:backCellID];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:backCellID owner:self options:nil] objectAtIndex:0];
            }
            cell.isCompletePayment = YES;
            [cell.backBtn setTitle:@"确认" forState:UIControlStateNormal];
            [cell.changeBtn setTitle:@"拒绝" forState:UIControlStateNormal];
            __weak typeof(self) weakSelf = self;
            //确认退票
            cell.backBlock = ^{
                [weakSelf confirmChange:@"1"];
            };
            //拒绝退票
            cell.changeBlock = ^{
                [weakSelf confirmChange:@"0"];
            };
            return cell;
        }else{
            static NSString *const typeCellID = @"OrderChangeTypeCell";
            OrderChangeTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:typeCellID];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:typeCellID owner:self options:nil] objectAtIndex:0];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            __block typeof(self) weakSelf = self;
            cell.ruleBlock = ^{
                if (weakSelf.orderChangeModel.cur.change_text) {
                    [weakSelf ruleAction];
                }
            };
            cell.changeStatusLB.text = [self.orderChangeModel getChangeStateFromCode];
            if ([self.orderChangeModel.changestate integerValue] >= 7) {
                cell.feeTitleLB.hidden = NO;
                cell.feeLB.hidden = NO;
                cell.feeLB.text = [NSString stringWithFormat:@"￥%@",self.orderChangeModel.poundagefee];
            }else{
                cell.feeTitleLB.hidden = YES;
                cell.feeLB.hidden = YES;
            }
            cell.orderNoLB.text = [NSString stringWithFormat:@"订单号：%@",self.orderChangeModel.orderno];
            return cell;
        }
//        if (self.isPet) {
//            static NSString *const typePetCellID = @"OrderChangeTypePetCell";
//            OrderChangeTypePetCell *cell = [tableView dequeueReusableCellWithIdentifier:typePetCellID];
//            if (!cell) {
//                cell = [[[NSBundle mainBundle] loadNibNamed:typePetCellID owner:self options:nil] objectAtIndex:0];
//                cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            }
//            __block typeof(self) weakSelf = self;
//            cell.ruleBlock = ^{
//                [weakSelf ruleAction];
//            };
//            cell.changeStatusLB.text = [self.orderChangeModel getChangeStateFromCode];
//            if ([self.orderChangeModel.changestate integerValue] >= 7) {
//                cell.feeTitleLB.hidden = NO;
//                cell.feeLB.hidden = NO;
//                cell.feeLB.text = [NSString stringWithFormat:@"￥%@",self.orderChangeModel.poundagefee];
//            }else{
//                cell.feeTitleLB.hidden = YES;
//                cell.feeLB.hidden = YES;
//            }
//            cell.orderNoLB.text = [NSString stringWithFormat:@"订单号：%@",self.orderChangeModel.orderno];
//            cell.petNoLB.text = [NSString stringWithFormat:@"宠物编号：%@",self.orderChangeModel.orderno];
//            return cell;
//        }else{
//
//        }
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            static NSString *const titleCellID = @"OrderChnageTitleCell";
            OrderChnageTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:titleCellID];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:titleCellID owner:self options:nil] objectAtIndex:0];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            return cell;
        }
        static NSString *const progressCellID = @"ProgressCell";
        ProgressCell *cell = [tableView dequeueReusableCellWithIdentifier:progressCellID];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:progressCellID owner:self options:nil] objectAtIndex:0];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        ChangeStateModel *model = self.orderChangeModel.change_list[indexPath.row - 1];
        if (indexPath.row == 1) {
            cell.topView.hidden = YES;
            cell.downView.hidden = NO;
        }
        else if (indexPath.row == self.orderChangeModel.change_list.count){
            cell.topView.hidden = NO;
            cell.downView.hidden = YES;
        }
        else{
            cell.topView.hidden = NO;
            cell.downView.hidden = NO;
        }
        if (indexPath.row == 1 && indexPath.row == self.orderChangeModel.change_list.count) {
            cell.topView.hidden = YES;
            cell.downView.hidden = YES;
        }
        cell.typeLabel.text = model.changestatemsg;
        cell.timeLabel.text = [NSDate getDateTime:model.create_at formart:@"yyyy-MM-dd HH:mm"];
        return cell;
    }
    if (self.isJourney) {//废弃  不会有往返
        //往返
        static NSString *const journeyCellID = @"OrderChangeJourneyCell";
        OrderChangeJourneyCell *cell = [tableView dequeueReusableCellWithIdentifier:journeyCellID];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:journeyCellID owner:self options:nil] objectAtIndex:0];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return cell;
    }else{
        static NSString *const infoCellID = @"OrderChangeFlightInfoCell";
        OrderChangeFlightInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:infoCellID];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:infoCellID owner:self options:nil] objectAtIndex:0];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        NSString *oldTimeStr = [NSDate getDateTime:self.orderChangeModel.ago.take_off_time formart:@"MM-dd EEEE HH:mm"];
        cell.oldTimeLB.text = [NSString stringWithFormat:@"%@-%@",oldTimeStr,[NSDate getDateTime:self.orderChangeModel.ago.arrive_time formart:@"HH:mm"]];
        cell.oldPositionLB.text = [NSString stringWithFormat:@"%@ %@%@",self.orderChangeModel.ago.airline_company_name,self.orderChangeModel.ago.flight_number,self.orderChangeModel.ago.position_name];
        
        NSString *curTimeStr = [NSDate getDateTime:self.orderChangeModel.cur.take_off_time formart:@"MM-dd EEEE HH:mm"];
        cell.curTimeLB.text = [NSString stringWithFormat:@"%@-%@",curTimeStr,[NSDate getDateTime:self.orderChangeModel.cur.arrive_time formart:@"HH:mm"]];
        cell.curPositionLB.text = [NSString stringWithFormat:@"%@ %@%@",self.orderChangeModel.cur.airline_company_name,self.orderChangeModel.cur.flight_number,self.orderChangeModel.cur.position_name];
        
        cell.startHMLB.text = [NSString stringWithFormat:@"%@",[NSDate getDateTime:self.orderChangeModel.cur.take_off_time formart:@"HH:mm"]];
        cell.startAirportLB.text = [NSString stringWithFormat:@"%@ %@",self.orderChangeModel.cur.airport1_name,self.orderChangeModel.cur.station1];
        cell.endHMLB.text = [NSString stringWithFormat:@"%@",[NSDate getDateTime:self.orderChangeModel.cur.arrive_time formart:@"HH:mm"]];
        cell.endAirportLB.text = [NSString stringWithFormat:@"%@ %@",self.orderChangeModel.cur.airport2_name,self.orderChangeModel.cur.station2];
        NSInteger total = [self.orderChangeModel.cur.flight_time integerValue];
        NSInteger hour = total/60;
        NSInteger minite = total%60;
        cell.flightDurationLB.text = [NSString stringWithFormat:@"%ld小时%ld分钟",hour,minite];
        return cell;
    }
    
}
#pragma mark ---UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            return 50;
        }
//        if (self.isPet) {
//            return 100;
//        }
        return 80;
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            return 40;
        }
        
        if (indexPath.row == self.orderChangeModel.change_list.count) {
            return 42;
        }
        return 30;
        
    }
    if (self.isJourney) {
        return 316;
    }
    return 274;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

-(void)confirmChange:(NSString *)type{
    NSString *message = @"是否确定支付改签？";
    if ([@"0" isEqualToString:type]) {
        message = @"是否拒绝支付改签？";
    }
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([@"0" isEqualToString:type]) {
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            NSString *url = [HttpNetRequestTool requestUrlString:@"/user/order/cancelChange"];
            NSDictionary *dict = @{@"order_id":self.orderChangeModel.order_id};
            [HttpNetRequestTool netRequest:HttpNetRequestPost urlString:url outTime:20 paraments:dict isHeader:YES success:^(id Json) {
                HRLog(@"%@",Json)
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                BaseModel *model = [BaseModel yy_modelWithJSON:Json];
                if (model.code == 1) {
                    [self updateData];
                }else{
                    [HSToast hsShowBottomWithText:model.msg];
                }
            } failure:^(NSString *error) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [HSToast hsShowBottomWithText:error];
            }];
        }else{
            OrderPayController *vc = [[OrderPayController alloc] init];
            vc.isOrderChangePay = YES;
            vc.totalPrice = [self.orderChangeModel.poundagefee doubleValue];
            vc.changeno = self.orderChangeModel.changeno;
            vc.start_city_name = self.orderChangeModel.cur.start_city_name;
            vc.to_city_name = self.orderChangeModel.cur.to_city_name;
            vc.take_off_time = self.orderChangeModel.cur.take_off_time;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVC addAction:action1];
    [alertVC addAction:cancelAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}

-(void)updateData{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *url = [HttpNetRequestTool requestUrlString:@"/user/order/changeDetail"];
    NSDictionary *dict = @{@"order_id":self.orderChangeModel.order_id ?:@""};
    [HttpNetRequestTool netRequest:HttpNetRequestPost urlString:url outTime:20 paraments:dict isHeader:YES success:^(id Json) {
        HRLog(@"%@",Json)
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        BaseModel *model = [BaseModel yy_modelWithJSON:Json];
        if (model.code == 1) {
            HRorderChangeModel *orderChangeModel = [HRorderChangeModel getOrderChangeInfo:model.data];
            self.orderChangeModel = orderChangeModel;
            [self.tableView reloadData];
            self.updateFlag = YES;
        }else{
            [HSToast hsShowBottomWithText:model.msg];
        }
    } failure:^(NSString *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [HSToast hsShowBottomWithText:error];
    }];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
