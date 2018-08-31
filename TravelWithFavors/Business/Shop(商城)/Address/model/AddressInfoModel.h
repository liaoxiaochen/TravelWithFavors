//
//  AddressInfoModel.h
//  TravelWithFavors
//
//  Created by MacBook on 2018/8/28.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressInfoModel : NSObject

@property (nonatomic, copy) NSString *address_id;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *area;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *is_default;

@property (nonatomic, copy) NSString *province_id;
@property (nonatomic, copy) NSString *city_id;
@property (nonatomic, copy) NSString *area_id;


+ (NSArray *)getAddressInfoList:(id)data;
 
@end
