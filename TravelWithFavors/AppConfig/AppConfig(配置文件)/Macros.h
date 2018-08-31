//
//  Macros.h
//  travelApp
//
//  Created by 江雅芹 on 2017/8/3.
//  Copyright © 2017年 江雅芹. All rights reserved.
//

#ifndef Macros_h
#define Macros_h


#define HDSelecteTableRowHeight 50
#define NONETWORKING                @"无网络,请检查网络设置"
#define SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width//屏幕宽度
#define SCREENH_HEIGHT [UIScreen mainScreen].bounds.size.height//屏幕高度
#define View_WIDTH   self.view.frame.size.width//屏幕宽度
#define View_HEIGHT  self.view.frame.size.height//屏幕高度

#define CONTENT_WIDTH self.contentView.frame.size.width
#define CONTENT_HEIGHT self.contentView.frame.size.height

#define SELF_WIDTH self.frame.size.width
#define SELF_HEIGHT self.frame.size.height

//#define Tabbar_Height   [AppConfig getTabBarHeight]//tabbar的高度

// View 圆角
#define ViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]


#define WeakObj(o) __weak typeof(o) weak##o = o;
#define BlockObj(o) __block typeof(o) block##o = o;
#define StrongObj(o) __strong typeof(o) strong##o = o;


#define HRFunc HRLog(@"%s",__func__)

#ifdef DEBUG
#define HRLog(format, ...) printf("class: <%s:(%d) > method: %s \n%s\n", [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __PRETTY_FUNCTION__, [[NSString stringWithFormat:(format), ##__VA_ARGS__] UTF8String] );
#else
#define HRLog(format, ...)
#endif

#define IOS11_OR_LATER [UIDevice currentDevice].systemVersion.doubleValue >= 11.0

// 判断是否为 iPhone 5SE
#define iPhone5SE [[UIScreen mainScreen] bounds].size.width == 320.0f && [[UIScreen mainScreen] bounds].size.height == 568.0f

// 判断是否为iPhone 6/6s
#define iPhone6_6s [[UIScreen mainScreen] bounds].size.width == 375.0f && [[UIScreen mainScreen] bounds].size.height == 667.0f

// 判断是否为iPhone 6Plus/6sPlus
#define iPhone6Plus_6sPlus [[UIScreen mainScreen] bounds].size.width == 414.0f && [[UIScreen mainScreen] bounds].size.height == 736.0f
/** 自定义Log */
#ifdef DEBUG
#define debugLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define debugLog(...)

//#define scaleHeight(x)  (x/375.0f*[UIScreen mainScreen].bounds.size.width)
#endif
#endif /* Macros_h */
