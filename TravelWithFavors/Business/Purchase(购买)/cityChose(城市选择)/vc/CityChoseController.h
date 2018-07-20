//
//  CityChoseController.h
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/14.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <WMPageController/WMPageController.h>
@class CityInfo;
@interface CityChoseController : WMPageController
@property (nonatomic, copy) void (^cityBlock)(CityInfo *info);
@end
