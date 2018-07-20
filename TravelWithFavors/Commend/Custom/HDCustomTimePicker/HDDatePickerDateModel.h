//
//  HDDatePickerDateModel.h
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/4.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HDDatePickerDateModel : NSObject
@property (nonatomic, copy) NSString *year;
@property (nonatomic, copy) NSString *month;
@property (nonatomic, copy) NSString *day;
@property (nonatomic, copy) NSString *weekdayName;

- (instancetype)initWithHSDate:(NSDate *)date;
@end
