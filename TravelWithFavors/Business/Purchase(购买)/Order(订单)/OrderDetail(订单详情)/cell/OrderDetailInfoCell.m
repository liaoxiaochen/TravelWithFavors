//
//  OrderDetailInfoCell.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/7.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "OrderDetailInfoCell.h"

@interface OrderDetailInfoCell()
@property (weak, nonatomic) IBOutlet UILabel *priceLB;
@property (weak, nonatomic) IBOutlet UILabel *orderNumberLB;
@property (weak, nonatomic) IBOutlet UILabel *orderDateTimeLB;
@property (weak, nonatomic) IBOutlet UILabel *statusLB;
@property (weak, nonatomic) IBOutlet UILabel *payTypeLB;

@end
@implementation OrderDetailInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setOrderModel:(HRorderModel *)orderModel{
    _orderModel = orderModel;
    _priceLB.text = [NSString stringWithFormat:@"￥%@",[NSString stringConversionWithNumber:[orderModel.total_price doubleValue]]];//??????????
    _orderNumberLB.text = orderModel.orderno;
    _orderDateTimeLB.text = [NSDate getDateTime:orderModel.create_at formart:@"yyyy-MM-dd HH:mm"];
    _statusLB.text = [orderModel getflightStatusFromCode];
    if ([@"2" isEqualToString:orderModel.pay_type]) {
        _payTypeLB.text = @"微信";
    }else if([@"1" isEqualToString:orderModel.pay_type]){
        _payTypeLB.text = @"支付宝";
    }else{
        _payTypeLB.text = @"";
    }
    
}
@end
