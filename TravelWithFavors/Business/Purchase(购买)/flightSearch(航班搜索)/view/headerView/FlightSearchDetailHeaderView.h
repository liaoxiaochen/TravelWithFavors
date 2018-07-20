//
//  FlightSearchDetailHeaderView.h
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/6.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FlightDetailInfo;
@class RMCalendarModel;
@interface FlightSearchDetailHeaderView : UIView
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (nonatomic, strong) FlightDetailInfo *info;
@property (nonatomic, strong) RMCalendarModel *startTime;
@end
