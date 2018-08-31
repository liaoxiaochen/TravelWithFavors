//
//  TripMainCell.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/6.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "TripMainCell.h"

@interface TripMainCell()

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *chineseLabel;
@property (weak, nonatomic) IBOutlet UILabel *englishLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftPlaceLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightPlaceLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLeftLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeRightLabel;
@property (weak, nonatomic) IBOutlet UILabel *goTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *downTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLeftLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeRightLabel;

@property (weak, nonatomic) IBOutlet UILabel *orderTypeLB;
@property (weak, nonatomic) IBOutlet UIImageView *orderTypeImageView;

@property (weak, nonatomic) IBOutlet UILabel *orderStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *petLabel;


@end

@implementation TripMainCell


 - (void)awakeFromNib {
    [super awakeFromNib];
     
     self.bgView.size = CGSizeMake([UIScreen mainScreen].bounds.size.width - 20, 170);
      [UIView addShadowToView:self.bgView withOpacity:0.8 shadowRadius:3 andCornerRadius:5];
}

-(void)setOrderModel:(HRorderModel *)orderModel{
    _orderModel = orderModel;
    _timeLabel.text = [NSDate getDateTime:orderModel.take_off_time formart:@"yyyy-MM-dd EEEE"];
    _chineseLabel.text = [NSString stringWithFormat:@"%@%@", orderModel.airline_company_name, orderModel.flight_number];
    _englishLabel.text = @"";
    
    _leftLabel.text = orderModel.airport1_code;
    _leftPlaceLabel.text = [NSString stringWithFormat:@"%@%@",orderModel.airport1_name,orderModel.station1];
    _goTimeLabel.text = [NSDate getDateTime:orderModel.take_off_time formart:@"HH:mm"];
    _timeLeftLabel.text = [NSDate getDateTime:orderModel.take_off_time formart:@"计划 MM月dd日 HH:mm"];
    
    _rightLabel.text = orderModel.airport2_code;
    _rightPlaceLabel.text = [NSString stringWithFormat:@"%@%@",orderModel.airport2_name,orderModel.station2];
    _downTimeLabel.text = [NSDate getDateTime:orderModel.arrive_time formart:@"HH:mm"];
    _timeRightLabel.text = [NSDate getDateTime:orderModel.arrive_time formart:@"计划 MM月dd日 HH:mm"];
    
    _orderTypeImageView.hidden = YES;
    if ([@"2" isEqualToString:orderModel.order_type]) {
        _orderTypeLB.text = @"（返）";
        _orderTypeLB.textColor = [UIColor hdMainColor];
        _orderTypeImageView.image = [UIImage imageNamed:@"fan.png"];
    }else{
        _orderTypeLB.text = @"（去）";
        _orderTypeLB.textColor = [UIColor colorWithHexString:@"#5E72AC"];
        _orderTypeImageView.image = [UIImage imageNamed:@"qu.png"];
    }
    if ([orderModel.order_status integerValue] == 0 || [orderModel.order_status integerValue] == 1 || [orderModel.order_status integerValue] == 2) {
        _orderStatusLabel.textColor = [UIColor hdMainColor];
    }else {
        _orderStatusLabel.textColor = [UIColor hdTextColor];
    }
    _orderStatusLabel.text = [NSString stringWithFormat:@"-%@-",[orderModel getOrderStatusFromCode]];
    if ([orderModel.have_pet integerValue]) {
        _petLabel.hidden = NO;
    }else {
        _petLabel.hidden = YES;
    }
    
    
}

@end
