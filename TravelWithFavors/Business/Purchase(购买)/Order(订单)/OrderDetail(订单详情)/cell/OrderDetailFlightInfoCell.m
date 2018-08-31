//
//  OrderDetailFlightInfoCell.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/7.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "OrderDetailFlightInfoCell.h"

@interface OrderDetailFlightInfoCell()
@property (weak, nonatomic) IBOutlet UILabel *dateTimeLB;
@property (weak, nonatomic) IBOutlet UILabel *stationLB;
@property (weak, nonatomic) IBOutlet UILabel *positionLB;
@property (weak, nonatomic) IBOutlet UILabel *startTimeLB;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLB;
@property (weak, nonatomic) IBOutlet UILabel *startAirportNameLB;
@property (weak, nonatomic) IBOutlet UILabel *endAirportNameLB;

@end
@implementation OrderDetailFlightInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setOrderModel:(HRorderModel *)orderModel{
    _orderModel = orderModel;
    _dateTimeLB.text = [NSDate getDateTime:orderModel.take_off_time formart:@"yyyy-MM-dd"];
    _stationLB.text = [NSString stringWithFormat:@"%@——%@",orderModel.start_city_name,orderModel.to_city_name];
    _positionLB.text = [NSString stringWithFormat:@"%@ %@ %@ %@",
                        orderModel.airline_company_name,orderModel.flight_number,
                        orderModel.position_name,orderModel.plane_model];
    _startTimeLB.text = [NSDate getDateTime:orderModel.take_off_time formart:@"HH:mm"];
    _endTimeLB.text = [NSDate getDateTime:orderModel.arrive_time formart:@"HH:mm"];
    _startAirportNameLB.text = [NSString stringWithFormat:@"%@%@",orderModel.airport1_name,orderModel.station1];
    _endAirportNameLB.text = [NSString stringWithFormat:@"%@%@",orderModel.airport2_name,orderModel.station2];
}

- (void)setStart_city_name:(NSString *)start_city_name {
    _start_city_name = start_city_name;
}
- (void)setTo_city_name:(NSString *)to_city_name {
    _to_city_name = to_city_name;
    _stationLB.text = [NSString stringWithFormat:@"%@——%@",_start_city_name,_to_city_name];

}

@end
