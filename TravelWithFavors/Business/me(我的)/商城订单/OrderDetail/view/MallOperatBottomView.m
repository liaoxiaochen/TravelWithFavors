//
//  MallOperatBottomView.m
//  TravelWithFavors
//
//  Created by MacBook on 2018/8/25.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "MallOperatBottomView.h"

@interface MallOperatBottomView()

 @property (nonatomic, strong) UIButton *againBuyBtn;

@property (nonatomic, strong) UIImageView *lineView;

@end

@implementation MallOperatBottomView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

- (void)initView {
    
    
    UIImageView *lineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    lineView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    [self addSubview:lineView];
    self.lineView = lineView;
 
    [self addSubview:self.againBuyBtn];
    
}

- (void)againBuyBtnAction:(UIButton *)btn {
    
    
    if (self.bottomBlock) {
        self.bottomBlock(self);
    }
    
}

- (UIButton *)againBuyBtn {
    if (!_againBuyBtn) {
        _againBuyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _againBuyBtn.frame = CGRectMake(SCREEN_WIDTH - 140, 0 , 140, SELF_HEIGHT);
        [_againBuyBtn setTitle:@"申请售后" forState:(UIControlStateNormal)];
        [_againBuyBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        _againBuyBtn.backgroundColor = [UIColor hdRedColor];
        _againBuyBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        _againBuyBtn.tag = 2;
        [_againBuyBtn addTarget:self action:@selector(againBuyBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _againBuyBtn;
}



@end
