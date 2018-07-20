//
//  CityInfo.h
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/14.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityInfo : NSObject
//"id": 635,
//"city_name": "蚌埠",//城市名字
//"country_name": "中国",//城市所在国家名字
//"city_py_name": "bangbu",//城市拼音
//"city_code": "BFU",//城市三级码
//"city_type": 1//城市类型 1-国内 2-港澳台 3-国际
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *city_name;
@property (nonatomic, copy) NSString *country_name;
@property (nonatomic, copy) NSString *city_py_name;
@property (nonatomic, copy) NSString *city_code;
@property (nonatomic, copy) NSString *city_type;
+ (NSArray *)getCityInfoLists:(id)data;
@end
