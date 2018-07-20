//
//  OrderPayController.h
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/7.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "HDTableViewController.h"
#import "CityInfo.h"
#import "HRorderModel.h"

@interface OrderPayController : HDTableViewController

@property (nonatomic, copy) NSString *order_number;
@property (nonatomic, assign) CGFloat totalPrice;
@property (nonatomic, copy) NSString *dateTime;
@property (nonatomic, copy) NSString *phoneNumber;
@property (nonatomic, copy) NSString *passengerNames;
@property (nonatomic, copy) NSString *over_pay_at;//"over_pay_at"=>132132132

//@property (nonatomic, assign) CGFloat payRate;
/** =========================下单支付所需参数============================ */
@property (nonatomic, assign) CGFloat parPrice;
@property (nonatomic, assign) NSInteger parCount;
@property (nonatomic, assign) CGFloat machineBuildPrice;
@property (nonatomic, assign) NSInteger machineBuilCount;
@property (nonatomic, assign) CGFloat fuelPrice;
@property (nonatomic, assign) NSInteger fuelCount;
@property (nonatomic, assign) CGFloat insurancePrice;
@property (nonatomic, assign) NSInteger insuranceCount;
@property (nonatomic, assign) CGFloat petPrice;
@property (nonatomic, assign) NSInteger petCount;

@property (nonatomic, strong) CityInfo *startCity;
@property (nonatomic, strong) CityInfo *endCity;
@property (nonatomic, assign) BOOL isJourney;

/** =========================改签支付所需参数============================ */
@property (nonatomic, assign) BOOL isOrderChangePay;//改签支付
@property (nonatomic, strong) NSString *changeno;//改签支付单号
@property (nonatomic, strong) NSString *start_city_name;
@property (nonatomic, strong) NSString *to_city_name;
@property (nonatomic, strong) NSString *take_off_time;

/** =========================重新支付所需模型============================ */
@property (nonatomic, strong) HRorderModel *orderModel;


@end

@interface PayResponseModel : NSObject
@property (nonatomic, assign) BOOL status;
@property (nonatomic, copy) NSString *data;
@end

@interface WeChatPayModel : NSObject
@property (nonatomic, copy) NSString *appid;
@property (nonatomic, copy) NSString *partnerid;
@property (nonatomic, copy) NSString *noncestr;
@property (nonatomic, copy) NSString *prepayid;
@property (nonatomic, copy) NSString *package;
@property (nonatomic, copy) NSString *sign;
@property (nonatomic, copy) NSString *timestamp;

@end
