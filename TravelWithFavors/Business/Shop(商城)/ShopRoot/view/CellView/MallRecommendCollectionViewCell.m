//
//  MallRecommendCollectionViewCell.m
//  TravelWithFavors
//
//  Created by MacBook on 2018/8/10.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "MallRecommendCollectionViewCell.h"

@interface MallRecommendCollectionViewCell()

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIImageView *shopPic;
@property (nonatomic, strong) UILabel *goodName;
@property (nonatomic, strong) UILabel *goodTip;
@property (nonatomic, strong) UILabel *goodPrice;

@end

@implementation MallRecommendCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    
    [self.contentView addSubview:self.backView];
    [self.backView addSubview:self.shopPic];
    [self.backView addSubview:self.goodName];
    [self.backView addSubview:self.goodTip];
    [self.backView addSubview:self.goodPrice];

}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        
    }
    return _backView;
}

- (UIImageView *)shopPic {
    if (!_shopPic) {
        _shopPic = [[UIImageView alloc] init];
        _shopPic.frame = CGRectMake(0, 0, CONTENT_WIDTH, CONTENT_WIDTH * 1.3);
        _shopPic.backgroundColor = [UIColor hdPlaceHolderColor];
        _shopPic.image = [UIImage imageNamed:@"banner2.jpg"];
    }
    return _shopPic;
}

- (UILabel *)goodName {
    if (!_goodName) {
        _goodName = [[UILabel alloc] init];
        _goodName.font = [UIFont systemFontOfSize:12];
        _goodName.frame = CGRectMake(0, CGRectGetMaxY(self.shopPic.frame), CONTENT_WIDTH, 20);
        _goodName.text = @"狗粮（西伯利亚）";
    }
    return _goodName;
}

- (UILabel *)goodTip {
    if (!_goodTip) {
        _goodTip = [[UILabel alloc] init];
        _goodTip.font = [UIFont systemFontOfSize:10];
        _goodTip.textColor = [UIColor hdPlaceHolderColor];
        _goodTip.frame = CGRectMake(0, CGRectGetMaxY(self.goodName.frame), CONTENT_WIDTH, 15);
        _goodTip.text = @"转为单身狗";

    }
    return _goodTip;
}
- (UILabel *)goodPrice {
    if (!_goodPrice) {
        _goodPrice = [[UILabel alloc] init];
        _goodPrice.font = [UIFont systemFontOfSize:12];
        _goodPrice.textColor = [UIColor hdRedColor];
        _goodPrice.frame = CGRectMake(0, CGRectGetMaxY(self.goodTip.frame), CONTENT_WIDTH, 15);
        _goodPrice.text = @"￥128";

    }
    return _goodPrice;
}



@end
