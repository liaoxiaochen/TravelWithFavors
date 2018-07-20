//
//  HRorderRefundModel.m
//  TravelWithFavors
//
//  Created by cushiro on 2018/4/17.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "HRorderRefundModel.h"

@implementation RefundStateModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"pid":@"id"};
}
@end

@implementation HRorderRefundModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"pid":@"id"};
}

+ (HRorderRefundModel *)getOrderRefundInfo:(id)data{
    HRorderRefundModel *model = [HRorderRefundModel yy_modelWithJSON:data];
    model.list = [NSArray yy_modelArrayWithClass:[RefundStateModel class] json:model.list];
    return model;
}
/** 退票状态码
    等待平台审核 = 1,
    供应商审核处理中 = 2,
    审核通过等待退款 = 3,
    已退款 = 4,
    无法退废 = 5,
    退款中 = 6,
    变更通过等待付款 = 7,
    支付完成变更处理中 = 8,
    变更完毕 = 9,
    无法变更 = 10,
    无法变更已退款 = 11,
    退款失败请线下退款 = 12,
    确认退废退款 = 16
**/
-(NSString *)getRefundStateFromCode{
    switch ([self.refundstate integerValue]) {
        case 1:
            return @"等待平台审核";
            break;
        case 2:
            return @"供应商审核处理中";
            break;
        case 3:
            return @"审核通过等待退款";
            break;
        case 4:
            return @"已退款";
            break;
        case 5:
            return @"无法退废";
            break;
        case 6:
            return @"退款中";
            break;
        case 7:
            return @"变更通过等待付款";
            break;
        case 8:
            return @"支付完成变更处理中";
            break;
        case 9:
            return @"变更完毕";
            break;
        case 10:
            return @"无法变更";
            break;
        case 11:
            return @"无法变更已退款";
            break;
        case 12:
            return @"退款失败请线下退款";
            break;
        case 16:
            return @"确认退废退款";
            break;
        default:
            return @"等待平台审核";
            break;
    }
}
@end
