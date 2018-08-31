//
//  MallInfoCollectionViewCell.m
//  TravelWithFavors
//
//  Created by MacBook on 2018/8/13.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "MallInfoCollectionViewCell.h"

@interface MallInfoCollectionViewCell()

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIImageView *infoImg;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *subTitle;

@end

@implementation MallInfoCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.backView];
        [self.backView addSubview:self.infoImg];
        [self.backView addSubview:self.title];
        [self.backView addSubview:self.subTitle];
    }
    return self;
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        
    }
    return _backView;
}

- (UIImageView *)infoImg {
    if (!_infoImg) {
        _infoImg = [[UIImageView alloc] init];
        _infoImg.frame = CGRectMake(0, 0, SELF_WIDTH, SELF_WIDTH / 1.46);
        _infoImg.backgroundColor = [UIColor hdPlaceHolderColor];
    }
    return _infoImg;
}

- (UILabel *)title {
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.font = [UIFont systemFontOfSize:12];
        _title.frame = CGRectMake(10, CGRectGetMaxY(self.infoImg.frame), SELF_WIDTH - 20, 20);
        _title.text = @"养宠十大须知";
    }
    return _title;
}

- (UILabel *)subTitle {
    if (!_subTitle) {
        _subTitle = [[UILabel alloc] init];
        _subTitle.font = [UIFont systemFontOfSize:10];
        _subTitle.textColor = [UIColor hdPlaceHolderColor];
        _subTitle.numberOfLines = 2;
        _subTitle.frame = CGRectMake(10, CGRectGetMaxY(self.title.frame), SELF_WIDTH - 20, 30);
        _subTitle.text = @"转为单身狗转为单身狗转为单身狗转为单身狗转为单身狗转为单身狗";
        
    }
    return _subTitle;
}
@end
