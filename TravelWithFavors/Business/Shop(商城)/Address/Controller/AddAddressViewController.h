//
//  AddAddressViewController.h
//  TravelWithFavors
//
//  Created by MacBook on 2018/8/21.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "HDTableViewController.h"
@class AddressInfoModel;

@interface AddAddressViewController : HDTableViewController

@property (nonatomic, assign) BOOL isEidt;
@property (nonatomic, strong) AddressInfoModel *infoModel;
@property (nonatomic, copy) void (^refreshBlock)(void);

@end
