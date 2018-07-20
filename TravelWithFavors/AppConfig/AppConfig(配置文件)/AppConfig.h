//
//  AppConfig.h
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/2.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppConfig : NSObject
+ (void)setLoginState:(BOOL)state;
+ (BOOL)getLoginState;
+ (void)setUserName:(NSString *)name;
+ (NSString *)getUserName;
+ (void)setPassWord:(NSString *)pass;
+ (NSString *)getPassWord;
+ (void)setLoginToken:(NSString *)token;
+ (NSString *)getLoginToken;
+ (void)setLoginID:(NSString *)loginId;
+ (NSString *)getloginID;
+ (BOOL)getVibrate;//开启震动
+ (void)setVibrate:(BOOL)vibrate;
+ (NSString *)getUserIcon;
+ (void)setUserIcon:(NSString *)url;
+ (CGFloat)getNavigationBarHeight;
+ (CGFloat)getTabBarHeight;
+ (CGFloat)getStatusBarHeight;
+ (CGFloat)getButtomHeight;
//获取Window当前显示的ViewController
+ (UIViewController*)currentViewController;
@end
