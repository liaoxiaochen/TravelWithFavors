//
//  HDDatePickerView.h
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/4.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HDDatePickerDateModel.h"
@interface HDDatePickerView : UIView
@property (nonatomic, strong) NSDate *minLimitedDate; ///< 最小限制时间；默认值为1970-01-01 00:00
@property (nonatomic, strong) NSDate *maxLimitedDate; ///< 最大限制时间；默认值为2060-12-31 23:59
@property (nonatomic, strong) NSDate *defaultLimitedDate; ///< 默认限制时间；默认值为最小限制时间，当选择时间不在指定范围，就滚动到此默认限制时间
@property (nonatomic, strong) NSDate *scrollToDate; ///< 滚动到指定时间；默认值为当前时间
@property (nonatomic, copy) void (^timeBlocl)(NSString *year, NSString *month, NSString *day);
@end
