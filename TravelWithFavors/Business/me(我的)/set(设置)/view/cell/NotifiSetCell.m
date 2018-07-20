//
//  NotifiSetCell.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/3.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "NotifiSetCell.h"

@implementation NotifiSetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)switchValueChange:(id)sender {
//    if (self.delegate && [self.delegate respondsToSelector:@selector(swithType:)]) {
//        [self.delegate swithType:self];
//    }
    UISwitch *swi = (UISwitch *)sender;
    if (self.teudb) {
        self.teudb(swi.isOn);
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
