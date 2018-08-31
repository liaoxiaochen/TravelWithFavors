//
//  RangePickerViewController.h
//  FSCalendar
//
//  Created by dingwenchao on 5/8/16.
//  Copyright © 2016 Wenchao Ding. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RMCalendarModel;

typedef void (^CalendarRangePickBlock)(NSMutableDictionary *dic);

@interface RangePickerViewController : UIViewController

@property(nonatomic, copy) CalendarRangePickBlock calendarRangeBlock;

@property (nonatomic, assign) BOOL isBackTracking;


@property (nonatomic, strong) RMCalendarModel *nowSelectComeDateModel;
@property (nonatomic, strong) RMCalendarModel *nowSelectBackDateModel;

@end
