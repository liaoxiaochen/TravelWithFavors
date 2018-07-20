//
//  HRorderRefundModel.h
//  TravelWithFavors
//
//  Created by cushiro on 2018/4/17.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HRorderModel.h"

@interface RefundStateModel : NSObject
//"refund_id": 1,
//"refundstate": 0,
//"create_at": 234,
//"refundstatemsg": "234234"
@property (nonatomic, copy) NSString *pid;
@property (nonatomic, copy) NSString *refund_id;
@property (nonatomic, copy) NSString *refundstate;
@property (nonatomic, copy) NSString *create_at;
@property (nonatomic, copy) NSString *refundstatemsg;
@end

@interface HRorderRefundModel : NSObject

//"order_id": 6,//订单ID
//"orderno": "T20180410162055521",//订单编号
//"refundno": "T20180410162055521",//退款订单编号
//"create_at": 234234,//创建时间
//"poundagefee": 34,//退款手续费
//"refundmoney": 34,//退款金额
//"update_at": 234234,
//"refundstate": 1,//退票状态码

@property (nonatomic, copy) NSString *pid;
@property (nonatomic, copy) NSString *order_id;
@property (nonatomic, copy) NSString *orderno;
@property (nonatomic, copy) NSString *refundno;
@property (nonatomic, copy) NSString *create_at;
@property (nonatomic, copy) NSString *poundagefee;
@property (nonatomic, copy) NSString *refundmoney;
@property (nonatomic, copy) NSString *update_at;
@property (nonatomic, copy) NSString *refundstate;

@property (nonatomic, strong) HRorderModel *flight;
@property (nonatomic, strong) NSArray<RefundStateModel *> *list;//退票进度
+ (HRorderRefundModel *)getOrderRefundInfo:(id)data;
-(NSString *)getRefundStateFromCode;
@end
