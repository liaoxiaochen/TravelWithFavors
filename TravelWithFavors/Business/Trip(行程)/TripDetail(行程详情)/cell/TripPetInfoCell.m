//
//  TripPetInfoCell.m
//  TravelWithFavors
//
//  Created by cushiro on 2018/4/13.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "TripPetInfoCell.h"

@interface TripPetInfoCell()

@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

@end

@implementation TripPetInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.infoLabel.layer.cornerRadius = 5;
    self.infoLabel.layer.masksToBounds = YES;
}

@end
