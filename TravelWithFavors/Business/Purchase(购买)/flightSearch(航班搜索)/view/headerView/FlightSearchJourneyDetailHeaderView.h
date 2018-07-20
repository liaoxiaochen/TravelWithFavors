//
//  FlightSearchJourneyDetailHeaderView.h
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/6.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlightDetailInfo.h"
#import "RMCalendarModel.h"
@interface FlightSearchJourneyDetailHeaderView : UIView

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (nonatomic, strong) FlightDetailInfo *to;
@property (nonatomic, strong) FlightDetailInfo *back;
@property (nonatomic, strong) RMCalendarModel *toTime;
@property (nonatomic, strong) RMCalendarModel *backTime;
@end
