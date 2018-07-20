//
//  CityChoseViewController.h
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/15.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "HDTableViewController.h"
@class CityInfo;
@interface CityChoseViewController : HDTableViewController
@property (nonatomic, copy) void (^cityChose)(CityInfo *info);
@property (nonatomic, strong) CityInfo *selectedCity;
@end
