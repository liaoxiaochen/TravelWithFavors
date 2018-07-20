//
//  NSDate+HDCalculateDay.h
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/4.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (HDCalculateDay)
/*!
 *  @brief 获取对应月份的天数
 *
 *  @return 对应月份的天数
 */
- (NSUInteger)fetchDaysOfMonth;
/*!
 *  @brief 获取对应年份的天数
 *
 *  @return 对应年份的天数
 */
- (NSUInteger)fecthDaysOfYear;
/*!
 *  @brief 获取对应月份的第一天时间
 *
 *  @return 对应月份的第一天时间
 */
- (NSDate *)fetchFirstDayOfMonth;
/*!
 *  @brief 获取对应月份的最后一天时间
 *
 *  @return 对应月份的最后一天时间
 */
- (NSDate *)fetchLastDayOfMonth;
/*!
 *  @brief 根据月数和天数间隔，获取间隔后的时间
 *
 *  @param months 月数间隔
 *  @param days   天数间隔
 *
 *  @return 间隔后的时间
 */
- (NSDate *)addMonthAndDay:(NSUInteger)months days:(NSUInteger)days;
/*!
 *  @brief 根据开始时间和结束时间，获取间隔的时间数组
 *
 *  @param toDate 结束时间
 *
 *  @return 间隔的时间数组（月数和天数；toDate-fromDate的比较值是有符号整数NSInteger，所以存在负数的可能）
 */
- (NSArray *)fetchMonthAndDayBetweenTwoDates:(NSDate *)toDate;
/*!
 *  @brief 获取对应周期的数字
 *
 *  @return 对应周期的数字（1：周日、2：周一、3：周二、4：周三、5：周四、6：周五、7：周六）
 */
- (NSInteger)fetchWeekday;
/*!
 *  @brief 根据地区标示符，获取对应周期的名称
 *
 *  @param isShortName      是否是短名称
 *  @param localeIdentifier 地区标示符（中国：zh_CN、美国：en_US）
 *
 *  @return 对应周期的名称
 */
- (NSString *)fetchWeekdayName:(BOOL)isShortName localeIdentifier:(NSString *)localeIdentifier;
/*!
 *  @brief 获取对应周期的中文名称
 *
 *  @param isShortName 是否是短名称
 *
 *  @return 对应周期的中文名称（短名称：周日、周一、周二、周三、周四、周五、周六）（长名称：星期日、星期一、星期二、星期三、星期四、星期五、星期六）
 */
- (NSString *)fetchWeekdayNameCN:(BOOL)isShortName;
/*!
 *  @brief 获取对应周期的英文名称
 *
 *  @param isShortName 是否是短名称
 *
 *  @return 对应周期的英文名称（短名称：Sun、Mon、Tue、Wed、Thu、Fri、Sat）（长名称：Sunday、Monday、Tuesday、Wednesday、Thursday、Friday、Saturday）
 */
- (NSString *)fetchWeekdayNameEN:(BOOL)isShortName;
@end
