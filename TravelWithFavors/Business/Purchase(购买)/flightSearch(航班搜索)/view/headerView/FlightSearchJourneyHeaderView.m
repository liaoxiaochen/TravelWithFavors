//
//  FlightSearchJourneyHeaderView.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/6.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "FlightSearchJourneyHeaderView.h"
@interface FlightSearchJourneyHeaderView ()

@end
@implementation FlightSearchJourneyHeaderView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.bgView.layer.cornerRadius = 20;
    self.bgView.layer.masksToBounds = YES;
    
    self.dayView.layer.cornerRadius = 8;
    self.dayView.layer.masksToBounds = YES;
    self.dayView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.dayView.layer.borderWidth = 1;
}

@end
