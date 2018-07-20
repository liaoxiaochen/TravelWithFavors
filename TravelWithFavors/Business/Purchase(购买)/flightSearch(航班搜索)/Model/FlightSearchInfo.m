//
//  FlightSearchInfo.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/14.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "FlightSearchInfo.h"

@implementation FlightSearchInfo
+ (NSArray *)getFlightSearchInfoLists:(id)data{
    NSMutableArray *lists = [[NSMutableArray alloc] init];
    if ([data isKindOfClass:[NSArray class]]) {
        for (id obj in data) {
            FlightSearchInfo *info = [FlightSearchInfo yy_modelWithJSON:obj];
            [lists addObject:info];
        }
    }
    return lists;
}
@end

