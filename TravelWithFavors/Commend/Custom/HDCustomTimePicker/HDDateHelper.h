//
//  HDDateHelper.h
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/4.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HDDateHelper : NSObject
/*!
 *  @brief 获取本地当前时间
 *
 *  @return 本地当前时间
 */
+ (NSDate *)fetchLocalDate;
/*!
 *  @brief 根据时间字符串和其格式，获取对应的时间
 *
 *  @param dateStr 时间字符串
 *  @param format  时间字符串格式（默认值为@"yyyy-MM-dd HH:mm"）
 *
 *  @return 对应的时间
 */
+ (NSDate *)fetchDateFromString:(NSString *)dateStr withFormat:(NSString *)format;
/*!
 *  @brief 根据时间和其格式，获取对应的时间字符串
 *
 *  @param date   时间
 *  @param format 时间字符串格式（默认值为@"yyyy-MM-dd HH:mm"）
 *
 *  @return 对应的时间字符串
 */
+ (NSString *)fecthDateToString:(NSDate *)date withFormat:(NSString *)format;
@end
