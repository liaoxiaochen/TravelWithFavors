//
//  FlightSearchDetailController.h
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/6.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "HDTableViewController.h"
@class CityInfo;
@class RMCalendarModel;
@interface FlightSearchDetailController : HDTableViewController
@property (nonatomic, assign) BOOL isPet;//是否带宠物
@property (nonatomic, strong) CityInfo *startCity;
@property (nonatomic, strong) CityInfo *endCity;
@property (nonatomic, strong) RMCalendarModel *startTime;
@property (nonatomic, copy) NSString *aircode1;//航班号
@property (nonatomic, assign) BOOL isChange;//是否是改签
@property (nonatomic, strong) NSString *orderno;//改签所需机票订单号
@end
