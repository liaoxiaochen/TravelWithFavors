//
//  FlightSearchJourneyDetailCell.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/6.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "FlightSearchJourneyDetailCell.h"
#import "FlightDetailAirInfo.h"
@implementation FlightSearchJourneyDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    self.rightBgView.layer.cornerRadius = 3;
    self.rightBgView.layer.masksToBounds = YES;
    self.rightBgView.layer.borderWidth = 1;
    self.rightBgView.layer.borderColor = [UIColor colorWithHexString:@"#5D71AE"].CGColor;
    self.numberLabel.adjustsFontSizeToFitWidth = YES;
}
- (void)setAirInfo:(FlightDetailAirInfo *)airInfo{
    _airInfo = airInfo;
    self.journeyTipsLabel.hidden = YES;
//    self.typeLabel.text = [NSString stringWithFormat:@"%@%@",airInfo.position_name,airInfo.position_code];
    CGFloat discount = [airInfo.discount integerValue] * 0.1;
    if (discount == 10) {
        self.typeLabel.text = [NSString stringWithFormat:@"%@%@ 全价",airInfo.position_name,airInfo.position_code];
    }else if (discount > 10){
        self.typeLabel.text = [NSString stringWithFormat:@"%@%@",airInfo.position_name,airInfo.position_code];
    }else{
        self.typeLabel.text = [NSString stringWithFormat:@"%@%@ %.1lf折",airInfo.position_name,airInfo.position_code,discount];
    }
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",airInfo.par_price];
    NSInteger o = [airInfo.position_number integerValue];
    if (o > 0) {
        self.buttomLayout.constant = 16;
        self.numberLabel.text = [NSString stringWithFormat:@"仅剩%ld张",o];
    }else{
        self.buttomLayout.constant = 0;
        self.numberLabel.text = @"";
    }
}
- (void)setInfo:(FlightSearchDetailPosition *)info{
    _info = info;
    self.journeyTipsLabel.hidden = NO;
    self.typeLabel.text = [NSString stringWithFormat:@"%@%@",info.to.position_name,info.to.position_code];
    CGFloat totalPrice = [info.to.par_price doubleValue] + [info.back.par_price doubleValue];
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",[NSString stringConversionWithNumber:totalPrice]];
    NSInteger to_nmuber = [info.to.position_number integerValue];
    NSInteger back_nmuber = [info.back.position_number integerValue];
    NSInteger o = (to_nmuber > back_nmuber ? back_nmuber : to_nmuber);
    if (o > 0) {
        self.buttomLayout.constant = 16;
        self.numberLabel.text = [NSString stringWithFormat:@"仅剩%ld张",o];
    }else{
        self.buttomLayout.constant = 0;
        self.numberLabel.text = @"";
    }
}
- (void)setFrame:(CGRect)frame{
    frame.origin.x += 10;
    frame.size.width -= 20;
    [super setFrame:frame];
}
- (IBAction)ruleBtnClick:(id)sender {
    if (self.ruleBlock) {
        self.ruleBlock();
    }
}
- (IBAction)orderClick:(id)sender {
    if (self.orderBlock) {
        self.orderBlock();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
