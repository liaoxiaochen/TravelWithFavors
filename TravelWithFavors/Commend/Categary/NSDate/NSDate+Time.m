//
//  NSDate+Time.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/13.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "NSDate+Time.h"

@implementation NSDate (Time)
+ (NSString *)getDateTime:(NSString *)time formart:(NSString *)format{
    // iOS 生成的时间戳是10位
    NSTimeInterval interval    =[time doubleValue];
    NSDate *date               = [NSDate dateWithTimeIntervalSince1970:interval];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    NSString *dateString       = [formatter stringFromDate: date];
    return dateString;
}
+ (NSString *)getDate:(NSString *)time formart:(NSString *)format{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    NSDate *date = [formatter dateFromString:time];
    long long ss = [date timeIntervalSince1970];
    return [NSString stringWithFormat:@"%lld",ss];
}
@end
