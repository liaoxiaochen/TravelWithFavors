//
//  OrderChangeController.h
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/7.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "HDTableViewController.h"
#import "HRorderChangeModel.h"
#import "HRorderModel.h"

@interface OrderChangeController : HDTableViewController

@property (nonatomic, assign) BOOL isPet;
@property (nonatomic, assign) BOOL isJourney;

@property (nonatomic, strong) HRorderChangeModel *orderChangeModel;
@end
