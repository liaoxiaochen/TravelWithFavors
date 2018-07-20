//
//  HRfunctionButton.m
//  24k_company
//
//  Created by xunjie on 2017/5/9.
//  Copyright © 2017年 xunjie. All rights reserved.
//

#import "HRfunctionButton.h"

CGFloat tishi_width = 26;
CGFloat tishi_font = 16;
@implementation HRfunctionButton
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
        self.tiShiLB = [[UILabel alloc] init];
        self.tiShiLB.backgroundColor = [UIColor colorWithRed:250.0/255 green:8.0/255 blue:25.0/255 alpha:1.0];
        self.tiShiLB.textAlignment = NSTextAlignmentCenter;
        self.tiShiLB.font = [UIFont systemFontOfSize:tishi_font];
        self.tiShiLB.textColor = [UIColor whiteColor];
        self.tiShiLB.hidden = true;
        
        self.tiShiLB.frame = CGRectMake(0, 0, tishi_width, tishi_width);
        //self.tiShiLB.layer.anchorPoint = CGPointMake(0.5, 0.5);
        self.tiShiLB.layer.position = CGPointMake(self.imageView.width - 10, 10);
        self.tiShiLB.layer.cornerRadius = tishi_width/2.0;
        self.tiShiLB.layer.masksToBounds = YES;
        self.tiShiLB.text = @"0";
        self.imageView.clipsToBounds = NO;
        [self.imageView addSubview:self.tiShiLB];
        if (!self.tiShiLB.observationInfo) {
            [self.tiShiLB addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
        }
    }
    return self;
}
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
    CGFloat margin = 3;
    CGFloat imageW=self.imageView.frame.size.width;
    CGFloat imageH=self.imageView.frame.size.height;
    CGFloat x=(self.frame.size.width-imageW)/2;
    CGFloat titleW = self.frame.size.width;
    CGFloat titleH=self.titleLabel.frame.size.height;
    CGFloat y=(self.frame.size.height - imageH - titleH - margin)/2;
    CGFloat titleY = y + imageH + margin;
    self.titleLabel.frame=CGRectMake(0, titleY, titleW, titleH);
    self.imageView.frame=CGRectMake(x, y, imageW, imageH);
    
    CGRect rect = [self.tiShiLB.text boundingRectWithSize:CGSizeMake(50, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:tishi_font]} context:nil];
    
    if (rect.size.width < tishi_width) {
        self.tiShiLB.width = tishi_width;
    }else{
        self.tiShiLB.width = rect.size.width + 5;
    }

}
- (void)setHighlighted:(BOOL)highlighted{
    
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([@"text" isEqualToString:keyPath]) {
        CGRect rect = [self.tiShiLB.text boundingRectWithSize:CGSizeMake(50, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:tishi_font]} context:nil];
        
        if (rect.size.width < tishi_width) {
            self.tiShiLB.width = tishi_width;
        }else{
            self.tiShiLB.width = rect.size.width + 5;
        }
    }
}
- (void)dealloc
{
    if (self.tiShiLB.observationInfo) {
        [self.tiShiLB removeObserver:self forKeyPath:@"text"];
    }
}

@end
