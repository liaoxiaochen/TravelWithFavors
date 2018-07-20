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

@end

@implementation TripMainCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.bgView.layer.cornerRadius = 5;
    self.bgView.layer.masksToBounds = YES;
}

-(void)setOrderModel:(HRorderModel *)orderModel{
    _orderModel = orderModel;
    _timeLabel.text = [NSDate getDateTime:orderModel.take_off_time formart:@"yyyy-MM-dd EEEE"];
    _chineseLabel.text = orderModel.airline_company_name;
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
        _orderTypeLB.textColor = [UIColor colorWithHexString:@"#FF980D"];
        _orderTypeImageView.image = [UIImage imageNamed:@"fan.png"];
    }else{
        _orderTypeLB.text = @"（去）";
        _orderTypeLB.textColor = [UIColor colorWithHexString:@"#5E72AC"];
        _orderTypeImageView.image = [UIImage imageNamed:@"qu.png"];
    }
}

@end
