//
//  AddressInfoModel.m
//  TravelWithFavors
//
//  Created by MacBook on 2018/8/28.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "AddressInfoModel.h"

@implementation AddressInfoModel

+ (NSArray *)getAddressInfoList:(id)data {
    NSMutableArray *lists = [[NSMutableArray alloc] init];
    if ([data isKindOfClass:[NSDictionary class]]) {
        if (data[@"address_list"]) {
            for (id obj in data[@"address_list"]) {
                AddressInfoModel *info = [AddressInfoModel yy_modelWithJSON:obj];
                [lists addObject:info];
            }
        }
    }
    return lists;
}

 
@end
