//
//  TripTableViewBgview.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/6.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "TripTableViewBgview.h"

@implementation TripTableViewBgview

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *shopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        shopBtn.userInteractionEnabled = YES;
        shopBtn.frame = CGRectMake((frame.size.width - 80)/2,(frame.size.height - 104)/2 , 80, 104);
        shopBtn.adjustsImageWhenHighlighted = YES;
        [shopBtn setTitle:@"购买机票" forState:UIControlStateNormal];
        shopBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [shopBtn setImage:[UIImage imageNamed:@"xc_gmjp"] forState:UIControlStateNormal];
        CGFloat offset = 12.0f;
        shopBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -shopBtn.imageView.frame.size.width, -shopBtn.imageView.frame.size.height-offset/2, 0);
        shopBtn.imageEdgeInsets = UIEdgeInsetsMake(-shopBtn.titleLabel.intrinsicContentSize.height-offset/2, 0, 0, -shopBtn.titleLabel.intrinsicContentSize.width);
        [shopBtn addTarget:self action:@selector(shopBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:shopBtn];
    }
    return self;
}

- (void)shopBtnClick{
    if (self.shopBlock) {
        self.shopBlock();
    }
}
@end
