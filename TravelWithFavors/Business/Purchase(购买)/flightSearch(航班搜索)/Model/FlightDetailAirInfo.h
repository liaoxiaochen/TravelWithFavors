//
//  FlightDetailAirInfo.h
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/14.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlightDetailAirInfo : NSObject
//"face_price": "1300",
//"pos_code": "K",
//"discount": "74",
//"last_price": "1300",
//"back_score": "0",
//"total_back_score": "0",
//"surplus_pos": "4",
//"tui_id": "2",
//"tui_text": [
//             "取消座位时间计算手续费;按照当前舱位票面价收取退票费;起飞前2.0小时（含）以外收取当前舱位票面价的30.0%退票费,起飞前2.0小时以内及起飞后收取当前舱位票面价的50.0%退票费;",
//             "按照当前舱位票面价收取变更费;起飞前2.0小时（含）以外收取当前舱位票面价的20.0%改期费,起飞前2.0小时以内及起飞后收取当前舱位票面价的30.0%改期费;",
//             "不能改签;"
//             ],
//"work_at": "08:00-21:50",
//"refund_at": "08:00-21:30",
//"air_name": "经济舱"
@property (nonatomic, copy) NSString *face_price;
@property (nonatomic, copy) NSString *pos_code;
@property (nonatomic, copy) NSString *discount;//
@property (nonatomic, copy) NSString *last_price;
@property (nonatomic, copy) NSString *back_score;
@property (nonatomic, copy) NSString *total_back_score;
@property (nonatomic, copy) NSString *surplus_pos;
@property (nonatomic, copy) NSString *tui_id;
@property (nonatomic, strong) NSArray *tui_text;
@property (nonatomic, copy) NSString *work_at;//
@property (nonatomic, copy) NSString *refund_at;
@property (nonatomic, copy) NSString *air_name;


@property (nonatomic, copy) NSString *pid;
@property (nonatomic, copy) NSString *flight_number;
@property (nonatomic, copy) NSString *par_price;
@property (nonatomic, copy) NSString *position_code;
@property (nonatomic, copy) NSString *set_price;
@property (nonatomic, copy) NSString *rebate;
@property (nonatomic, copy) NSString *total_rebate;
@property (nonatomic, copy) NSString *position_number;
@property (nonatomic, copy) NSString *refund_text;
@property (nonatomic, copy) NSString *change_text;
@property (nonatomic, copy) NSString *change_date_text;
@property (nonatomic, copy) NSString *take_off_date;
@property (nonatomic, copy) NSString *position_name;
@property (nonatomic, copy) NSString *over_at;
+ (NSArray *)getFlightDetailAirInfoLists:(id)data;
@end
