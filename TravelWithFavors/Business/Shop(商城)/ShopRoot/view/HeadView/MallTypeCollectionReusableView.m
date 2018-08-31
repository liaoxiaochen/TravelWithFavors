//
//  MallTypeCollectionReusableView.m
//  TravelWithFavors
//
//  Created by MacBook on 2018/8/10.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "MallTypeCollectionReusableView.h"

@interface MallTypeCollectionReusableView()

@property (nonatomic, strong) UIButton *catBtn;
@property (nonatomic, strong) UIButton *dogBtn;

@property (nonatomic, strong) UIView *lineView;

@end

@implementation MallTypeCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self initUI];
    }
    return self;
}


- (void)initUI {
    
    [self addSubview:self.catBtn];
    [self addSubview:self.dogBtn];
    [self addSubview:self.lineView];
    
    _catBtn.selected = YES;
    _dogBtn.selected = NO;
}

- (void)catBtnAction {
    _catBtn.selected = !_catBtn.isSelected;
    _dogBtn.selected = !_dogBtn.isSelected;

    _lineView.frame = CGRectMake(self.frame.size.width / 4 - 15, CGRectGetMaxY(_dogBtn.frame) - 2, 30, 2);
}

- (void)dogBtnAction {
    _dogBtn.selected = !_dogBtn.isSelected;
    _catBtn.selected = !_catBtn.isSelected;

    _lineView.frame = CGRectMake(self.frame.size.width / 4 * 3 - 15, CGRectGetMaxY(_dogBtn.frame) - 2, 30, 2);

}

- (UIButton *)catBtn {
    if (!_catBtn) {
        _catBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_catBtn setTitle:@"猫猫" forState:UIControlStateNormal];
        [_catBtn setTitleColor:[UIColor hdPlaceHolderColor] forState:UIControlStateNormal];
        [_catBtn setTitleColor:[UIColor hdRedColor] forState:UIControlStateSelected];
        _catBtn.frame = CGRectMake(0, 0, self.frame.size.width / 2, self.frame.size.height);
        _catBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_catBtn addTarget:self action:@selector(catBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _catBtn;
}

- (UIButton *)dogBtn {
    if (!_dogBtn) {
        _dogBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_dogBtn setTitle:@"狗狗" forState:UIControlStateNormal];
        [_dogBtn setTitleColor:[UIColor hdPlaceHolderColor] forState:UIControlStateNormal];
        [_dogBtn setTitleColor:[UIColor hdRedColor] forState:UIControlStateSelected];
        _dogBtn.frame = CGRectMake(self.frame.size.width / 2, 0, self.frame.size.width / 2, self.frame.size.height);
        _dogBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_dogBtn addTarget:self action:@selector(dogBtnAction) forControlEvents:UIControlEventTouchUpInside];

    }
    return _dogBtn;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor hdRedColor];
        _lineView.frame = CGRectMake(self.frame.size.width / 4 - 15, CGRectGetMaxY(_dogBtn.frame) - 2, 30, 2);
    }
    return _lineView;
}

@end
