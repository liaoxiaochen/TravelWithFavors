//
//  OrderBackTypeCell.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/7.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "OrderBackTypeCell.h"

@implementation OrderBackTypeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)typeBtnClick:(id)sender {
    if (self.ruleBlock) {
        self.ruleBlock();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
