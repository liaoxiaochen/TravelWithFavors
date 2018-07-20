//
//  UserProtocolCell.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/9.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "UserProtocolCell.h"

@implementation UserProtocolCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setDetail:(NSString *)detail{
    _detail = detail;
    self.detailLabel.text = detail;
    [self.detailLabel lineSpace:6];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
