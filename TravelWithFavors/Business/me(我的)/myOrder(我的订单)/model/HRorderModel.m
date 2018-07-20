//
//  HRorderModel.m
//  TravelWithFavors
//
//  Created by cushiro on 2018/4/11.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "HRorderModel.h"

@implementation HRChangeStateModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"pid":@"id"};
}
@end

@implementation HRorderModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"pid":@"id"};
}
+ (HRorderModel *)getOrderInfo:(id)data{
    HRorderModel *model = [HRorderModel yy_modelWithJSON:data];
    if (model.passengers) {
        model.passengers = [NSArray yy_modelArrayWithClass:[passengerModel class] json:model.passengers];
    }
    if (model.change_list) {
        model.change_list = [NSArray yy_modelArrayWithClass:[HRChangeStateModel class] json:model.change_list];
    }
    return model;
}
/**
 -1-待支付 -2-待出票 -3-改签中 -4-改签成功 -5-改签失败 -6-订单过期 -7-退票审核
 0-待确认 1-等待支付 2-等待出票 3-出票完成 10-订单关闭 16-暂不能出票 19-已拒单
 31-退款中 32-退款失败 33-退款成功
 */
-(NSString *)getflightStatusFromCode{
    switch ([self.flight_status integerValue]) {
        case -1:
            return @"等待支付";
            break;
        case -2:
            return @"等待出票";
            break;
        case -3:
            return @"改签中";
            break;
        case -4:
            return @"改签成功";
            break;
        case -5:
            return @"改签失败";
            break;
        case -6:
            return @"订单过期";
            break;
        case -7:
            return @"退票审核";
            break;
        case 0:
            return @"等待处理";
            break;
        case 1:
            return @"等待处理";
            break;
        case 2:
            return @"等待出票";
            break;
        case 3:
            return @"出票完成";
            break;
        case 10:
            return @"订单关闭";
            break;
        case 16:
            return @"暂不能出票";
            break;
        case 19:
            return @"已拒单";
            break;
        case 31:
            return @"退款中";
            break;
        case 32:
            return @"退款失败";
            break;
        case 33:
            return @"退款成功";
            break;
        default:
            return @"待确认";
            break;
    }
}
@end
