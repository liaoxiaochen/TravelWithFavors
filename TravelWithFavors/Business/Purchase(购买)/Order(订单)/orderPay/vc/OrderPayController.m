//
//  OrderPayController.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/7.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "OrderPayController.h"
#import "OrderPayOneCell.h"//
#import "OrderPayPriceCell.h"
#import "OrderPayCell.h"
#import "OrderPayTypeCell.h"

#import <AlipaySDK/AlipaySDK.h>
#import "APAuthInfo.h"
#import "APOrderInfo.h"
#import "APRSASigner.h"
#import "PurchaseController.h"
#import "HROrderPayResultViewController.h"

@implementation PayResponseModel
@end
@implementation WeChatPayModel
@end

@interface OrderPayController ()
@property (nonatomic, assign) __block BOOL isOpen;
@property (nonatomic, strong) NSArray *payLists;
@end

@implementation OrderPayController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"支付";
}
#pragma mark --UITableViewDataSouce
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.isOpen ? 3 : 2;
    }
    return self.payLists.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            static NSString *const oneCellID = @"OrderPayOneCell";
            OrderPayOneCell *cell = [tableView dequeueReusableCellWithIdentifier:oneCellID];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:oneCellID owner:self options:nil] objectAtIndex:0];
            }
            if (self.orderModel) {//重新支付 接口返回模型
                if (self.isJourney) {
                    cell.routeLB.text = [NSString stringWithFormat:@"往返：%@-%@",self.orderModel.start_city_name,self.orderModel.to_city_name];
                }else{
                    cell.routeLB.text = [NSString stringWithFormat:@"单程：%@-%@",self.orderModel.start_city_name,self.orderModel.to_city_name];
                }

                NSString *totalStr = [NSString stringWithFormat:@"为确保出票，请在%@前完成支付，逾期将自动取消订单。",[NSDate getDateTime:self.orderModel.over_pay_at formart:@"HH:mm"]];
                cell.firstLineLB.attributedText = [NSString changeLabelColorWithMainStr:totalStr diffrenStr:[NSDate getDateTime:self.orderModel.over_pay_at formart:@"HH:mm"] diffrenColor:[UIColor hdMainColor]];

                NSString *time = [NSDate getDateTime:self.orderModel.take_off_time formart:@"yyyy年MM月dd日 HH:mm"];
                cell.dateTimeLB.text = time;
            }else if(self.isOrderChangePay){//改签支付
                cell.routeLB.text = [NSString stringWithFormat:@"单程：%@-%@",self.start_city_name,self.to_city_name];
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"HH:mm"];
                NSString *dateStr = [dateFormatter stringFromDate:[NSDate date]];
//                cell.firstLineLB.text = [NSString stringWithFormat:@"为确保出票，请在%@前完成支付，逾期将自动取消订单。",dateStr];
                
                NSString *totalStr = [NSString stringWithFormat:@"为确保出票，请在%@前完成支付，逾期将自动取消订单。",dateStr];
                cell.firstLineLB.attributedText = [NSString changeLabelColorWithMainStr:totalStr diffrenStr:dateStr diffrenColor:[UIColor hdMainColor]];
                
                NSString *time = [NSDate getDateTime:self.take_off_time formart:@"yyyy年MM月dd日 HH:mm"];
                cell.dateTimeLB.text = time;
            }else{//下单支付 上个页面获取数据
                if (self.isJourney) {
                    cell.routeLB.text = [NSString stringWithFormat:@"往返：%@-%@",self.startCity.city_name,self.endCity.city_name];
                }else{
                    cell.routeLB.text = [NSString stringWithFormat:@"单程：%@-%@",self.startCity.city_name,self.endCity.city_name];
                }
//                cell.firstLineLB.text = [NSString stringWithFormat:@"为确保出票，请在%@前完成支付，逾期将自动取消订单。",[NSDate getDateTime:self.over_pay_at formart:@"HH:mm"]];
                NSString *totalStr = [NSString stringWithFormat:@"为确保出票，请在%@前完成支付，逾期将自动取消订单。",[NSDate getDateTime:self.over_pay_at formart:@"HH:mm"]];
                cell.firstLineLB.attributedText = [NSString changeLabelColorWithMainStr:totalStr diffrenStr:[NSDate getDateTime:self.over_pay_at formart:@"HH:mm"] diffrenColor:[UIColor hdMainColor]];
                
                NSString *time = [NSDate getDateTime:self.dateTime formart:@"yyyy年MM月dd日 HH:mm"];
                cell.dateTimeLB.text = time;
            }
            return cell;
        }
        if (indexPath.row == 1) {
            if (self.isOpen) {
                static NSString *const priceCellID = @"OrderPayPriceCell";
                OrderPayPriceCell *cell = [tableView dequeueReusableCellWithIdentifier:priceCellID];
                if (!cell) {
                    cell = [[[NSBundle mainBundle] loadNibNamed:priceCellID owner:self options:nil] objectAtIndex:0];
                }
                if (self.orderModel) {
                    NSInteger petCount = 0;
                    cell.phoneLB.text = self.orderModel.contact;
                    NSInteger count = self.orderModel.passengers.count;
                    NSMutableString *passengerName = [[NSMutableString alloc] init];
                    for (int i = 0; i<count; i++) {
                        passengerModel *model = self.orderModel.passengers[i];
                        if ([@"1" isEqualToString:model.card_type]) {
                            [passengerName appendString:model.id_card_name];
                        }else{
                            [passengerName appendFormat:@"%@%@",model.surname,model.given_name];
                        }
                        if (i < self.orderModel.passengers.count - 1) {
                            [passengerName appendString:@","];
                        }
                        if (model.pet_id && ![@"0" isEqualToString:model.pet_id] && ![@"" isEqualToString:model.pet_id]) {
                            petCount ++;
                        }
                    }
                    cell.passengerLB.text = passengerName;
                    cell.parPriceLB.text = [NSString stringWithFormat:@"￥%@",[NSString stringConversionWithNumber:[self.orderModel.par_price doubleValue]]];
                    cell.machineBuildPriceLB.text = [NSString stringWithFormat:@"￥%@",[NSString stringConversionWithNumber:[self.orderModel.machine_build doubleValue]]];
                    cell.fuelPriceLB.text = [NSString stringWithFormat:@"￥%@",[NSString stringConversionWithNumber:[self.orderModel.fuel doubleValue]]];
                    cell.insurancePriceLB.text = [NSString stringWithFormat:@"￥%@",[NSString stringConversionWithNumber:[self.orderModel.i_price doubleValue]/count]];
                    
                    cell.parCountLB.text = [NSString stringWithFormat:@"%ld人",count];
                    cell.machineBuilCountLB.text = [NSString stringWithFormat:@"%ld人",count];
                    cell.fuelCountLB.text = [NSString stringWithFormat:@"%ld人",count];
                    cell.insuranceCountLB.text = [NSString stringWithFormat:@"%ld人",count];
                    
                    cell.petPriceLB.text = [NSString stringWithFormat:@"￥%@",[NSString stringConversionWithNumber:50]];//宠物舱单价50这里接口没有返回，固定50元
                    cell.petCountLB.text = [NSString stringWithFormat:@"%ld只",petCount];
                    
                    cell.petViewHeight.constant = (self.isPet > 0 ? 26 : 0);
                    
                }else{
                    cell.phoneLB.text = self.phoneNumber;
                    cell.passengerLB.text = self.passengerNames;
                    cell.parPriceLB.text = [NSString stringWithFormat:@"￥%@",[NSString stringConversionWithNumber:self.parPrice]];
                    cell.machineBuildPriceLB.text = [NSString stringWithFormat:@"￥%@",[NSString stringConversionWithNumber:self.machineBuildPrice]];
                    cell.fuelPriceLB.text = [NSString stringWithFormat:@"￥%@",[NSString stringConversionWithNumber:self.fuelPrice]];
                    cell.insurancePriceLB.text = [NSString stringWithFormat:@"￥%@",[NSString stringConversionWithNumber:self.insurancePrice]];
                    cell.petPriceLB.text = [NSString stringWithFormat:@"￥%@",[NSString stringConversionWithNumber:self.petPrice]];
                    cell.parCountLB.text = [NSString stringWithFormat:@"%ld人",self.parCount];
                    cell.machineBuilCountLB.text = [NSString stringWithFormat:@"%ld人",self.machineBuilCount];
                    cell.fuelCountLB.text = [NSString stringWithFormat:@"%ld人",self.fuelCount];
                    cell.insuranceCountLB.text = [NSString stringWithFormat:@"%ld人",self.insuranceCount];
                    cell.petCountLB.text = [NSString stringWithFormat:@"%ld只",self.petCount];
                    
                    cell.petViewHeight.constant = (self.isPet > 0 ? 26 : 0);
                }
                return cell;
            }
            static NSString *const payCellID = @"OrderPayCell";
            OrderPayCell *cell = [tableView dequeueReusableCellWithIdentifier:payCellID];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:payCellID owner:self options:nil] objectAtIndex:0];
            }
            cell.isOpen = self.isOpen;
            if (self.orderModel) {
                cell.priceLB.text = [NSString stringWithFormat:@"￥%@",[NSString stringConversionWithNumber:[self.orderModel.total_price doubleValue]]];
            }else if(self.isOrderChangePay){
                cell.priceLB.text = [NSString stringWithFormat:@"￥%@",[NSString stringConversionWithNumber:self.totalPrice]];
            }else{
                cell.priceLB.text = [NSString stringWithFormat:@"￥%@",[NSString stringConversionWithNumber:self.totalPrice]];
            }
            cell.detailBtn.hidden = self.isOrderChangePay;
            __block typeof(self) weakSelf = self;
            cell.detailBlock = ^() {
                weakSelf.isOpen = !weakSelf.isOpen;
                //刷新第一区
                NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:0];
                [weakSelf.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
            };
            return cell;
        }
        static NSString *const payCellID = @"OrderPayCell";
        OrderPayCell *cell = [tableView dequeueReusableCellWithIdentifier:payCellID];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:payCellID owner:self options:nil] objectAtIndex:0];
        }
        if (self.orderModel) {
            cell.priceLB.text = [NSString stringWithFormat:@"￥%@",[NSString stringConversionWithNumber:[self.orderModel.total_price doubleValue] afterPoint:2]];
        }else if(self.isOrderChangePay){
            cell.priceLB.text = [NSString stringWithFormat:@"￥%@",[NSString stringConversionWithNumber:self.totalPrice afterPoint:2]];
        }else{
            cell.priceLB.text = [NSString stringWithFormat:@"￥%@",[NSString stringConversionWithNumber:self.totalPrice afterPoint:2]];
        }
        cell.detailBtn.hidden = self.isOrderChangePay;
        __block typeof(self) weakSelf = self;
        cell.detailBlock = ^() {
            weakSelf.isOpen = !weakSelf.isOpen;
            //刷新第一区
            NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:0];
            [weakSelf.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
        };
        return cell;
    }
    //支付方式
    static NSString *const typeCellID = @"OrderPayTypeCell";
    OrderPayTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:typeCellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:typeCellID owner:self options:nil] objectAtIndex:0];
    }
    NSDictionary *dict = self.payLists[indexPath.row];
    cell.typeImageView.image = [UIImage imageNamed:dict[@"image"]];
    cell.typeLabel.text = dict[@"title"];
    return cell;
    
}
#pragma mark --UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 120;
        }
        if (indexPath.row == 1) {
            if (self.isPet) {
                return self.isOpen ? 253 : 64;
            }else{
                return self.isOpen ? (253-26) : 64;
            }
        }
        return 64;
    }
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            //微信
            if (self.isOrderChangePay) {
                [self orderChangePayWithPayType:@"2"];
            }else{
                [self createOrderWithPayType:@"2"];
            }
        }else{
            //支付宝
            if (self.isOrderChangePay) {
                [self orderChangePayWithPayType:@"1"];
            }else{
                [self createOrderWithPayType:@"1"];
            }
            
        }
    }
}
#pragma mark -- lazy load --
- (NSArray *)payLists{
    if (!_payLists) {
        _payLists = @[@{@"title":@"微信支付",@"image":@"weixzf"},@{@"title":@"支付宝支付",@"image":@"zfbzf"}];
    }
    return _payLists;
}
#pragma mark   ==============支付==============
//下单支付和重新支付
-(void)createOrderWithPayType:(NSString *)type{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *url = [HttpNetRequestTool requestUrlString:@"/notify/order/pay"];
    if (self.orderModel) {//重新支付 orderno
        self.order_number = self.orderModel.order_number;
        url = [HttpNetRequestTool requestUrlString:@"/notify/order/pay"];
    }
    NSDictionary *dict = @{@"order_number":self.order_number,@"pay_type":type};
    [HttpNetRequestTool netRequest:HttpNetRequestPost urlString:url outTime:20 paraments:dict isHeader:YES success:^(id Json) {
        HRLog(@"%@",Json)
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        BaseModel *model = [BaseModel yy_modelWithJSON:Json];
        if (model.code == 1) {
            if ([@"1" isEqualToString:type]) {//支付宝支付
                PayResponseModel *payResponseModel = [PayResponseModel yy_modelWithJSON:model.data];
                if (payResponseModel.status) {
                    [self doAPPay:payResponseModel.data];
                }
            }else{//微信支付
                if ([WXApi isWXAppInstalled]) {// 判断手机有没有微信
                    HRLog(@"已经安装了微信...");
                    WeChatPayModel *weChatPayModel = [WeChatPayModel yy_modelWithJSON:model.data];
                    if (weChatPayModel) {
                        [self WXPayWithModel:weChatPayModel];
                    }
                }else{
                    HRLog(@"没有安装微信...");
                    [HSToast hsShowBottomWithText:@"请安装微信客户端"];
                }
            }
        }else{
            [HSToast hsShowBottomWithText:model.msg];
        }
    } failure:^(NSString *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [HSToast hsShowBottomWithText:error];
    }];
}
//改签支付
-(void)orderChangePayWithPayType:(NSString *)type{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *url = [HttpNetRequestTool requestUrlString:@"/notify/order/changePay"];
    NSDictionary *dict = @{@"changeno":self.changeno,@"pay_type":type};
    HRLog(@"dict = %@",dict)
    [HttpNetRequestTool netRequest:HttpNetRequestPost urlString:url outTime:20 paraments:dict isHeader:YES success:^(id Json) {
        HRLog(@"%@",Json)
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        BaseModel *model = [BaseModel yy_modelWithJSON:Json];
        if (model.code == 1) {
            if ([@"1" isEqualToString:type]) {////支付宝支付
                PayResponseModel *payResponseModel = [PayResponseModel yy_modelWithJSON:model.data];
                if (payResponseModel.status) {
                    [self doAPPay:payResponseModel.data];
                }
            }else{//微信支付
                if ([WXApi isWXAppInstalled]) {// 判断手机有没有微信
                    HRLog(@"已经安装了微信...");
                    WeChatPayModel *weChatPayModel = [WeChatPayModel yy_modelWithJSON:model.data];
                    if (weChatPayModel) {
                        [self WXPayWithModel:weChatPayModel];
                    }
                }else{
                    HRLog(@"没有安装微信...");
                    [HSToast hsShowBottomWithText:@"请安装微信客户端"];
                }
            }
        }else{
            [HSToast hsShowBottomWithText:model.msg];
        }
    } failure:^(NSString *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [HSToast hsShowBottomWithText:error];
    }];
}
#pragma mark   ==============支付宝订单支付==============
- (void)doAPPay:(NSString *)orderString{
    WeakObj(self)
    if (orderString != nil) {
        NSString *appScheme = @"TWFAlipay";
        HRLog(@"orderString========%@",orderString)
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
            [weakself aliPayResult:[resultDic objectForKey:@"resultStatus"]];
            
        }];
    }
}
-(void)aliPayResult:(id)resultStatus{
    BOOL flag = false;
    NSString *jumpType = nil;
    NSArray *controllers = [AppConfig currentViewController].navigationController.viewControllers;
    NSMutableArray *tmpArray = [NSMutableArray array];
    if (controllers.count > 1) {
        for (UIViewController *vc in controllers) {
            if ([vc isKindOfClass:[PurchaseController class]]) {
                [tmpArray addObject:vc];
            }
            if ([vc isKindOfClass:[OrderPayController class]]) {
                flag = true;
            }
        }
        if (tmpArray.count > 0) {
            [AppConfig currentViewController].navigationController.viewControllers = tmpArray;
        }else{
            if ([@"1" isEqualToString:jumpType]) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"orderDetailPage" object:nil];
            }else if ([@"2" isEqualToString:jumpType]){
                [[NSNotificationCenter defaultCenter] postNotificationName:@"orderChangePage" object:nil];
            }
        }
    }
    HROrderPayResultViewController *vc = [[HROrderPayResultViewController alloc] init];
    if ([resultStatus integerValue] == 9000) {
        HRLog(@"支付成功")
        vc.result = YES;
    }else{
        HRLog(@"支付出错")
        vc.result = NO;
    }
    if (tmpArray.count <= 0) {
        vc.jumpType = @"2";
        if (flag) {
            [[AppConfig currentViewController].navigationController popViewControllerAnimated:YES];
        }
    }
    vc.hidesBottomBarWhenPushed = YES;
    [[AppConfig currentViewController].navigationController pushViewController:vc animated:YES];
}
#pragma mark   ==============微信订单支付==============
- (void)WXPayWithModel:(WeChatPayModel *)model{
    //需要创建这个支付对象
    PayReq *req = [[PayReq alloc] init];
    //由用户微信号和AppID组成的唯一标识，用于校验微信用户
    //req.openID = model.appid;
    // 商家id，在注册的时候给的
    req.partnerId = model.partnerid;
    // 预支付订单这个是后台跟微信服务器交互后，微信服务器传给你们服务器的，你们服务器再传给你
    req.prepayId = model.prepayid;
    // 根据财付通文档填写的数据和签名
    req.package = model.package;
    // 随机编码，为了防止重复的，在后台生成
    req.nonceStr = model.noncestr;
    // 这个是时间戳，也是在后台生成的，为了验证支付的
    NSString * stamp = model.timestamp;
    req.timeStamp = stamp.intValue;
    // 这个签名也是后台做的
    req.sign = model.sign;
    if ([WXApi sendReq:req]) { //发送请求到微信，等待微信返回onResp
        HRLog(@"调用微信成功...");
    }else{
        HRLog(@"调用微信失败...");
    }
    
}
@end
