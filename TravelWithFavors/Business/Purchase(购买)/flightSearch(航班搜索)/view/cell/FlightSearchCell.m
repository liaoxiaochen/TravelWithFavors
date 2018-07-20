//
//  FlightSearchCell.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/6.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "FlightSearchCell.h"
#import "FlightInfo.h"
@implementation FlightSearchCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    
    
}
- (void)setInfo:(FlightInfo *)info{
    _info = info;
    NSString *string = [NSString stringConversionWithNumber:[info.par_price doubleValue]];
//    if (![@"1" isEqualToString:self.ride_type]) {
//        string = [NSString stringConversionWithNumber:[info.par_price doubleValue] + [self.price doubleValue]];
//    }
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%@",string]];
    [att addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12.0f] range:NSMakeRange(0, 1)];
    [att addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18.0f] range:NSMakeRange(1, string.length - 1)];
    self.priceLabel.attributedText = att;
    
    self.leftLabel.text = [NSDate getDateTime:info.take_off_time formart:@"HH:mm"];
    self.rightLabel.text = [NSDate getDateTime:info.arrive_time formart:@"HH:mm"];
    self.leftPalceLabel.text = [NSString stringWithFormat:@"%@%@",info.airport1_name,info.station1];
    self.rightPlaceLabel.text = [NSString stringWithFormat:@"%@%@",info.airport2_name,info.station2];
//    self.detailLabel.text =
    self.conparyLabel.text = [NSString stringWithFormat:@"%@%@ %@ ",info.airline_company_name,info.flight_number,info.plane_model];
    
//    if ([@"1" isEqualToString:self.ride_type]) {
//        CGFloat discount = [info.discount integerValue] * 0.1;
//        if (discount == 10) {
//            self.discountLB.text = [NSString stringWithFormat:@"%@全价",info.position_name];
//        }else if (discount > 10){
//            self.discountLB.text = [NSString stringWithFormat:@"%@",info.position_name];
//        }else{
//            self.discountLB.text = [NSString stringWithFormat:@"%@%0.1lf折",info.position_name,discount];
//        }
//    }else{
//        self.discountLB.text = @"往返总价";
//    }
    
    CGFloat discount = [info.discount integerValue] * 0.1;
    if (discount == 10) {
        self.discountLB.text = [NSString stringWithFormat:@"%@全价",info.position_name];
    }else if (discount > 10){
        self.discountLB.text = [NSString stringWithFormat:@"%@",info.position_name];
    }else{
        self.discountLB.text = [NSString stringWithFormat:@"%@%0.1lf折",info.position_name,discount];
    }
}
- (void)setFrame:(CGRect)frame{
    frame.origin.x += 10;
    frame.size.width -= 20;
    [super setFrame:frame];
}
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    UIColor *originColor = self.backgroundColor;
//    [super setSelected:selected animated:animated];
//    self.backgroundColor = originColor;
//}
//
//- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
//    UIColor *originColor = self.backgroundColor;
//    [super setHighlighted:highlighted animated:animated];
//    self.backgroundColor = originColor;
//}
@end
