//
//  FlightDetailInfoForOrderModel.h
//  TravelWithFavors
//
//  Created by cushiro on 2018/4/9.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlightDetailAirInfo.h"

@interface FlightDetailInfoForOrderModel : NSObject
@property (nonatomic, strong) FlightDetailAirInfo *position;

@property (nonatomic, copy) NSString *pid;
@property (nonatomic, copy) NSString *aerobic;
@property (nonatomic, copy) NSString *airline_company_code;
@property (nonatomic, copy) NSString *airline_company_name;
@property (nonatomic, copy) NSString *airport1_code;
@property (nonatomic, copy) NSString *airport1_name;
@property (nonatomic, copy) NSString *airport2_code;
@property (nonatomic, copy) NSString *airport2_name;
@property (nonatomic, copy) NSString *arrive_time;
@property (nonatomic, copy) NSString *flight_time;
@property (nonatomic, copy) NSString *flight_number;
@property (nonatomic, copy) NSString *fuel;
@property (nonatomic, copy) NSString *has_food;
@property (nonatomic, copy) NSString *machine_build;
@property (nonatomic, copy) NSString *mileage;
@property (nonatomic, copy) NSString *plane_model;
@property (nonatomic, copy) NSString *start_city;
@property (nonatomic, copy) NSString *station1;
@property (nonatomic, copy) NSString *station2;
@property (nonatomic, copy) NSString *stop_time;
@property (nonatomic, copy) NSString *take_off_date;
@property (nonatomic, copy) NSString *take_off_time;
@property (nonatomic, copy) NSString *to_city;
@property (nonatomic, copy) NSString *y_price;
@end
