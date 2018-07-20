//
//  HDDateHelper.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/4.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "HDDateHelper.h"

@implementation HDDateHelper
+ (NSDate *)fetchLocalDate {
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:date];
    return [date dateByAddingTimeInterval:interval];
}
+ (NSDate *)fetchDateFromString:(NSString *)dateStr withFormat:(NSString *)format {
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    formatter.dateFormat = format ?: @"yyyy-MM-dd HH:mm";
    return [formatter dateFromString:dateStr];
}
+ (NSString *)fecthDateToString:(NSDate *)date withFormat:(NSString *)format {
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    formatter.dateFormat = format ?: @"yyyy-MM-dd HH:mm";
    return [formatter stringFromDate:date];
}
@end
