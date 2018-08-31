//
//  UIColor+Hex.h
//  HugeDiscountApp
//
//  Created by 江雅芹 on 2017/11/17.
//  Copyright © 2017年 江雅芹. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)
//绘制渐变色颜色的方法
+ (CAGradientLayer *)setGradualChangingColor:(UIView *)view;
+ (UIColor *)colorWithHexString:(NSString *)color;

+ (UIColor *)hdBackColor;
+ (UIColor *)hdTextColor;
+ (UIColor *)hdTipTextColor;
+ (UIColor *)hdPlaceHolderColor;
+ (UIColor *)hdMainColor;
+ (UIColor *)hdRedColor;
+ (UIColor *)hdSepreViewColor;
+ (UIColor *)hdTableViewBackGoundColor;

@end
