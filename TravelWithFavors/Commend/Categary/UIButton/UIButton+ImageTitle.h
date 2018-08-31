//
//  UIButton+ImageTitle.h
//  TravelWithFavors
//
//  Created by MacBook on 2018/8/10.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (ImageTitle)

+ (void)initButton:(UIButton*)btn spacing:(CGFloat)spacing;
- (void)initButtonTitleLeftImageRight;

@end
