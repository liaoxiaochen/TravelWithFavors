//
//  HROrderChangeViewController.h
//  TravelWithFavors
//
//  Created by cushiro on 2018/4/13.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "RootViewController.h"
#import "HRorderModel.h"
#import "HRorderChangeModel.h"

@interface HROrderChangeViewController : RootViewController

@property (nonatomic, strong) HRorderModel *orderModel;
@property (nonatomic, strong) HRorderChangeModel *orderChangeModel;
@property (nonatomic, copy) NSString *aircode1;//航班号
@property (nonatomic, strong) NSString *orderno;//改签所需机票订单号
@property (nonatomic, strong) NSString *positionId;//改签所需舱位号
@end
