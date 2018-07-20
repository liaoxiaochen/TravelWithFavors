//
//  FlightSearchDetailInfo.h
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/14.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlightDetailInfo.h"
#import "FlightDetailAirInfo.h"

@interface FlightSearchDetailPosition : NSObject
@property (nonatomic, strong) FlightDetailAirInfo *to;
@property (nonatomic, strong) FlightDetailAirInfo *back;

@end

@interface FlightSearchDetailInfo : NSObject
@property (nonatomic, strong) FlightDetailInfo *to;
@property (nonatomic, strong) FlightDetailInfo *back;
@property (nonatomic, strong) NSArray<FlightSearchDetailPosition *> *position;
+ (FlightSearchDetailInfo *)getFlightSearchDetailInfoData:(id)data;

@end
