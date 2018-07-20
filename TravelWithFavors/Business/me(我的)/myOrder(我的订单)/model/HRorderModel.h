//
//  HRorderModel.h
//  TravelWithFavors
//
//  Created by cushiro on 2018/4/11.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "passengerModel.h"

@interface HRChangeStateModel : NSObject
@property (nonatomic, copy) NSString *pid;
@property (nonatomic, copy) NSString *changeno;
@property (nonatomic, copy) NSString *changestate;
@property (nonatomic, copy) NSString *create_at;
@property (nonatomic, copy) NSString *changestatemsg;
@end

@interface HRorderModel : NSObject

@property (nonatomic, strong) NSArray<passengerModel *> *passengers;
@property (nonatomic, strong) NSArray<HRChangeStateModel *> *change_list;//改签进度

@property (nonatomic, copy) NSString *pid;
@property (nonatomic, copy) NSString *order_number;
@property (nonatomic, copy) NSString *airport1_code;
@property (nonatomic, copy) NSString *airport1_name;
@property (nonatomic, copy) NSString *airport2_code;
@property (nonatomic, copy) NSString *airport2_name;
@property (nonatomic, copy) NSString *take_off_date;
@property (nonatomic, copy) NSString *take_off_time;
@property (nonatomic, copy) NSString *arrive_time;
@property (nonatomic, copy) NSString *flight_time;
@property (nonatomic, copy) NSString *plane_model;
@property (nonatomic, copy) NSString *stop_time;
@property (nonatomic, copy) NSString *has_food;
@property (nonatomic, copy) NSString *machine_build;
@property (nonatomic, copy) NSString *fuel;
@property (nonatomic, copy) NSString *mileage;
@property (nonatomic, copy) NSString *y_price;
@property (nonatomic, copy) NSString *flight_number;
@property (nonatomic, copy) NSString *airline_company_code;
@property (nonatomic, copy) NSString *airline_company_name;
@property (nonatomic, copy) NSString *aerobic;
@property (nonatomic, copy) NSString *station1;
@property (nonatomic, copy) NSString *station2;
@property (nonatomic, copy) NSString *start_city;
@property (nonatomic, copy) NSString *to_city;
@property (nonatomic, copy) NSString *par_price;
@property (nonatomic, copy) NSString *position_code;
@property (nonatomic, copy) NSString *discount;
@property (nonatomic, copy) NSString *set_price;
@property (nonatomic, copy) NSString *rebate;
@property (nonatomic, copy) NSString *total_rebate;
@property (nonatomic, copy) NSString *position_number;
@property (nonatomic, copy) NSString *refund_text;
@property (nonatomic, copy) NSString *change_text;
@property (nonatomic, copy) NSString *change_date_text;
@property (nonatomic, copy) NSString *position_name;
@property (nonatomic, copy) NSString *work_at;
@property (nonatomic, copy) NSString *over_at;
@property (nonatomic, copy) NSString *is_send;
@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *user_type;
@property (nonatomic, copy) NSString *order_status;
@property (nonatomic, copy) NSString *interface_status;
@property (nonatomic, copy) NSString *orderno;
@property (nonatomic, copy) NSString *pnr;
@property (nonatomic, copy) NSString *payprice;
@property (nonatomic, copy) NSString *total_price;
@property (nonatomic, copy) NSString *totaltax;
@property (nonatomic, copy) NSString *ticketprice;
@property (nonatomic, copy) NSString *policynum;
@property (nonatomic, copy) NSString *postprice;
@property (nonatomic, copy) NSString *insuranceprice;
@property (nonatomic, copy) NSString *create_at;
@property (nonatomic, copy) NSString *update_at;
@property (nonatomic, copy) NSString *pay_type;
@property (nonatomic, copy) NSString *comment;
@property (nonatomic, copy) NSString *start_city_name;
@property (nonatomic, copy) NSString *to_city_name;
@property (nonatomic, copy) NSString *flight_status;
@property (nonatomic, copy) NSString *contact;
@property (nonatomic, copy) NSString *over_pay_at;
@property (nonatomic, copy) NSString *i_price;
@property (nonatomic, copy) NSString *order_type;

+ (HRorderModel *)getOrderInfo:(id)data;
-(NSString *)getflightStatusFromCode;
@end
