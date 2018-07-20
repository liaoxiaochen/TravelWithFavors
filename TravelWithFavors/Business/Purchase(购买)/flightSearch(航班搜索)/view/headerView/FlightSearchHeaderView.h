//
//  FlightSearchHeaderView.h
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/6.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RMCalendarModel;
//@protocol FlightSearchHeaderViewDelegate <NSObject>
//- (void)flightSearchHeaderViewSelected:(NSInteger)index;
//@end
@interface FlightSearchHeaderView : UIView
@property (nonatomic, copy) void (^selectedBlock) (NSInteger index,RMCalendarModel *model);
@property (nonatomic, copy) void (^calendarBlock) (void);
@property (nonatomic, strong) RMCalendarModel *dateTime;
@end
