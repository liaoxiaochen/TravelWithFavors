//
//  TripInfoCell.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/7.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "TripInfoCell.h"

@interface TripInfoCell()
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
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

@property (weak, nonatomic) IBOutlet UILabel *startCounterLB;
@property (weak, nonatomic) IBOutlet UILabel *startCounterTitleLB;
@property (weak, nonatomic) IBOutlet UILabel *boardingGateLB;
@property (weak, nonatomic) IBOutlet UILabel *destinationLB;
@property (weak, nonatomic) IBOutlet UILabel *endCounterLB;
@property (weak, nonatomic) IBOutlet UILabel *endCounterTitleLB;
@end
@implementation TripInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
}
- (void)setFrame:(CGRect)frame{
    frame.origin.x += 10;
    frame.size.width -= 20;
    [super setFrame:frame];
}
-(void)setOrderModel:(HRorderModel *)orderModel{
    _orderModel = orderModel;
    _timeLabel.text = [NSDate getDateTime:orderModel.take_off_time formart:@"HH:mm"];
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
    
    _startCounterLB.text = @"--";
    _boardingGateLB.text = @"--";//(orderModel.station1 ?:@"--");
    _destinationLB.text = @"--";//(orderModel.station2 ?:@"--");
    _endCounterLB.text = @"--";
    
    _typeLabel.text = @"计划";
    _typeTitleLabel.text = @"预计起飞:";
    _typeLeftLabel.text = @"计划";
    _typeRightLabel.text = @"计划";
    
    
}
@end
