//
//  FlightSearchJourneyController.h
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/6.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "HDTableViewController.h"
@class CityInfo;
@class RMCalendarModel;
@interface FlightSearchJourneyController : HDTableViewController
@property (nonatomic, assign) BOOL isPet;//是否带宠物
@property (nonatomic, strong) CityInfo *startCity;
@property (nonatomic, strong) CityInfo *endCity;
@property (nonatomic, strong) RMCalendarModel *startTime;
@property (nonatomic, strong) RMCalendarModel *endTime;
@end
