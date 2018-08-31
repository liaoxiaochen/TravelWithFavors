//
//  HRmyOrderListTableViewCell.m
//  TravelWithFavors
//
//  Created by cushiro on 2018/4/11.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "HRmyOrderListTableViewCell.h"

@interface HRmyOrderListTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *statusLB;
@property (weak, nonatomic) IBOutlet UILabel *airportCodeLB;
@property (weak, nonatomic) IBOutlet UILabel *stationLB;
@property (weak, nonatomic) IBOutlet UILabel *startDateTimeLB;
@property (weak, nonatomic) IBOutlet UILabel *endDateTimeLB;
@property (weak, nonatomic) IBOutlet UILabel *priceLB;
@property (weak, nonatomic) IBOutlet UILabel *orderTypeLB;

@end

@implementation HRmyOrderListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.statusLB.layer.cornerRadius = self.statusLB.height/2;
    self.statusLB.layer.borderWidth = 1;
    self.statusLB.layer.borderColor = [UIColor colorWithHexString:@"#333333"].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setOrderModel:(HRorderModel *)orderModel{
    _orderModel = orderModel;
    _airportCodeLB.text = [NSString stringWithFormat:@"%@ %@",orderModel.airline_company_name,orderModel.flight_number];
    _stationLB.text = [NSString stringWithFormat:@"%@——%@",orderModel.start_city_name,orderModel.to_city_name];
    
    NSString *startHM = [NSDate getDateTime:orderModel.take_off_time formart:@"HH:mm"];
    NSString *startYMD = [NSDate getDateTime:orderModel.take_off_time formart:@"yyyy-MM-dd"];
    _startDateTimeLB.text = [NSString stringWithFormat:@"%@ %@%@ -- %@",startHM,orderModel.airport1_name,orderModel.station1,startYMD];
    
    NSString *endHM = [NSDate getDateTime:orderModel.arrive_time formart:@"HH:mm"];
    NSString *endYMD = [NSDate getDateTime:orderModel.arrive_time formart:@"yyyy-MM-dd"];
    _endDateTimeLB.text = [NSString stringWithFormat:@"%@ %@%@ -- %@",endHM,orderModel.airport2_name,orderModel.station2,endYMD];
    
    _priceLB.text = [NSString stringWithFormat:@"￥%@",[NSString stringConversionWithNumber:[orderModel.total_price doubleValue]]];//??????
//    _statusLB.text = [NSString stringWithFormat:@"  %@  ",[orderModel getflightStatusFromCode]];
    
    _statusLB.text = [NSString stringWithFormat:@"  %@  ",[orderModel getOrderStatusFromCode]];

    if ([@"2" isEqualToString:orderModel.order_type]) {
        _orderTypeLB.text = @"（返）";
        _orderTypeLB.textColor = [UIColor hdMainColor];
    }else{
        _orderTypeLB.text = @"（去）";
        _orderTypeLB.textColor = [UIColor colorWithHexString:@"#5E72AC"];
    }
}

@end
