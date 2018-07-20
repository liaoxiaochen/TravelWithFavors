//
//  FlightInfo.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/14.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "FlightInfo.h"

@implementation FlightInfo
+ (NSArray *)getFlightInfoLists:(id)data{
    NSMutableArray *lists = [[NSMutableArray alloc] init];
    if ([data isKindOfClass:[NSArray class]]) {
        for (id obj in data) {
            if ([obj isKindOfClass:[self class]]) {
                [lists addObject:obj];
            }else{
                FlightInfo *info = [FlightInfo yy_modelWithJSON:obj];
                [lists addObject:info];
            }
        }
    }
    return lists;
}
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"pid":@"id"};
}
@end
