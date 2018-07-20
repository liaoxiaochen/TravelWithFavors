//
//  PurchaseFooterView.m
//  TravelWithFavors
//
//  Created by MacBook on 2018/7/12.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "PurchaseFooterView.h"

@interface PurchaseFooterView()

@property (nonatomic, strong) UIImageView *logoImg;
@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, strong) UIView *rightView;

@end

@implementation PurchaseFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}


- (void)setupUI {
    
    [self addSubview:self.logoImg];
    [self addSubview:self.leftView];
    [self addSubview:self.rightView];
    
}


- (UIImageView *)logoImg {
    
    if (!_logoImg) {
        _logoImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 15, 40*214/77, 40)];
        _logoImg.image = [UIImage imageNamed:@"purchase_adver"];
        _logoImg.centerX = self.centerX;
    }
    
    return _logoImg;
}

- (UIView *)leftView {
    if (!_leftView) {
        CGFloat logoImgWidth = CGRectGetWidth(_logoImg.frame);
        _leftView = [[UIView alloc] initWithFrame:CGRectMake(60, 0, (self.frame.size.width - logoImgWidth) / 2 - 75, 2)];
        _leftView.centerY = _logoImg.centerY;
        _leftView.backgroundColor = [UIColor colorWithHexString:@"#CCCCCC"];
    }
    return _leftView;
}

- (UIView *)rightView {
    if (!_rightView) {
        CGFloat logoImgWidth = CGRectGetWidth(_logoImg.frame);
        _rightView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width / 2 + logoImgWidth / 2 + 15, 0, (self.frame.size.width - logoImgWidth) / 2 - 75, 2)];
        _rightView.centerY = _logoImg.centerY;
        _rightView.backgroundColor = [UIColor colorWithHexString:@"#CCCCCC"];
    }
    return _rightView;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
