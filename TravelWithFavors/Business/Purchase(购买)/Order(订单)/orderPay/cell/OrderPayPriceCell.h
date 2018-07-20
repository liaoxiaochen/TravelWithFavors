//
//  OrderPayPriceCell.h
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/7.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderPayPriceCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *phoneLB;
@property (weak, nonatomic) IBOutlet UILabel *passengerLB;
@property (weak, nonatomic) IBOutlet UILabel *parPriceLB;
@property (weak, nonatomic) IBOutlet UILabel *parCountLB;
@property (weak, nonatomic) IBOutlet UILabel *machineBuildPriceLB;
@property (weak, nonatomic) IBOutlet UILabel *machineBuilCountLB;
@property (weak, nonatomic) IBOutlet UILabel *fuelPriceLB;
@property (weak, nonatomic) IBOutlet UILabel *fuelCountLB;
@property (weak, nonatomic) IBOutlet UILabel *insurancePriceLB;
@property (weak, nonatomic) IBOutlet UILabel *insuranceCountLB;

@property (weak, nonatomic) IBOutlet UILabel *petPriceLB;
@property (weak, nonatomic) IBOutlet UILabel *petCountLB;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *petViewHeight;

@end
