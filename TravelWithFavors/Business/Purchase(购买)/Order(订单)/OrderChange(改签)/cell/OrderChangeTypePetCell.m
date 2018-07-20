//
//  OrderChangeTypePetCell.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/8.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "OrderChangeTypePetCell.h"

@implementation OrderChangeTypePetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)ruleClick:(id)sender {
    if (self.ruleBlock) {
        self.ruleBlock();
    }
}

@end
