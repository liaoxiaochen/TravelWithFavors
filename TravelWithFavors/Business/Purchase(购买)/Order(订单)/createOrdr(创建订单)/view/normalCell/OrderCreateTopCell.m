//
//  OrderCreateTopCell.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/6.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "OrderCreateTopCell.h"
#import "NSDate+RMCalendarLogic.h"
#import "RMCalendarModel.h"

@implementation OrderCreateTopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)ruleClick:(id)sender {
    if (self.ruleBlock) {
        self.ruleBlock();
    }
}
-(void)setFlightOrderInfoModel:(FlightOrderInfoModel *)flightOrderInfoModel{
    _flightOrderInfoModel = flightOrderInfoModel;
    if (flightOrderInfoModel.isJourney) {
        _leftLabel.text = [NSString stringWithFormat:@"%@-%@",_flightOrderInfoModel.back.airport1_name,_flightOrderInfoModel.back.airport2_name];
        
        NSString *time = [NSDate getDateTime:_flightOrderInfoModel.back.take_off_time formart:@"yyyy-MM-dd HH:mm"];
        NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        NSDate *date = [fmt dateFromString:time];
        NSDateComponents *component = [date YMDComponents];
        RMCalendarModel *model = [RMCalendarModel calendarWithYear:component.year month:component.month day:component.day];
        _rightLabel.text = [NSString stringWithFormat:@"%@ %@ 起飞",time,model.getWeek];
        
        _priceLabel.text = [NSString stringWithFormat:@"票价￥%@",_flightOrderInfoModel.back.position.par_price];
        CGFloat totalPrice = [_flightOrderInfoModel.back.machine_build doubleValue] + [_flightOrderInfoModel.back.fuel doubleValue];
        _priceRightLabel.text = [NSString stringWithFormat:@"机建+燃油￥%@",[NSString stringConversionWithNumber:totalPrice]];
    }else{
        _leftLabel.text = [NSString stringWithFormat:@"%@-%@",_flightOrderInfoModel.to.airport1_name,_flightOrderInfoModel.to.airport2_name];
        
        NSString *time = [NSDate getDateTime:_flightOrderInfoModel.to.take_off_time formart:@"yyyy-MM-dd HH:mm"];
        NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        NSDate *date = [fmt dateFromString:time];
        NSDateComponents *component = [date YMDComponents];
        RMCalendarModel *model = [RMCalendarModel calendarWithYear:component.year month:component.month day:component.day];
        _rightLabel.text = [NSString stringWithFormat:@"%@ %@ 起飞",time,model.getWeek];
        
        _priceLabel.text = [NSString stringWithFormat:@"票价￥%@",_flightOrderInfoModel.to.position.par_price];
        CGFloat totalPrice = [_flightOrderInfoModel.to.machine_build doubleValue] + [_flightOrderInfoModel.to.fuel doubleValue];
        _priceRightLabel.text = [NSString stringWithFormat:@"机建+燃油￥%@",[NSString stringConversionWithNumber:totalPrice]];
    }

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
