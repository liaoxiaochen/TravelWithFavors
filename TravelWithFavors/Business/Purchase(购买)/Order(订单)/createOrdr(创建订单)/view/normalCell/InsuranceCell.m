//
//  InsuranceCell.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/8.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "InsuranceCell.h"

@implementation InsuranceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
}
- (void)setDetail:(NSString *)detail{
    _detail = detail;
    self.detailLabel.text = detail;
    [self.detailLabel lineSpace:4];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
