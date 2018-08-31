//
//  MallSectionCollectionReusableView.m
//  TravelWithFavors
//
//  Created by MacBook on 2018/8/10.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "MallSectionCollectionReusableView.h"

@interface MallSectionCollectionReusableView()


@property (nonatomic, strong) UIImageView *mrtjImg;

@end

@implementation MallSectionCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.mrtjImg];
    }
    return self;
}

- (UIImageView *)mrtjImg {
    if (!_mrtjImg) {
        _mrtjImg = [[UIImageView alloc] init];
        _mrtjImg.frame = CGRectMake(10, (SELF_HEIGHT - 14) / 2, 64.5, 14);
        _mrtjImg.image = [UIImage imageNamed:@"mrtj"];
        
    }
    return _mrtjImg;
}



@end
