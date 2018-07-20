//
//  NSDate+Time.h
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/13.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Time)
//时间戳转时间
+ (NSString *)getDateTime:(NSString *)time formart:(NSString *)format;
//时间转时间戳
+ (NSString *)getDate:(NSString *)time formart:(NSString *)format;
@end
