//
//  PetSexView.m
//  TravelWithFavors
//
//  Created by MacBook on 2018/7/30.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "PetSexView.h"


@interface PetSexView()

@property (nonatomic, strong) UIView *bigBackView;
@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UIButton *gongBtn;
@property (nonatomic, strong) UIButton *muBtn;
@property (nonatomic, strong) UIButton *jueyuGongBtn;
@property (nonatomic, strong) UIButton *jueyuMuBtn;

@property (nonatomic, strong) UIView *sepreHengView;
@property (nonatomic, strong) UIView *sepreShuView;

@end

@implementation PetSexView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.bigBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT)];
        self.bigBackView.backgroundColor = [UIColor colorWithHue:0 saturation:0 brightness:0 alpha:0.2];
//        self.bigBackView.backgroundColor = [UIColor redColor];
        [self addSubview:self.bigBackView];
        
        self.backView = [[UIView alloc] initWithFrame:CGRectMake(0, self.size.height , SCREEN_WIDTH, 160)];
        self.backView.backgroundColor = [UIColor whiteColor];
        [UIView addShadowToView:self.backView withOpacity:0.8 shadowRadius:8 andCornerRadius:8];
        [self.bigBackView addSubview:self.backView];
        
        [self.backView addSubview:self.gongBtn];
        [self.backView addSubview:self.muBtn];
        [self.backView addSubview:self.jueyuGongBtn];
        [self.backView addSubview:self.jueyuMuBtn];
        
        [self.backView addSubview:self.sepreHengView];
        [self.backView addSubview:self.sepreShuView];
        
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.userInteractionEnabled) {
        CGPoint point=[[touches anyObject] locationInView:self];
        if (![self.backView.layer containsPoint:point]) {
            [self hideView];
        }
    }
    
}
- (void)showView{
 
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0.2 animations:^{
        self.backView.frame = CGRectMake(0, self.size.height - 160, SCREEN_WIDTH, 160);
    }];
    
}
- (void)hideView{
    
    [UIView animateWithDuration:0.2 animations:^{
        
        self.backView.frame = CGRectMake(0, self.size.height, SCREEN_WIDTH, 160);

    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
    
}

- (void)gongBtnAction {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(PetSexdidSelected:)]) {
        [self.delegate PetSexdidSelected:1];
        
    }
    [self hideView];

}
- (void)muBtnAction {
    if (self.delegate && [self.delegate respondsToSelector:@selector(PetSexdidSelected:)]) {
        [self.delegate PetSexdidSelected:2];
    }
    [self hideView];

}
- (void)jueyuGongBtnAction {
    if (self.delegate && [self.delegate respondsToSelector:@selector(PetSexdidSelected:)]) {
        [self.delegate PetSexdidSelected:3];
    }
    [self hideView];

}
- (void)jueyuMuBtnBtnAction {
    if (self.delegate && [self.delegate respondsToSelector:@selector(PetSexdidSelected:)]) {
        [self.delegate PetSexdidSelected:4];
    }
    [self hideView];

}

- (UIButton *)gongBtn {
    if (!_gongBtn) {
        _gongBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _gongBtn.frame = CGRectMake(0, 0, SCREEN_WIDTH / 2, 80);
        [_gongBtn setTitle:@"公" forState:(UIControlStateNormal)];
        [_gongBtn setTitleColor:[UIColor colorWithHexString:@"#a09bff"] forState:(UIControlStateNormal)];
        _gongBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_gongBtn setImage:[UIImage imageNamed:@"xc_gong"] forState:UIControlStateNormal];
        [_gongBtn addTarget:self action:@selector(gongBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [UIButton initButton:_gongBtn spacing:10];
    }
    return _gongBtn;
}

- (UIButton *)muBtn {
    if (!_muBtn) {
        _muBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _muBtn.frame = CGRectMake(SCREEN_WIDTH / 2,0, SCREEN_WIDTH / 2, 80);
        [_muBtn setTitle:@"母" forState:(UIControlStateNormal)];
        [_muBtn setTitleColor:[UIColor colorWithHexString:@"#ff9bbc"] forState:(UIControlStateNormal)];
        _muBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_muBtn setImage:[UIImage imageNamed:@"xc_mu"] forState:UIControlStateNormal];
        [_muBtn addTarget:self action:@selector(muBtnAction) forControlEvents:UIControlEventTouchUpInside];

        [UIButton initButton:_muBtn spacing:10];
    }
    return _muBtn;
}
- (UIButton *)jueyuGongBtn {
    if (!_jueyuGongBtn) {
        _jueyuGongBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _jueyuGongBtn.frame = CGRectMake(0, 80, SCREEN_WIDTH / 2, 80);
        [_jueyuGongBtn setTitle:@"公（绝育）" forState:(UIControlStateNormal)];
        [_jueyuGongBtn setTitleColor:[UIColor colorWithHexString:@"#a09bff"] forState:(UIControlStateNormal)];
        _jueyuGongBtn.titleLabel.font = [UIFont systemFontOfSize:14];

        [_jueyuGongBtn setImage:[UIImage imageNamed:@"xc_jueyugong"] forState:UIControlStateNormal];
        [_jueyuGongBtn addTarget:self action:@selector(jueyuGongBtnAction) forControlEvents:UIControlEventTouchUpInside];

        [UIButton initButton:_jueyuGongBtn spacing:10];
    }
    return _jueyuGongBtn;
}

- (UIButton *)jueyuMuBtn {
    if (!_jueyuMuBtn) {
        _jueyuMuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _jueyuMuBtn.frame = CGRectMake(SCREEN_WIDTH / 2, 80 , SCREEN_WIDTH / 2, 80);
        [_jueyuMuBtn setTitle:@"母（绝育）" forState:(UIControlStateNormal)];
        [_jueyuMuBtn setTitleColor:[UIColor colorWithHexString:@"#ff9bbc"] forState:(UIControlStateNormal)];
        _jueyuMuBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_jueyuMuBtn setImage:[UIImage imageNamed:@"xc_jueyumu"] forState:UIControlStateNormal];
        [_jueyuMuBtn addTarget:self action:@selector(jueyuMuBtnBtnAction) forControlEvents:UIControlEventTouchUpInside];

        [UIButton initButton:_jueyuMuBtn spacing:10];
    }
    return _jueyuMuBtn;
}

- (UIView *)sepreShuView {
    if (!_sepreShuView) {
        _sepreShuView = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - 0.5,0, 1, 160)];
        _sepreShuView.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
    }
    return _sepreShuView;
}

- (UIView *)sepreHengView {
    if (!_sepreHengView) {
        _sepreHengView = [[UIView alloc] initWithFrame:CGRectMake(0, 80, [UIScreen mainScreen].bounds.size.width, 1)];
        _sepreHengView.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];

    }
    return _sepreHengView;
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
