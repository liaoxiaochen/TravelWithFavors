//
//  HDDatePickerDateModel.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/4.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "HDDatePickerDateModel.h"
#import "NSDate+HDCalculateDay.h"
@implementation HDDatePickerDateModel
- (instancetype)initWithHSDate:(NSDate *)date {
    if (self = [super init]) {
        NSDateFormatter *formatter = [NSDateFormatter new];
        formatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
        formatter.dateFormat = @"yyyyMMddHHmm";
        NSString *dateStr = [formatter stringFromDate:date];
        
        _year = [dateStr substringWithRange:NSMakeRange(0, 4)];
        _month = [dateStr substringWithRange:NSMakeRange(4, 2)];
        _day = [dateStr substringWithRange:NSMakeRange(6, 2)];
        _weekdayName = [date fetchWeekdayNameCN:YES];
        
    }
    return self;
}
@end
