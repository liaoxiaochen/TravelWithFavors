//
//  PetWeightController.h
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/9.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "RootViewController.h"

@interface PetWeightController : RootViewController
@property (nonatomic, copy) NSString *weight;
@property (nonatomic, copy) void (^weightBlock)(NSString *weight);
@end
