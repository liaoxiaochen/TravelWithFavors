//
//  FlightSearchDetailInfo.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/14.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "FlightSearchDetailInfo.h"

@implementation FlightSearchDetailPosition

@end

@implementation FlightSearchDetailInfo
+ (FlightSearchDetailInfo *)getFlightSearchDetailInfoData:(id)data{
    if ([data isKindOfClass:[NSDictionary class]]) {
        FlightSearchDetailInfo *info = [FlightSearchDetailInfo yy_modelWithJSON:data];
        return info;
    }
    return nil;
}
@end

