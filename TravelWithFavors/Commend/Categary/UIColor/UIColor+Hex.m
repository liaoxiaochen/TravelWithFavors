//
//  UIColor+Hex.m
//  HugeDiscountApp
//
//  Created by 江雅芹 on 2017/11/17.
//  Copyright © 2017年 江雅芹. All rights reserved.
//

#import "UIColor+Hex.h"

@implementation UIColor (Hex)
//绘制渐变色颜色的方法
+ (CAGradientLayer *)setGradualChangingColor:(UIView *)view {
    
    //    CAGradientLayer类对其绘制渐变背景颜色、填充层的形状(包括圆角)
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = view.bounds;
    
    //  创建渐变色数组，需要转换为CGColor颜色
    gradientLayer.colors = @[(__bridge id)[UIColor hdMainColor].CGColor,(__bridge id)[UIColor colorWithHexString:@"f4f4f4"].CGColor];
    
    //  设置渐变颜色方向，左上点为(0,0), 右下点为(1,1)
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    
    CGFloat startLocation = [AppConfig getNavigationBarHeight] / SCREENH_HEIGHT;
    CGFloat endLocation = 0.5;
    NSNumber *startNumber = [NSNumber numberWithFloat:startLocation];
    NSNumber *endNumber = [NSNumber numberWithFloat:endLocation];

    //  设置颜色变化点，取值范围 0.0~1.0
    gradientLayer.locations = @[startNumber,  endNumber];

    return gradientLayer;
}


+ (UIColor *)colorWithHexString:(NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    // 判断前缀
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    // 从六位数值中找到RGB对应的位数并转换
    NSRange range;
    range.location = 0;
    range.length = 2;
    //R、G、B
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}


+ (UIColor *)hdBackColor{
    return [self colorWithHexString:@"#e6e6e6"];
}

+ (UIColor *)hdTextColor{
    return [self colorWithHexString:@"#333333"];
}
+ (UIColor *)hdTipTextColor {
    return [self colorWithHexString:@"#999999"];
}
+ (UIColor *)hdPlaceHolderColor{
    return [self colorWithHexString:@"#cdcdcd"];
}

+ (UIColor *)hdMainColor{
    
//    return [self colorWithHexString:@"#3C4562"];
//    return [self colorWithHexString:@"#FF980D"];
    return [self colorWithHexString:@"#7ec2ff"];

}

+ (UIColor *)hdSepreViewColor {
    
    return [self colorWithHexString:@"#e0e0e0"];
}


+ (UIColor *)hdRedColor {
    
    return [self colorWithHexString:@"#ff620d"];
}

+ (UIColor *)hdTableViewBackGoundColor{
    return [self colorWithHexString:@"#F4F4F4"];
}

@end

