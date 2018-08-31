//
//  IBAlertView.m
//  IBAlertView
//
//  Created by iBlocker on 2017/8/7.
//  Copyright © 2017年 iBlocker. All rights reserved.
//

#import "IBAlertView.h"

@interface IBAlertView () {
    CGFloat _viewHeight;
}
@property (nonatomic, strong) IBConfigration *configration;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *messageLab;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *confirmButton;
@property (nonatomic, copy) IBAlertBlock alertBlock;
@end

@implementation IBAlertView

+ (instancetype)alertWithConfigration:(IBConfigration *)configration block:(IBAlertBlock)block {
    
    IBAlertView *alertView = [[IBAlertView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    alertView.backgroundColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.5];
    alertView.configration = configration;
    alertView.alertBlock = block;
    [alertView handleSubviews];
    
    return alertView;
}

- (void)setConfigration:(IBConfigration *)configration {
    
    if (!configration) {
        configration.title = @"title";
        configration.message = @"message";
        configration.cancelTitle = @"Cancel";
        configration.confirmTitle = @"Confirm";
        configration.messageAlignment = NSTextAlignmentLeft;
    }
    if (!configration.title) {
        configration.title = @"温馨提示";
    }
    if (!configration.cancelTitle) {
        configration.cancelTitle = @"取消";
    }
    if (!configration.confirmTitle) {
        configration.confirmTitle = @"确认";
    }
    CGRect rect = [self getHeightOfText:configration.message width:kScreenWidth - 100 font:[UIFont systemFontOfSize:14]];
    _viewHeight = rect.size.height + 39 + 15 + 50 + 22;
    self.messageLab.text = configration.message;
    self.messageLab.textAlignment = configration.messageAlignment;
    self.messageLab.frame = (CGRect){20, self.titleLab.frame.origin.y + 45, kScreenWidth - 100, rect.size.height};
    
    self.titleLab.text = configration.title;
    [self.cancelButton setTitle:configration.cancelTitle forState:UIControlStateNormal];
    [self.confirmButton setTitle:configration.confirmTitle forState:UIControlStateNormal];
     self.confirmButton.backgroundColor = [UIColor whiteColor];

    _configration = configration;
}

- (void)handleSubviews {
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.titleLab];
    [self.bgView addSubview:self.messageLab];
    [self.bgView addSubview:self.cancelButton];
    [self.bgView addSubview:self.confirmButton];
}

- (void)show {
    self.alpha = 0;
    [UIView animateWithDuration:0.2 animations:^{
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        [keyWindow addSubview:self];
        [keyWindow bringSubviewToFront:self];
        self.alpha = 1;
    }];
}

#pragma mark - Method
- (CGRect)getHeightOfText:(NSString *)text width:(CGFloat)width font:(UIFont *)font {
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, 0) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil];
    return rect;
}

- (NSArray *)getRGBWithColor:(UIColor *)color {
    CGFloat red = 0.0;
    CGFloat green = 0.0;
    CGFloat blue = 0.0;
    CGFloat alpha = 0.0;
    [color getRed:&red green:&green blue:&blue alpha:&alpha];
    return @[@(red), @(green), @(blue), @(alpha)];
}

#pragma mark - Subviews
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [UIView new];
        _bgView.center = self.center;
        _bgView.bounds = (CGRect){0, 0, kScreenWidth - 60, _viewHeight};
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.cornerRadius = 5;
        _bgView.layer.masksToBounds = YES;
    }
    return _bgView;
}
- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [UILabel new];
        _titleLab.frame = CGRectMake(20, 15, kScreenWidth - 100, 24);
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.font = [UIFont systemFontOfSize:17];
        _titleLab.text = @"温馨提示";
    }
    return _titleLab;
}
- (UILabel *)messageLab {
    if (!_messageLab) {
        _messageLab = [UILabel new];
        _messageLab.font = [UIFont systemFontOfSize:14];
        _messageLab.numberOfLines = 0;
        _messageLab.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _messageLab;
}
- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.frame = (CGRect){0, _viewHeight - 50, (kScreenWidth - 60) / 2.0, 50};
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _cancelButton.tag = 1;
        [_cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
 
        //  点击方法
        [_cancelButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    }
    return _cancelButton;
}
- (UIButton *)confirmButton {
    if (!_confirmButton) {
        _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _confirmButton.frame = (CGRect){(kScreenWidth - 60) / 2.0, _viewHeight - 50, (kScreenWidth - 60) / 2.0, 50};
        _confirmButton.tag = 2;
        [_confirmButton setTitleColor:[UIColor hdMainColor] forState:UIControlStateNormal];
  
        //  点击方法
        [_confirmButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_confirmButton setTitle:@"确认" forState:UIControlStateNormal];

    }
    return _confirmButton;
}

#pragma mark - Action

- (void)buttonClick:(UIButton *)sender {
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    if (self.alertBlock) {
        self.alertBlock(sender.tag);
    }
}

@end
