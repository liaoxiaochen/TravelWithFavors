//
//  FlightSearchJourneyDetailCell.h
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/6.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlightSearchDetailInfo.h"

@interface FlightSearchJourneyDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *rightBgView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *journeyTipsLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttomLayout;
//规则
@property (nonatomic, copy) void (^ruleBlock)(void);
@property (nonatomic, copy) void (^orderBlock)(void);
@property (nonatomic, strong) FlightDetailAirInfo *airInfo;
@property (nonatomic, strong) FlightSearchDetailPosition *info;//往返
@end
