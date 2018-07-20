//
//  OrderChangeFlightInfoCell.h
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/7.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderChangeFlightInfoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *oldTimeLB;
@property (weak, nonatomic) IBOutlet UILabel *oldPositionLB;

@property (weak, nonatomic) IBOutlet UILabel *curTimeLB;
@property (weak, nonatomic) IBOutlet UILabel *curPositionLB;
@property (weak, nonatomic) IBOutlet UILabel *startHMLB;
@property (weak, nonatomic) IBOutlet UILabel *startAirportLB;
@property (weak, nonatomic) IBOutlet UILabel *endHMLB;
@property (weak, nonatomic) IBOutlet UILabel *endAirportLB;
@property (weak, nonatomic) IBOutlet UILabel *flightDurationLB;

@end
