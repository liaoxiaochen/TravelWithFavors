//
//  FlightSearchInfo.h
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/14.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlightInfo.h"
@interface FlightSearchInfo : NSObject
@property (nonatomic, copy) NSString *price;
@property (nonatomic, strong) FlightInfo *go;
@property (nonatomic, strong) FlightInfo *back;


@property (nonatomic, copy) NSString *sid;
@property (nonatomic, copy) NSString *s_take_off_time;
@property (nonatomic, copy) NSString *s_arrive_time;
@property (nonatomic, copy) NSString *s_airport1_name;
@property (nonatomic, copy) NSString *s_airport2_name;
@property (nonatomic, copy) NSString *s_airline_company_name;
@property (nonatomic, copy) NSString *s_plane_model;
@property (nonatomic, copy) NSString *s_start_city;
@property (nonatomic, copy) NSString *s_to_city;
@property (nonatomic, copy) NSString *s_par_price;
@property (nonatomic, copy) NSString *s_position_name;
@property (nonatomic, copy) NSString *s_discount;
@property (nonatomic, copy) NSString *s_flight_number;
@property (nonatomic, copy) NSString *s_station1;
@property (nonatomic, copy) NSString *s_station2;
@property (nonatomic, copy) NSString *s_set_price;

@property (nonatomic, copy) NSString *tid;
@property (nonatomic, copy) NSString *t_take_off_time;
@property (nonatomic, copy) NSString *t_arrive_time;
@property (nonatomic, copy) NSString *t_airport1_name;
@property (nonatomic, copy) NSString *t_airport2_name;
@property (nonatomic, copy) NSString *t_airline_company_name;
@property (nonatomic, copy) NSString *t_plane_model;
@property (nonatomic, copy) NSString *t_start_city;
@property (nonatomic, copy) NSString *t_to_city;
@property (nonatomic, copy) NSString *t_par_price;
@property (nonatomic, copy) NSString *t_position_name;
@property (nonatomic, copy) NSString *t_discount;
@property (nonatomic, copy) NSString *t_flight_number;
@property (nonatomic, copy) NSString *t_station1;
@property (nonatomic, copy) NSString *t_station2;
@property (nonatomic, copy) NSString *t_set_price;

+ (NSArray *)getFlightSearchInfoLists:(id)data;
@end


