//
//  UIColor+Hex.h
//  HugeDiscountApp
//
//  Created by 江雅芹 on 2017/11/17.
//  Copyright © 2017年 江雅芹. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)
+ (UIColor *)colorWithHexString:(NSString *)color;
+ (UIColor *)hdOrganColor;
+ (UIColor *)hdBackColor;
+ (UIColor *)hdMainColor;
+ (UIColor *)hdTableViewBackGoundColor;
+ (UIColor *)hdYellowColor;
@end
