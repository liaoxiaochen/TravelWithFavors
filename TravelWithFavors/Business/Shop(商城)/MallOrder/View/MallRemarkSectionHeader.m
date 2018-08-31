//
//  MallRemarkSectionHeader.m
//  TravelWithFavors
//
//  Created by MacBook on 2018/8/23.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "MallRemarkSectionHeader.h"

@interface MallRemarkSectionHeader()

@property (nonatomic, strong) UIImageView *logoImg;
@property (nonatomic, strong) UILabel *shopNameLabel;

@end

@implementation MallRemarkSectionHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.logoImg];
        [self addSubview:self.shopNameLabel];
    }
    return self;
}
- (UIImageView *)logoImg {
    if (!_logoImg) {
        _logoImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, (SELF_HEIGHT - 15) /2, 15,  15)];
        _logoImg.image = [UIImage imageNamed:@"sc_dptb"];
    }
    return _logoImg;
}
- (UILabel *)shopNameLabel {
    if (!_shopNameLabel) {
        _shopNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 200, SELF_HEIGHT)];
        _shopNameLabel.text = @"携宠自营";
        _shopNameLabel.font = [UIFont systemFontOfSize:12];
        _shopNameLabel.textColor = [UIColor hdTextColor];
    }
    return _shopNameLabel;
}

@end
