//
//  PersonalInfoController.h
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/2.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "HDTableViewController.h"
@class PersonalInfo;
@interface PersonalInfoController : HDTableViewController
@property (nonatomic, strong) PersonalInfo *userInfo;
@property (nonatomic, copy) void (^loginOutBlock)(void);
@property (nonatomic, copy) void (^userInfoBlock) (PersonalInfo *info);
@end
