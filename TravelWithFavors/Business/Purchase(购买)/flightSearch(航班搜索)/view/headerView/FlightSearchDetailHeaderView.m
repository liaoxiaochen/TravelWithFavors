//
//  FlightSearchDetailHeaderView.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/6.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "FlightSearchDetailHeaderView.h"
#import "FlightDetailInfo.h"
#import "RMCalendarModel.h"
@interface FlightSearchDetailHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *titlelabel;
@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *startPortLabel;
@property (weak, nonatomic) IBOutlet UILabel *endPortLabel;

@end
@implementation FlightSearchDetailHeaderView

-(void)awakeFromNib{
    [super awakeFromNib];
    self.bgView.layer.cornerRadius = 5;
    self.bgView.layer.masksToBounds = YES;
}
- (void)setInfo:(FlightDetailInfo *)info{
    _info = info;
    self.titlelabel.text = [NSString stringWithFormat:@"%@%@  %.2lu月%.2lu日 %@",info.airline_company_name,info.flight_number,self.startTime.month,self.startTime.day,self.startTime.getWeek];
    self.startTimeLabel.text = [NSDate getDateTime:info.take_off_time formart:@"HH:mm"];
    self.endTimeLabel.text = [NSDate getDateTime:info.arrive_time formart:@"HH:mm"];
    self.startPortLabel.text = [NSString stringWithFormat:@"%@%@",info.airport1_name,info.station1];
    self.endPortLabel.text = [NSString stringWithFormat:@"%@%@",info.airport2_name,info.station2];
    NSInteger total = [info.flight_time integerValue];
    NSInteger hour = total/60;
    NSInteger minite = total%60;
    self.totalTimeLabel.text = [NSString stringWithFormat:@"%ld小时%ld分钟",hour,minite];
    if ([@"1" isEqualToString:info.has_food]) {
        self.detailLabel.text = @"准点率100% 有餐食";
    }else{
        self.detailLabel.text = @"准点率100% 无餐食";
    }
}
@end
