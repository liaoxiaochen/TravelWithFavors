//
//  ShopCartBottomView.m
//  TravelWithFavors
//
//  Created by MacBook on 2018/8/22.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "ShopCartBottomView.h"

@interface ShopCartBottomView()
@property (nonatomic, strong) UIButton *calculateBtn;
@property (nonatomic, strong) UILabel *allPriceLabel;
@property (nonatomic, strong) UILabel *discountLabel;
@property (nonatomic, strong) UIImageView *lineView;

@end

@implementation ShopCartBottomView

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
    
    [self addSubview:self.checkAllBtn];
    [self addSubview:self.allPriceLabel];
    [self addSubview:self.discountLabel];
    [self addSubview:self.calculateBtn];
 
}

- (void)caluculateBtnAction:(UIButton *)btn {
    if (btn.tag == 0) {
        btn.selected = !btn.selected;
        if (btn.selected) {
            [btn setImage:[UIImage imageNamed:@"sc_js_xz"] forState:UIControlStateNormal];
        }else {
            [btn setImage:[UIImage imageNamed:@"sc_js_wxz"] forState:UIControlStateNormal];
        }
    }
  
    if (self.shopCartbottomBlock) {
        self.shopCartbottomBlock(btn.tag, btn.selected);
    }
    
}

- (UILabel *)allPriceLabel {
    if (!_allPriceLabel) {
        _allPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 10, SCREEN_WIDTH - 180, 20)];
        _allPriceLabel.textAlignment = NSTextAlignmentRight;
        _allPriceLabel.text = @"总计：￥888";
        _allPriceLabel.font = [UIFont systemFontOfSize:16];
        _allPriceLabel.textColor = [UIColor hdTextColor];

    }
    return _allPriceLabel;
}

- (UILabel *)discountLabel {
    if (!_discountLabel) {
        _discountLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(self.allPriceLabel.frame), SCREEN_WIDTH - 180, 14)];
        _discountLabel.textAlignment = NSTextAlignmentRight;
        _discountLabel.text = @"已优惠：￥93";
        _discountLabel.font = [UIFont systemFontOfSize:10];
        _discountLabel.textColor = [UIColor hdTipTextColor];
    }
    return _discountLabel;
}

- (UIButton *)calculateBtn {
    if (!_calculateBtn) {
        _calculateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _calculateBtn.frame = CGRectMake(SCREEN_WIDTH - 140, 0 , 140, SELF_HEIGHT);
        [_calculateBtn setTitle:@"结算" forState:(UIControlStateNormal)];
        [_calculateBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        _calculateBtn.backgroundColor = [UIColor hdRedColor];
        _calculateBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        _calculateBtn.tag = 1;
        [_calculateBtn addTarget:self action:@selector(caluculateBtnAction:) forControlEvents:UIControlEventTouchUpInside];
      }
    return _calculateBtn;
}

- (UIButton *)checkAllBtn {
    if (!_checkAllBtn) {
        _checkAllBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _checkAllBtn.frame = CGRectMake(10, 0 , 30, SELF_HEIGHT);
        [_checkAllBtn setTitle:@"全选" forState:(UIControlStateNormal)];
        [_checkAllBtn setTitleColor:[UIColor hdPlaceHolderColor] forState:(UIControlStateNormal)];
        _checkAllBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        [_checkAllBtn setImage:[UIImage imageNamed:@"sc_js_wxz"] forState:UIControlStateNormal];
        _checkAllBtn.tag = 0;
        [_checkAllBtn addTarget:self action:@selector(caluculateBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [UIButton initButton:_checkAllBtn spacing:5];
    }
    return _checkAllBtn;
}


@end
