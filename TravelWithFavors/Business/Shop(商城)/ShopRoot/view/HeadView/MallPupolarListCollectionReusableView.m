//
//  MallPupolarListCollectionReusableView.m
//  TravelWithFavors
//
//  Created by MacBook on 2018/8/13.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "MallPupolarListCollectionReusableView.h"

@interface MallPupolarListCollectionReusableView()


@property (nonatomic, strong) UIImageView *headerImg;

@end

@implementation MallPupolarListCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
 
         [self addSubview:self.headerImg];
    }
    return self;
}

- (void)setHeaderImgStr:(NSString *)headerImgStr {
    
    _headerImgStr = headerImgStr;
    _headerImg.image = [UIImage imageNamed:_headerImgStr];

}

- (UIImageView *)headerImg {
    if (!_headerImg) {
        _headerImg = [[UIImageView alloc] init];
        _headerImg.frame = CGRectMake(10, (SELF_HEIGHT - 16) / 2, 94.5, 16);
        _headerImg.centerX = self.centerX;
        _headerImg.image = [UIImage imageNamed:@"rqbd"];
        
    }
    return _headerImg;
}

@end
