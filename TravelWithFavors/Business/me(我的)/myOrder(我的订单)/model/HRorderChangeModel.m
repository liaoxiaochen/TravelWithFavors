//
//  HRorderChangeModel.m
//  TravelWithFavors
//
//  Created by cushiro on 2018/4/20.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "HRorderChangeModel.h"

@implementation ChangeStateModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"pid":@"id"};
}
@end

@implementation HRorderChangeModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"pid":@"id",@"cur":@"new"};
}
+ (HRorderChangeModel *)getOrderChangeInfo:(id)data{
    HRorderChangeModel *model = [HRorderChangeModel yy_modelWithJSON:data];
    model.change_list = [NSArray yy_modelArrayWithClass:[ChangeStateModel class] json:model.change_list];
    return model;
}
/**
 1    等待平台审核(申请状态)
 2    供应商审核处理中
 7    变更通过等待付款(审核状态，该状态时可确认改签并支付或者拒绝，确认改签并支付转为->8支付完成变更处理中，确认拒绝转为->10无法变更)
 8    支付完成变更处理中(->9 变更完毕 || 11无法变更已退款)
 9    变更完毕
 10    无法变更
 11    无法变更已退款
 */
-(NSString *)getChangeStateFromCode{
    switch ([self.changestate integerValue]) {
        case 1:
            return @"等待平台审核";
            break;
        case 2:
            return @"供应商审核处理中";
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
        default:
            return @"等待平台审核";
            break;
    }
}
@end
