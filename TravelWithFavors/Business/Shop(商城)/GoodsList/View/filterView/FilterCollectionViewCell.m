//
//  FilterCollectionViewCell.m
//  TravelWithFavors
//
//  Created by MacBook on 2018/8/14.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "FilterCollectionViewCell.h"

@interface FilterCollectionViewCell()



@end

@implementation FilterCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.seletImg];
        
    }
    return self;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, CONTENT_WIDTH - 30, CONTENT_HEIGHT)];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _titleLabel.text = @"--";
    }
    return _titleLabel;
}

- (UIImageView *)seletImg {
    if (!_seletImg) {
        _seletImg = [[UIImageView alloc] initWithFrame:CGRectMake(CONTENT_WIDTH - 46, 9, 16, 11)];
        _seletImg.image = [UIImage imageNamed:@"sc_dh"];
    }
    return _seletImg;
}

@end
