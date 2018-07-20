//
//  UIColor+Hex.m
//  HugeDiscountApp
//
//  Created by 江雅芹 on 2017/11/17.
//  Copyright © 2017年 江雅芹. All rights reserved.
//

#import "UIColor+Hex.h"

@implementation UIColor (Hex)
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

+ (UIColor *)hdOrganColor{
    return [self colorWithHexString:@"#FF980D"];
}

+ (UIColor *)hdBackColor{
    return [self colorWithHexString:@"#e6e6e6"];
}


+ (UIColor *)hdMainColor{
    
    return [self colorWithHexString:@"#3C4562"];
    
    //    return [UIColor colorWithRed:0.84 green:0.84 blue:0.84 alpha:1.00];
    
}
+ (UIColor *)hdTableViewBackGoundColor{
    return [self colorWithHexString:@"#F4F4F4"];
}
+ (UIColor *)hdYellowColor{
    return [self colorWithHexString:@"#FF980D"];
}
@end

