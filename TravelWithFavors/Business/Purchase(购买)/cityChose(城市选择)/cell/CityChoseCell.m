//
//  CityChoseCell.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/14.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "CityChoseCell.h"
#import "CityInfo.h"
@implementation CityChoseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setInfo:(CityInfo *)info{
    _info = info;
    NSString *str = [NSString stringWithFormat:@"%@/%@ %@",info.city_name,info.city_code,info.country_name];
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:str];
    
    [att addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0f] range:NSMakeRange(0, str.length)];
    [att addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#333333"] range:NSMakeRange(0, info.city_name.length)];
    [att addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(info.city_name.length, str.length - info.city_name.length)];
    self.titleLabel.attributedText = att;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
