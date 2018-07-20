//
//  FlightDetailInfo.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/14.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "FlightDetailInfo.h"

@implementation FlightDetailInfo
+ (FlightDetailInfo *)getFlightDetailInfoData:(id)data{
    if ([data isKindOfClass:[NSDictionary class]]) {
        if (data[@"to"]) {
            FlightDetailInfo *info = [FlightDetailInfo yy_modelWithJSON:data[@"to"]];
            info.position = [FlightDetailAirInfo getFlightDetailAirInfoLists:info.position];
            return info;
        }else{
            FlightDetailInfo *info = [FlightDetailInfo yy_modelWithJSON:data];
            info.position = [FlightDetailAirInfo getFlightDetailAirInfoLists:info.position];
            return info;
        }
    }
    return nil;
}
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"pid":@"id"};
}
@end
