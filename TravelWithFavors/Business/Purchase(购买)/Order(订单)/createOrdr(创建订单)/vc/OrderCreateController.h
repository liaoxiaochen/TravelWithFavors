//
//  OrderCreateController.h
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/6.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "HDTableViewController.h"
#import "FlightOrderInfoModel.h"
#import "CityInfo.h"

@interface OrderCreateController : HDTableViewController
@property (nonatomic, assign) BOOL isPet;//是否携带宠物
/** 是否是往返订单 */
@property (nonatomic, assign) BOOL isJourney;
@property (nonatomic, strong) CityInfo *startCity;
@property (nonatomic, strong) CityInfo *endCity;

@property (nonatomic, strong) FlightOrderInfoModel *flightOrderInfoModel;

@end
