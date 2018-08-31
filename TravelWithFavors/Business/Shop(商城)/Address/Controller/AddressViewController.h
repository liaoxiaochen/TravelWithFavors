//
//  AddressViewController.h
//  TravelWithFavors
//
//  Created by MacBook on 2018/8/21.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "HDTableViewController.h"
@class AddressInfoModel;

@interface AddressViewController : HDTableViewController

@property (nonatomic, copy) void (^selectAdressBlock)(AddressInfoModel *model);

@end
