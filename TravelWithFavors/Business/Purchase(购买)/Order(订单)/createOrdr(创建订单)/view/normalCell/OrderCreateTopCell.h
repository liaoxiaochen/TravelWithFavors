//
//  OrderCreateTopCell.h
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/6.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlightOrderInfoModel.h"

@interface OrderCreateTopCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceRightLabel;
@property (nonatomic, copy) void (^ruleBlock)(void);

@property (nonatomic, strong) FlightOrderInfoModel *flightOrderInfoModel;
@end
