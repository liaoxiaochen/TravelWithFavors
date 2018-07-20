//
//  OrderBackApplyPopupView.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/7.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "OrderBackApplyPopupView.h"
#import "OrderBackApplyView.h"
@interface OrderBackApplyPopupView ()
@property (nonatomic, strong) OrderBackApplyView *buttomView;
@end
@implementation OrderBackApplyPopupView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
        self.userInteractionEnabled = YES;
        self.buttomView.frame = CGRectMake(0, frame.size.height - 316 - [AppConfig getButtomHeight], frame.size.width, 316);
        [self addSubview:self.buttomView];
        __block typeof(self) weakSelf = self;
        self.buttomView.commitBlock = ^{
            weakSelf.applyBlock();
        };
    }
    return self;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point=[[touches anyObject] locationInView:self];
    point = [self.buttomView.layer convertPoint:point fromLayer:self.layer];
    if (![self.buttomView.layer containsPoint:point]) {
        [self dismiss];
    }
    
}
- (void)dismiss{
    [self removeFromSuperview];
}
- (OrderBackApplyView *)buttomView{
    if (!_buttomView) {
        _buttomView = [[[NSBundle mainBundle]loadNibNamed:@"OrderBackApplyView" owner:self options:nil] objectAtIndex:0];
        _buttomView.backgroundColor = [UIColor whiteColor];
    }
    return _buttomView;
}
@end
