//
//  OrderDetailInfoController.h
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/7.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "HDTableViewController.h"
#import "HRorderModel.h"

@interface OrderDetailInfoController : HDTableViewController
@property (nonatomic, assign) BOOL isPet;
@property (nonatomic, assign) BOOL isJourney;
@property (nonatomic, strong) HRorderModel *orderModel;

@property (nonatomic, copy) NSString *start_city_name;
@property (nonatomic, copy) NSString *to_city_name;

@end
