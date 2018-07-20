//
//  FlightSearchJourneyDetailHeaderView.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/6.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "FlightSearchJourneyDetailHeaderView.h"

@interface FlightSearchJourneyDetailHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *goTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *goStartLabel;
@property (weak, nonatomic) IBOutlet UILabel *goEndTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *goTotalLabel;
@property (weak, nonatomic) IBOutlet UILabel *goDetailLabel;
@property (weak, nonatomic) IBOutlet UILabel *goStartPlaceLabel;
@property (weak, nonatomic) IBOutlet UILabel *goEndPlaceLabel;
@property (weak, nonatomic) IBOutlet UILabel *backTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *backStartLabel;
@property (weak, nonatomic) IBOutlet UILabel *backEndLabel;
@property (weak, nonatomic) IBOutlet UILabel *backTotalTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *backDetailLabel;
@property (weak, nonatomic) IBOutlet UILabel *backStartPlaceLabel;
@property (weak, nonatomic) IBOutlet UILabel *backEndPlaceLabel;

@end
@implementation FlightSearchJourneyDetailHeaderView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.bgView.layer.cornerRadius = 3;
    self.bgView.layer.masksToBounds = YES;
}
-(void)setTo:(FlightDetailInfo *)to{
    _to = to;
    self.goTitleLabel.text = [NSString stringWithFormat:@"%@%@  %.2lu月%.2lu日 %@",to.airline_company_name,to.flight_number,self.toTime.month,self.toTime.day,self.toTime.getWeek];
    self.goStartLabel.text = [NSDate getDateTime:to.take_off_time formart:@"HH:mm"];
    self.goEndTimeLabel.text = [NSDate getDateTime:to.arrive_time formart:@"HH:mm"];
    self.goStartPlaceLabel.text = [NSString stringWithFormat:@"%@%@",to.airport1_name,to.station1];
    self.goEndPlaceLabel.text = [NSString stringWithFormat:@"%@%@",to.airport2_name,to.station2];
    NSInteger total = [to.flight_time integerValue];
    NSInteger hour = total/60;
    NSInteger minite = total%60;
    self.goTotalLabel.text = [NSString stringWithFormat:@"%ld小时%ld分钟",hour,minite];
    
    if ([@"1" isEqualToString:to.has_food]) {
        self.goDetailLabel.text = @"准点率100% 有餐食";
    }else{
        self.goDetailLabel.text = @"准点率100% 无餐食";
    }
}
-(void)setBack:(FlightDetailInfo *)back{
    _back = back;
        self.backTitleLabel.text = [NSString stringWithFormat:@"%@%@  %.2lu月%.2lu日 %@",back.airline_company_name,back.flight_number,self.backTime.month,self.backTime.day,self.backTime.getWeek];
        self.backStartLabel.text = [NSDate getDateTime:back.take_off_time formart:@"HH:mm"];
        self.backEndLabel.text = [NSDate getDateTime:back.arrive_time formart:@"HH:mm"];
        self.backStartPlaceLabel.text = [NSString stringWithFormat:@"%@%@",back.airport1_name,back.station1];
        self.backEndPlaceLabel.text = [NSString stringWithFormat:@"%@%@",back.airport2_name,back.station2];
        NSInteger backtotal = [back.flight_time integerValue];
        NSInteger backhour = backtotal/60;
        NSInteger backminite = backtotal%60;
        self.backTotalTimeLabel.text = [NSString stringWithFormat:@"%ld小时%ld分钟",backhour,backminite];
    
    if ([@"1" isEqualToString:back.has_food]) {
        self.backDetailLabel.text = @"准点率100% 有餐食";
    }else{
        self.backDetailLabel.text = @"准点率100% 无餐食";
    }
}
@end
