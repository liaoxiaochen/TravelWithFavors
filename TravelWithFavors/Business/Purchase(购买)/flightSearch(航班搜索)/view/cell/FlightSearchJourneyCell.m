//
//  FlightSearchJourneyCell.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/6.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "FlightSearchJourneyCell.h"
#import "FlightSearchInfo.h"
@interface FlightSearchJourneyCell ()
@property (weak, nonatomic) IBOutlet UILabel *topLeftLabel;
@property (weak, nonatomic) IBOutlet UILabel *topRightLabel;
@property (weak, nonatomic) IBOutlet UILabel *topPlaceLeftLabel;
@property (weak, nonatomic) IBOutlet UILabel *topPlaceRightLabel;
@property (weak, nonatomic) IBOutlet UILabel *topLabel;
@property (weak, nonatomic) IBOutlet UILabel *topPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *topDetailLabel;
@property (weak, nonatomic) IBOutlet UILabel *downLeftLabel;
@property (weak, nonatomic) IBOutlet UILabel *downRightLabel;
@property (weak, nonatomic) IBOutlet UILabel *downPlaceLeftLabel;
@property (weak, nonatomic) IBOutlet UILabel *downPlaceRightLabel;
@property (weak, nonatomic) IBOutlet UILabel *downLabel;
@property (weak, nonatomic) IBOutlet UILabel *downPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *downDetailLabel;
@end
@implementation FlightSearchJourneyCell

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
- (void)setInfo:(FlightSearchInfo *)info{
    _info = info;
    CGFloat s_totalPrice = [info.s_par_price doubleValue];
    NSString *s_string = [NSString stringWithFormat:@"￥%@",[NSString stringConversionWithNumber:s_totalPrice]];
    NSMutableAttributedString *s_att = [[NSMutableAttributedString alloc] initWithString:s_string];
    [s_att addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12.0f] range:NSMakeRange(0, 1)];
    [s_att addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18.0f] range:NSMakeRange(1, s_string.length - 1)];
    self.topPriceLabel.attributedText = s_att;
    self.topLeftLabel.text = [NSDate getDateTime:info.s_take_off_time formart:@"HH:mm"];
    self.topRightLabel.text = [NSDate getDateTime:info.s_arrive_time formart:@"HH:mm"];
    self.topPlaceLeftLabel.text = [NSString stringWithFormat:@"%@%@",info.s_airport1_name,info.s_station1];
    self.topPlaceRightLabel.text = [NSString stringWithFormat:@"%@%@",info.s_airport2_name,info.s_station2];
    self.topLabel.text = [NSString stringWithFormat:@"%@%@ %@",info.s_airline_company_name,info.s_flight_number,info.s_plane_model];
    
    CGFloat t_totalPrice = [info.t_par_price doubleValue];
    NSString *t_string = [NSString stringWithFormat:@"￥%@",[NSString stringConversionWithNumber:t_totalPrice]];
    NSMutableAttributedString *t_att = [[NSMutableAttributedString alloc] initWithString:t_string];
    [t_att addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12.0f] range:NSMakeRange(0, 1)];
    [t_att addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18.0f] range:NSMakeRange(1, t_string.length - 1)];
    self.downPriceLabel.attributedText = t_att;
    self.downLeftLabel.text = [NSDate getDateTime:info.t_take_off_time formart:@"HH:mm"];
    self.downRightLabel.text = [NSDate getDateTime:info.t_arrive_time formart:@"HH:mm"];
    self.downPlaceLeftLabel.text = [NSString stringWithFormat:@"%@%@",info.t_airport1_name,info.t_station1];
    self.downPlaceRightLabel.text = [NSString stringWithFormat:@"%@%@",info.t_airport2_name,info.t_station2];
    self.downLabel.text = [NSString stringWithFormat:@"%@%@ %@",info.t_airline_company_name,info.t_flight_number,info.t_plane_model];
    
    
    CGFloat s_discount = [info.s_discount integerValue] * 0.1;
    if (s_discount == 10) {
        self.topDetailLabel.text = [NSString stringWithFormat:@"%@全价",info.s_position_name];
    }else if (s_discount > 10){
        self.topDetailLabel.text = [NSString stringWithFormat:@"%@",info.s_position_name];
    }else{
        self.topDetailLabel.text = [NSString stringWithFormat:@"%@%0.1lf折",info.s_position_name,s_discount];
    }
    
    CGFloat t_discount = [info.t_discount integerValue] * 0.1;
    if (t_discount == 10) {
        self.downDetailLabel.text = [NSString stringWithFormat:@"%@全价",info.t_position_name];
    }else if (t_discount > 10){
        self.downDetailLabel.text = [NSString stringWithFormat:@"%@",info.t_position_name];
    }else{
        self.downDetailLabel.text = [NSString stringWithFormat:@"%@%0.1lf折",info.t_position_name,t_discount];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
