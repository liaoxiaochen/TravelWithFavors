//
//  MallOrderBottomView.m
//  TravelWithFavors
//
//  Created by MacBook on 2018/8/23.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "MallOrderBottomView.h"

@interface MallOrderBottomView()

@property (nonatomic, strong) UIButton *payBtn;

 @property (nonatomic, strong) UIButton *detailBtn;
@property (nonatomic, strong) UILabel *allPriceLabel;
 @property (nonatomic, strong) UIImageView *lineView;


@end

@implementation MallOrderBottomView

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
    
     [self addSubview:self.allPriceLabel];
     [self addSubview:self.payBtn];
//    [self addSubview:self.detailBtn];

}

- (void)caluculateBtnAction:(UIButton *)btn {
    
    
    if (self.mallOrderbottomBlock) {
        self.mallOrderbottomBlock(self, btn.tag);
    }
    
}

- (UILabel *)allPriceLabel {
    if (!_allPriceLabel) {
        _allPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0 , SCREEN_WIDTH - 240, SELF_HEIGHT)];
        _allPriceLabel.textAlignment = NSTextAlignmentLeft;
        _allPriceLabel.font = [UIFont systemFontOfSize:16];
        _allPriceLabel.textColor = [UIColor hdTextColor];
        _allPriceLabel.attributedText = [NSString changeLabelColorWithMainStr:@"总计：￥888" diffrenStr:@"￥888" diffrenColor:[UIColor hdRedColor]];
        
    }
    return _allPriceLabel;
}



- (UIButton *)payBtn {
    if (!_payBtn) {
        _payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _payBtn.frame = CGRectMake(SCREEN_WIDTH - 140, 0 , 140, SELF_HEIGHT);
        [_payBtn setTitle:@"支付" forState:(UIControlStateNormal)];
        [_payBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        _payBtn.backgroundColor = [UIColor hdRedColor];
        _payBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        _payBtn.tag = 2;
        [_payBtn addTarget:self action:@selector(caluculateBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _payBtn;
}

- (UIButton *)detailBtn {
    if (!_detailBtn) {
        _detailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _detailBtn.frame = CGRectMake(SCREEN_WIDTH - 200, 0 , 50, SELF_HEIGHT);
        [_detailBtn setTitle:@"查看明细" forState:(UIControlStateNormal)];
        [_detailBtn setTitleColor:[UIColor hdTextColor] forState:(UIControlStateNormal)];
        _detailBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        [_detailBtn setImage:[UIImage imageNamed:@"ddzf_sjhei"] forState:UIControlStateNormal];
        _detailBtn.tag = 1;
        [_detailBtn addTarget:self action:@selector(caluculateBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_detailBtn initButtonTitleLeftImageRight];
    }
    return _detailBtn;
}



@end
