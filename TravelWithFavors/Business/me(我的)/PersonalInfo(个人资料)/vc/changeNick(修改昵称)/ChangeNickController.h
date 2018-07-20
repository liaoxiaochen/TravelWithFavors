//
//  ChangeNickController.h
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/2.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "RootViewController.h"

@interface ChangeNickController : RootViewController
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, copy) void (^refreshBlock)(void);
@end
