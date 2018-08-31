//
//  OrderDetailFlightInfoCell.h
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/7.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HRorderModel.h"

@interface OrderDetailFlightInfoCell : UITableViewCell

@property (nonatomic, strong) HRorderModel *orderModel;

@property (nonatomic, strong) NSString*start_city_name;
@property (nonatomic, strong) NSString *to_city_name;

@end
