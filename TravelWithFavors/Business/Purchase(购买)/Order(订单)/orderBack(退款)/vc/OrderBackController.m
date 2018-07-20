//
//  OrderBackController.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/7.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "OrderBackController.h"
#import "OrderBackTypeCell.h"
#import "OrderBackInfoCell.h"
#import "OrderDetailFlightInfoCell.h"
#import "RulePopupView.h"
#import "OrderChnageTitleCell.h"
#import "ProgressCell.h"
#import "OrderDetailChangeCell.h"

@interface OrderBackController ()

@end

@implementation OrderBackController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"退票详情";
}
#pragma mark --UITableDatasouce
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if ([self.orderRefundModel.refundstate integerValue] >= 3) {
        return 4;
    }
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == ([self.orderRefundModel.refundstate integerValue] >= 3 ? 2 : 1)) {
        return self.orderRefundModel.list.count + 1;
    }
    if (section == ([self.orderRefundModel.refundstate integerValue] == 3 ? 1 : -1)) {
        return 2;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *const typeCellID = @"OrderBackTypeCell";
        OrderBackTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:typeCellID];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:typeCellID owner:self options:nil] objectAtIndex:0];
        }
        WeakObj(self)
        cell.typeLabel.text = [self.orderRefundModel getRefundStateFromCode];
        cell.timeLabel.text = [NSDate getDateTime:self.orderRefundModel.create_at formart:@"yyyy-MM-dd HH:mm"];
        cell.ruleBlock = ^{
            RulePopupView *view = [[RulePopupView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT)];
            view.dataLists = @[weakself.orderRefundModel.flight.refund_text];
            view.headerLabel.text = @"退票规则";
            [view showPopupView];
        };
        return cell;
    }
    if (indexPath.section == ([self.orderRefundModel.refundstate integerValue] >= 3 ? 1 : -1)) {
        if (indexPath.row == 1 && [self.orderRefundModel.refundstate integerValue] == 3) {
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
                [weakSelf confirmRefund:@"1"];
            };
            //拒绝退票
            cell.changeBlock = ^{
                [weakSelf confirmRefund:@"0"];
            };
            return cell;
        }else{
            static NSString *const infoCellID = @"OrderBackInfoCell";
            OrderBackInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:infoCellID];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:infoCellID owner:self options:nil] objectAtIndex:0];
            }
            cell.orderNoLB.text = self.orderRefundModel.orderno;
            cell.orderTotalFeeLB.text = [NSString stringWithFormat:@"￥%@",[NSString stringConversionWithNumber:[self.orderRefundModel.flight.total_price doubleValue]]];
            cell.orderPoundageFeeLB.text = [NSString stringWithFormat:@"￥%@",[NSString stringConversionWithNumber:[self.orderRefundModel.poundagefee doubleValue]]];
            cell.orderRefundFeeLB.text = [NSString stringWithFormat:@"￥%@",[NSString stringConversionWithNumber:[self.orderRefundModel.refundmoney doubleValue]]];
            return cell;
        }
    }
    if (indexPath.section == ([self.orderRefundModel.refundstate integerValue] >= 3 ? 2 : 1)) {
        if (indexPath.row == 0) {
            static NSString *const titleCellID = @"OrderChnageTitleCell";
            OrderChnageTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:titleCellID];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:titleCellID owner:self options:nil] objectAtIndex:0];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.titleLB.text = @"退票进度";
            return cell;
        }
        static NSString *const progressCellID = @"ProgressCell";
        ProgressCell *cell = [tableView dequeueReusableCellWithIdentifier:progressCellID];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:progressCellID owner:self options:nil] objectAtIndex:0];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        RefundStateModel *model = self.orderRefundModel.list[indexPath.row - 1];
        if (indexPath.row == 1) {
            cell.topView.hidden = YES;
            cell.downView.hidden = NO;
        }else if (indexPath.row == self.orderRefundModel.list.count){
            cell.topView.hidden = NO;
            cell.downView.hidden = YES;
        }else{
            cell.topView.hidden = NO;
            cell.downView.hidden = NO;
        }
        if (indexPath.row == 1 && indexPath.row == self.orderRefundModel.list.count) {
            cell.topView.hidden = YES;
            cell.downView.hidden = YES;
        }
        cell.typeLabel.text = model.refundstatemsg;
        cell.timeLabel.text = [NSDate getDateTime:model.create_at formart:@"yyyy-MM-dd HH:mm"];
        return cell;
    }
    static NSString *const flightCellID = @"OrderDetailFlightInfoCell";
    OrderDetailFlightInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:flightCellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:flightCellID owner:self options:nil] objectAtIndex:0];
    }
    cell.orderModel = self.orderRefundModel.flight;
    return cell;
}

#pragma mark --UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 70;
    }
    if (indexPath.section == ([self.orderRefundModel.refundstate integerValue] >= 3 ? 1 : -1)) {
        if (indexPath.row == 1) {
            return 50;
        }
        return 124;
    }
    if (indexPath.section == ([self.orderRefundModel.refundstate integerValue] >= 3 ? 2 : 1)) {
        if (indexPath.row == 0) {
            return 40;
        }
        
        if (indexPath.row == self.orderRefundModel.list.count) {
            return 42;
        }
        return 30;
        
    }
    return 210;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
-(void)confirmRefund:(NSString *)type{
    NSString *message = @"是否确定退票？";
    if ([@"0" isEqualToString:type]) {
        message = @"是否拒绝退票？";
    }
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSString *url = [HttpNetRequestTool requestUrlString:@"/user/order/sureRefund"];
        NSDictionary *dict = @{@"order_id":self.orderRefundModel.order_id,@"checkstate":type};
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
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVC addAction:action1];
    [alertVC addAction:cancelAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}
-(void)updateData{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *url = [HttpNetRequestTool requestUrlString:@"/user/order/refundList"];
    NSDictionary *dict = @{@"order_id":self.orderRefundModel.order_id};
    [HttpNetRequestTool netRequest:HttpNetRequestPost urlString:url outTime:20 paraments:dict isHeader:YES success:^(id Json) {
        HRLog(@"%@",Json)
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        BaseModel *model = [BaseModel yy_modelWithJSON:Json];
        if (model.code == 1) {
            HRorderRefundModel *orderRefundModel = [HRorderRefundModel getOrderRefundInfo:model.data];
            self.orderRefundModel = orderRefundModel;
            [self.tableView reloadData];
        }else{
            [HSToast hsShowBottomWithText:model.msg];
        }
    } failure:^(NSString *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [HSToast hsShowBottomWithText:error];
    }];
}
@end
