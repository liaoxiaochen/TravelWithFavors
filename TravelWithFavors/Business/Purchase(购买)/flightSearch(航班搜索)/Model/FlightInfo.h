//
//  FlightInfo.h
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/14.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlightInfo : NSObject
//"f_number": "MU5416",
//"f_airport1_code": "CTU",
//"f_airport1": "双流国际机场",
//"f_airport2_code": "PVG",
//"f_airport2": "浦东国际机场",
//"f_date1": "2018-03-08",
//"f_time1": "16:55",
//"f_date2": "2018-03-08",
//"f_time2": "20:00",
//"f_length": "185",
//"f_plane_type": "320",
//"f_floor1": "T2",
//"f_floor2": "T1",
//"f_price": "1760",
//"f_company_code": "MU",
//"f_company": "东方航空"
@property (nonatomic, copy) NSString *f_number;
@property (nonatomic, copy) NSString *f_airport1_code;
@property (nonatomic, copy) NSString *f_airport1;
@property (nonatomic, copy) NSString *f_airport2_code;
@property (nonatomic, copy) NSString *f_airport2;
@property (nonatomic, copy) NSString *f_date1;
@property (nonatomic, copy) NSString *f_time1;
@property (nonatomic, copy) NSString *f_date2;
@property (nonatomic, copy) NSString *f_time2;
@property (nonatomic, copy) NSString *f_length;
@property (nonatomic, copy) NSString *f_plane_type;
@property (nonatomic, copy) NSString *f_floor1;
@property (nonatomic, copy) NSString *f_floor2;
@property (nonatomic, copy) NSString *f_price;
@property (nonatomic, copy) NSString *f_company_code;
@property (nonatomic, copy) NSString *f_company;

@property (nonatomic, copy) NSString *pid;
@property (nonatomic, copy) NSString *airline_company_name;
@property (nonatomic, copy) NSString *airport1_name;
@property (nonatomic, copy) NSString *airport2_name;
@property (nonatomic, copy) NSString *arrive_time;
@property (nonatomic, copy) NSString *discount;
@property (nonatomic, copy) NSString *par_price;
@property (nonatomic, copy) NSString *plane_model;
@property (nonatomic, copy) NSString *position_name;
@property (nonatomic, copy) NSString *take_off_time;

@property (nonatomic, copy) NSString *flight_number;
@property (nonatomic, copy) NSString *station1;
@property (nonatomic, copy) NSString *station2;
@property (nonatomic, copy) NSString *set_price;


+ (NSArray *)getFlightInfoLists:(id)data;
@end
