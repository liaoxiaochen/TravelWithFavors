//
//  CityInfo.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/14.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "CityInfo.h"

#define kidKey @"id"
#define kcity_nameKey @"city_name"
#define kcountry_nameKey @"country_name"
#define kcity_py_nameKey @"city_py_name"
#define kcity_codeKey @"city_code"
#define kcity_typeKey @"city_type"

@implementation CityInfo

+ (NSArray *)getCityInfoLists:(id)data{
    NSMutableArray *lists = [[NSMutableArray alloc] init];
    if ([data isKindOfClass:[NSArray class]]) {
        for (id obj in data) {
            if ([obj isKindOfClass:[self class]]) {
                [lists addObject:obj];
            }else{
                CityInfo *info = [CityInfo yy_modelWithJSON:obj];
                [lists addObject:info];
            }
        }
    }
    return lists;
}

#pragma mark-NSCoding
-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:_id forKey:kidKey];
    [aCoder encodeObject:_city_name forKey:kcity_nameKey];
    [aCoder encodeObject:_country_name forKey:kcountry_nameKey];
    [aCoder encodeObject:_city_py_name forKey:kcity_py_nameKey];
    [aCoder encodeObject:_city_code forKey:kcity_codeKey];
    [aCoder encodeObject:_city_type forKey:kcity_typeKey];

}


-(id)initWithCoder:(NSCoder *)aDecoder{
    
    if (self == [super init]) {
        _id =  [aDecoder decodeObjectForKey:kidKey];
        _city_name = [aDecoder decodeObjectForKey:kcity_nameKey];
        _country_name =  [aDecoder decodeObjectForKey:kcountry_nameKey];
        _city_py_name =  [aDecoder decodeObjectForKey:kcity_py_nameKey];
        _city_code =  [aDecoder decodeObjectForKey:kcity_codeKey];
        _city_type =  [aDecoder decodeObjectForKey:kcity_typeKey];

    }
    return self;
}

 
@end
