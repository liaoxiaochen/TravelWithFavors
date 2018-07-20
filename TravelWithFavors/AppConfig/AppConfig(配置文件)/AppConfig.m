//
//  AppConfig.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/2.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "AppConfig.h"
static NSString *const loginState = @"loginState";
static NSString *const userName = @"userName";
static NSString *const passWord = @"passWord";
static NSString *const loginToken = @"loginToken";
static NSString *const loginID = @"loginID";
static NSString *const vibrateState = @"vibrateState";
@implementation AppConfig
+ (void)setLoginState:(BOOL)state{
    [[NSUserDefaults standardUserDefaults] setBool:state forKey:loginState];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (BOOL)getLoginState{
    return [[NSUserDefaults standardUserDefaults] boolForKey:loginState];
}
+ (void)setUserName:(NSString *)name{
    [[NSUserDefaults standardUserDefaults] setObject:name forKey:userName];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSString *)getUserName{
    return [[NSUserDefaults standardUserDefaults] objectForKey:userName];
}
+ (void)setPassWord:(NSString *)pass{
    [[NSUserDefaults standardUserDefaults] setObject:pass forKey:passWord];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSString *)getPassWord{
    return [[NSUserDefaults standardUserDefaults] objectForKey:passWord];
}
+ (void)setLoginToken:(NSString *)token{
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:loginToken];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSString *)getLoginToken{
    return [[NSUserDefaults standardUserDefaults] objectForKey:loginToken];
}
+ (void)setLoginID:(NSString *)loginId{
    [[NSUserDefaults standardUserDefaults] setObject:loginId forKey:loginID];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSString *)getloginID{
    return [[NSUserDefaults standardUserDefaults] objectForKey:loginID];
}
+ (BOOL)getVibrate{
    return [[NSUserDefaults standardUserDefaults] objectForKey:vibrateState];
}
+ (void)setVibrate:(BOOL)vibrate{
    [[NSUserDefaults standardUserDefaults] setBool:vibrate forKey:vibrateState];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getUserIcon{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"iconUrl"];
}
+ (void)setUserIcon:(NSString *)url{
    [[NSUserDefaults standardUserDefaults] setObject:url forKey:@"iconUrl"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)iPhoneX{
    return [UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO;
}
+ (CGFloat)getNavigationBarHeight{
    if ([self iPhoneX]) {
        return 88.0;
    } else {
        return 64.0;
    }
}
+ (CGFloat)getTabBarHeight{
    if ([self iPhoneX]) {
        return 83.0;
    } else {
        return 49.0;
    }
}
+ (CGFloat)getStatusBarHeight{
    if ([self iPhoneX]) {
        return 44.0;
    } else {
        return 20.0;
    }
}
+ (CGFloat)getButtomHeight{
    if ([self iPhoneX]) {
        return 34.0;
    } else {
        return 0.0;
    }
}

//获取Window当前显示的ViewController
+ (UIViewController*)currentViewController{
    //获得当前活动窗口的根视图
    UIViewController* vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (1)
    {
        //根据不同的页面切换方式，逐步取得最上层的viewController
        if ([vc isKindOfClass:[UITabBarController class]]) {
            vc = ((UITabBarController*)vc).selectedViewController;
        }
        if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = ((UINavigationController*)vc).visibleViewController;
        }
        if (vc.presentedViewController) {
            vc = vc.presentedViewController;
        }else{
            break;
        }
    }
    return vc;
}
@end
