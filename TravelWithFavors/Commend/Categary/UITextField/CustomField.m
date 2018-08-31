//
//  CustomField.m
//  TravelWithFavors
//
//  Created by 强哥的mac on 2018/7/25.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "CustomField.h"

@implementation CustomField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextFillRect(context, CGRectMake(0, CGRectGetHeight(self.frame) - 0.5, CGRectGetWidth(self.frame), 0.5));
}
@end
