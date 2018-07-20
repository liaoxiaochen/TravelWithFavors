//
//  AppService.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/2/26.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "AppService.h"

@implementation AppService
+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self initKeyboard];
        //[self initSahreSDK];
    });
}
#pragma mark ---配置键盘
+ (void)initKeyboard {
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [IQKeyboardManager sharedManager].shouldToolbarUsesTextFieldTintColor = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    [IQKeyboardManager sharedManager].toolbarManageBehaviour = IQAutoToolbarBySubviews;
    [IQKeyboardManager sharedManager].shouldShowToolbarPlaceholder = NO;
    debugLog(@"键盘初始化成功！");
}
#pragma mark --shareSDK
+ (void)initSahreSDK{
    //分享
    [ShareSDK registerActivePlatforms:@[@(SSDKPlatformTypeSinaWeibo),
                                @(SSDKPlatformTypeWechat),
                                @(SSDKPlatformTypeQQ)]
                             onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
            case SSDKPlatformTypeSinaWeibo:
                [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                break;
             default:
                 break;
         }
     }
            onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         switch (platformType)
         {
            case SSDKPlatformTypeSinaWeibo:
                //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                [appInfo SSDKSetupSinaWeiboByAppKey:@"2561150072"                                           appSecret:@"2d3a4b318c64acacedcacb5cead3f66e"
                    redirectUri:@"http://cushiro.cc"
                    authType:SSDKAuthTypeBoth];
                 break;
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:@"wx9a91f54360035a2d"
                              appSecret:@"f824a579df717fa6b8c0822167012992"];
                 break;
             case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:@"1106343296"
                                      appKey:@"1PNrBpudnUkSkXvz"
                                    authType:SSDKAuthTypeBoth];
                 break;
             default:
                 break;
         }
     }];
}
@end
