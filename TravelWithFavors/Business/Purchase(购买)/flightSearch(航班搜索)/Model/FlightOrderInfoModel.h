//
//  FlightOrderInfoModel.h
//  TravelWithFavors
//
//  Created by cushiro on 2018/4/9.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlightDetailInfoForOrderModel.h"
#import "passengerModel.h"
#import "InsuranceModel.h"
#import "MyPetInfo.h"
@interface FlightOrderInfoModel : NSObject
@property (nonatomic, strong) FlightDetailInfoForOrderModel *to;
@property (nonatomic, strong) FlightDetailInfoForOrderModel *back;
@property (nonatomic, copy) NSString *pet_price;
@property (nonatomic, copy) NSString *pay_odds;
@property (nonatomic, strong) NSArray<passengerModel *> *passenger;
@property (nonatomic, strong) NSArray<MyPetInfo *> *pet;
@property (nonatomic, strong) NSArray *insurance;
@property (nonatomic, copy) NSString *max_passenger_num;
@property (nonatomic, copy) NSString *max_pet_num;
/** 是否是往返订单 */
@property (nonatomic, assign) BOOL isJourney;
@end
