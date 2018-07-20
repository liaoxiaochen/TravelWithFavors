//
//  FlightInfoSearchController.h
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/6.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "HDTableViewController.h"
#import "FlightInfo.h"
@class CityInfo;
@class RMCalendarModel;
@interface FlightInfoSearchController : HDTableViewController
@property (nonatomic, assign) BOOL isPet;//是否带宠物
@property (nonatomic, strong) CityInfo *startCity;
@property (nonatomic, strong) CityInfo *endCity;
@property (nonatomic, strong) RMCalendarModel *startTime;
@property (nonatomic, strong) RMCalendarModel *endTime;

@property (nonatomic, copy) NSString *journeyEndTime;//返程需要传的参数

@property (nonatomic, assign) BOOL isChange;//是否是改签
@property (nonatomic, strong) NSString *orderno;//改签所需机票订单号
/** 1-单程 2-往返去 3-往返回 */
@property (nonatomic, assign) NSString *ride_type;
/** 往返去程选择数据 */
@property (nonatomic, strong) FlightInfo *to_flightInfo;

@end
