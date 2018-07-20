//
//  ChineseCityController.h
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/14.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "RootViewController.h"
@class CityInfo;
@interface ChineseCityController : RootViewController
@property (nonatomic, copy) void (^cityChose)(CityInfo *info);
@end
