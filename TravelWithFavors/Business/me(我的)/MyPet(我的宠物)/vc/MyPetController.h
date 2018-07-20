//
//  MyPetController.h
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/4.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "HDTableViewController.h"
@class MyPetInfo;
@interface MyPetController : HDTableViewController
@property (nonatomic, strong) MyPetInfo *petInfo;
@property (nonatomic, copy) void (^refreshPet)(void);
@property (nonatomic, copy) void (^petDataBlock)(MyPetInfo *info);
@end
