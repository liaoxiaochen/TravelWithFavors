//
//  AttributeFooterView.m
//  TravelWithFavors
//
//  Created by MacBook on 2018/8/20.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "AttributeFooterView.h"
#import "PPNumberButton.h"
@interface AttributeFooterView()
@property (nonatomic, strong) PPNumberButton *numberButton;
@property (nonatomic, weak) UIView *buyCountView;
@property (nonatomic, weak)  UILabel *buyLabel;
@end
@implementation AttributeFooterView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
        [self initFrame];
    }
    return self;
}

- (void)initUI {
    
    
    UIView *buyCountView = [[UIView alloc] init];
    buyCountView.backgroundColor = [UIColor whiteColor];
    [self addSubview:buyCountView];
    self.buyCountView = buyCountView;
    
    UILabel *buyLabel = [[UILabel alloc] init];
    buyLabel.font = [UIFont systemFontOfSize:15];
    buyLabel.textColor = [UIColor hdTipTextColor];
    buyLabel.text = @"数量";
    [buyCountView addSubview:buyLabel];
    self.buyLabel = buyLabel;
    
    
    PPNumberButton *numberButton = [PPNumberButton numberButtonWithFrame:CGRectZero];
    //设置边框颜色
    numberButton.borderColor = [UIColor clearColor];
    numberButton.increaseTitle = @"＋";
    numberButton.decreaseTitle = @"－";
    numberButton.minValue = 1;
    numberButton.buttonTitleFont = 12;
    numberButton.longPressSpaceTime = CGFLOAT_MAX;
    
    //    __weak typeof(self) weakSelf = self;
    //    numberButton.resultBlock = ^(PPNumberButton *ppBtn, CGFloat number, BOOL increaseStatus){
    //        weakSelf.productInfo.productCount = number;
    //        if ([weakSelf.delegate respondsToSelector:@selector(refreshPrice)]) {
    //            [weakSelf.delegate refreshPrice];
    //        }
    //    };
    [buyCountView addSubview:numberButton];
    self.numberButton = numberButton;
    
}

- (void)initFrame {
    
    self.buyCountView.frame = CGRectMake(0, 0, self.width, 50);
    [self.buyLabel sizeToFit];
    self.buyLabel.x = 10;
    self.buyLabel.centerY = self.buyCountView.height * 0.5;
    
    self.numberButton.size = CGSizeMake(70, 20);
    self.numberButton.centerY = self.buyLabel.centerY;
    self.numberButton.x = self.buyCountView.width - self.numberButton.width - 10;
}

@end
