//
//  MyPetInfo.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/13.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "MyPetInfo.h"

@implementation MyPetInfo
+ (NSArray *)getMyPetInfoLists:(id)data{
    NSMutableArray *lists = [[NSMutableArray alloc] init];
    if ([data isKindOfClass:[NSArray class]]) {
        for (id obj in data) {
            if ([obj isKindOfClass:[self class]]) {
                [lists addObject:obj];
            }else{
                MyPetInfo *info = [MyPetInfo yy_modelWithJSON:obj];
                [lists addObject:info];
            }
        }
    }
    return lists;
}
@end
