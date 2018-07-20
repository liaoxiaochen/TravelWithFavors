//
//  MyTextField.m
//  travelApp
//
//  Created by 江雅芹 on 2017/9/9.
//  Copyright © 2017年 江雅芹. All rights reserved.
//

#import "MyTextField.h"

@implementation MyTextField

//- (instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        [self setUpUI];
//    }
//    return self;
//}
//通过xib创建
//-(void)awakeFromNib
//{
//    [super awakeFromNib];
//    [self setUpUI];
//}

- (void)setUpUI
{
//    self.tintColor = self.textColor;
}
//修改颜色
- (void)setPlaceholderColor:(UIColor *)placeholderColor{
    _placeholderColor = placeholderColor;
    [self setValue:placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
}
//修改字体大小
- (void)setPlaceholderFont:(UIFont *)placeholderFont{
    _placeholderFont = placeholderFont;
    [self setValue:placeholderFont forKeyPath:@"_placeholderLabel.font"];
}
//控制placeHolder的位置
//- (void)drawPlaceholderInRect:(CGRect)rect{
////    if (@available(iOS 11.0, *)) {
//        rect.origin.x = 10;
//        rect.origin.y = 0;
//        rect.size.width = self.bounds.size.width - 20;
//        rect.size.height = self.bounds.size.height;
////    }
//    [super drawPlaceholderInRect:rect];
//}
-(CGRect)placeholderRectForBounds:(CGRect)bounds
{
//    if (@available(iOS 11.0, *)) {
      CGRect inset = CGRectMake(bounds.origin.x, (self.bounds.size.height - bounds.size.height)/2, bounds.size.width, bounds.size.height);
        return inset;
//    }else{
//        return bounds;
//    }
}
@end
