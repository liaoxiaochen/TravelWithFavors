//
//  AppDelegate.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/2/26.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "AppDelegate.h"
#import "HDTabBarController.h"
#import "GuideViewController.h"
#import "HROrderPayResultViewController.h"
#import "PurchaseController.h"
#import "OrderPayController.h"
#import "OrderDetailInfoController.h"
#import "OrderChangeController.h"
#import <AlipaySDK/AlipaySDK.h>
#import <AVFoundation/AVFoundation.h>
// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
#import <UMShare/UMShare.h>

#define UMKEY @"5b45aac5f43e48625400009e"

#define WXAPP @"wx9d1256c03b9bf18d"
static NSString *const jpushAppKey = @"8000c54bb03fb02d7c1c1e6c";

#ifdef DEBUG
#define CHANNEL @"debug"
#define isProduction 0
#else
#define isProduction 1
#define CHANNEL @"release"
#endif
//static NSString *const channel = @"Publish channel";
//static BOOL const isProduction = FALSE;
@interface AppDelegate ()<JPUSHRegisterDelegate,WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self registerJPush:launchOptions];
    [WXApi registerApp:WXAPP];
    [self configUSharePlatforms];
    [self confitUShareSettings];
    
    [self mainVC];
    [self clearCookie];
    [self guideVC];
    return YES;
}
- (void)clearCookie{
    NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"Cookie"]];
    NSHTTPCookieStorage * cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie * cookie in cookies){
        [cookieStorage setCookie: cookie];
    }
}
- (void)guideVC{
    GuideViewController *vc = [[GuideViewController alloc] init];
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
}
- (void)mainVC{
    HDTabBarController *tabbarVC = [[HDTabBarController alloc] init];
    self.window.rootViewController = tabbarVC;
    [self.window makeKeyAndVisible];
}

#pragma mark- JPUSHRegisterDelegate
//推送
-(void)registerJPush:(NSDictionary *)launchOptions{
    //配置极光推送
    //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    [JPUSHService setupWithOption:launchOptions appKey:jpushAppKey
                          channel:CHANNEL
                 apsForProduction:isProduction
            advertisingIdentifier:nil];
    NSDictionary *remote = launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey];
    HRLog(@"UIApplicationLaunchOptionsRemoteNotificationKey===%@",remote)
    if (remote) {
        [self performSelector:@selector(receivePush:) withObject:remote afterDelay:0.1];
    }
    //设置接收自定义消息
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}
//极光推送实现注册APNs失败接口（可选）
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

#ifdef NSFoundationVersionNumber_iOS_9_x_Max
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler  API_AVAILABLE(ios(10.0)){
    // Required
    HRLog(@"%@",notification)
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:[notification.request.content.badge integerValue]];
        //[self showLabelWithUserInfo:userInfo color:[UIColor blackColor]];
        [JPUSHService handleRemoteNotification:userInfo];
    }else {
        // 判断为本地通知
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler  API_AVAILABLE(ios(10.0)){
    // Required
    HRLog(@"%@",response.notification)
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:[response.notification.request.content.badge integerValue]];
        [JPUSHService handleRemoteNotification:userInfo];
        HRLog(@"iOS10 收到远程通知:%@", userInfo);
        if ([AppConfig getVibrate]) {
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);//让手机震动
        }
        //[self showLabelWithUserInfo:userInfo color:[UIColor whiteColor]];
//        [self speakWithStr:response.notification.request.content.body];
    }
    else {
        // 判断为本地通知
    }
    completionHandler();  // 系统要求执行这个方法
}
#endif

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    HRLog(@"%@",userInfo)
    NSInteger badge = 0;
    if ([userInfo[@"aps"][@"alert"] isKindOfClass:[NSDictionary class]]) {
        badge = [userInfo[@"aps"][@"alert"][@"badge"] integerValue];
//        [self speakWithStr:userInfo[@"aps"][@"alert"][@"body"]];
    } else {
        badge = [userInfo[@"aps"][@"badge"] integerValue];
//        [self speakWithStr:userInfo[@"aps"][@"alert"]];
    }
    if ([AppConfig getVibrate]) {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);//让手机震动
    }
    //[self showLabelWithUserInfo:userInfo color:[UIColor blueColor]];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:badge];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    HRLog(@"%@",userInfo)
    NSInteger badge = 0;
    if ([userInfo[@"aps"][@"alert"] isKindOfClass:[NSDictionary class]]) {
        badge = [userInfo[@"aps"][@"alert"][@"badge"] integerValue];
//        [self speakWithStr:userInfo[@"aps"][@"alert"][@"body"]];
    } else {
        badge = [userInfo[@"aps"][@"badge"] integerValue];
//        [self speakWithStr:userInfo[@"aps"][@"alert"]];
    }
    //[self showLabelWithUserInfo:userInfo color:[UIColor redColor]];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:badge];
    [JPUSHService handleRemoteNotification:userInfo];
}
-(void)receivePush:(NSDictionary *)userInfo{
    HRLog(@"%@",userInfo)
    NSInteger badge = 0;
    if ([userInfo[@"aps"][@"alert"] isKindOfClass:[NSDictionary class]]) {
        badge = [userInfo[@"aps"][@"alert"][@"badge"] integerValue];
        //[self speakWithStr:userInfo[@"aps"][@"alert"][@"body"]];
    } else {
        badge = [userInfo[@"aps"][@"badge"] integerValue];
        //[self speakWithStr:userInfo[@"aps"][@"alert"]];
    }
    //[self showLabelWithUserInfo:userInfo color:[UIColor blackColor]];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:badge];
}
- (void)networkDidReceiveMessage:(NSNotification *)notification {
    NSDictionary * userInfo = [notification userInfo];
    //    NSString *content = [userInfo valueForKey:@"content"];
    //    NSDictionary *extras = [userInfo valueForKey:@"extras"];
    //    NSString *customizeField1 = [extras valueForKey:@"customizeField1"]; //服务端传递的Extras附加字段，key是自己定义的
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hotPaperMoreInfo" object:nil userInfo:userInfo];
}

#pragma mark- url跳转
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    WeakObj(self)
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
        if ([url.host isEqualToString:@"safepay"]) {
            //跳转支付宝钱包进行支付，处理支付结果
            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
                NSLog(@"result = %@",resultDic);
                [weakself aliPayResult:[resultDic objectForKey:@"resultStatus"]];
            }];
        }
        if ([WXAPP isEqualToString:url.scheme]) {
            return  [WXApi handleOpenURL:url delegate:(id<WXApiDelegate>)self];
        }
    }
    return result;
    //    return YES;
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    WeakObj(self)
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
        if ([url.host isEqualToString:@"safepay"]) {
            //跳转支付宝钱包进行支付，处理支付结果
            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
                NSLog(@"result = %@",resultDic);
                [weakself aliPayResult:[resultDic objectForKey:@"resultStatus"]];
            }];
        }
        if ([WXAPP isEqualToString:url.scheme]) {
            return  [WXApi handleOpenURL:url delegate:(id<WXApiDelegate>)self];
        }
    }
    return result;
    //return YES;
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    WeakObj(self)
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
    if (!result) {
        // 其他如支付等SDK的回调
        if ([url.host isEqualToString:@"safepay"]) {
            //跳转支付宝钱包进行支付，处理支付结果
            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
                NSLog(@"result = %@",resultDic);
                [weakself aliPayResult:[resultDic objectForKey:@"resultStatus"]];
            }];
        }
        if ([WXAPP isEqualToString:url.scheme]) {
            return  [WXApi handleOpenURL:url delegate:(id<WXApiDelegate>)self];
        }
    }
    return result;
    //    return YES;
}
#pragma mark- 其他
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [JPUSHService setBadge:0];//临时清零
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    [[NSNotificationCenter defaultCenter] postNotificationName:@"applicationWillEnterForeground" object:nil];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
-(void)speakWithStr:(NSString *)str{
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:str];
    AVSpeechSynthesizer *synth = [[AVSpeechSynthesizer alloc] init];
    [synth speakUtterance:utterance];
}

#pragma mark   ==============友盟分享==============

- (void)confitUShareSettings
{
    [[UMSocialManager defaultManager] setUmSocialAppkey:UMKEY];
    /*
     * 打开图片水印
     */
    //[UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    /*
     * 关闭强制验证https，可允许http图片分享，但需要在info.plist设置安全域名
     <key>NSAppTransportSecurity</key>
     <dict>
     <key>NSAllowsArbitraryLoads</key>
     <true/>
     </dict>
     */
    //[UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
}

- (void)configUSharePlatforms
{
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx6aff72c1bc1cdc93" appSecret:@"8773ae04094d8784740be0cd4f2375b3" redirectURL:@"http://mobile.umeng.com/social"];
    /*
     * 移除相应平台的分享，如微信收藏
     */
    //[[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1106756969"/*设置QQ平台的appID*/  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    /* 设置新浪的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"3921700954"  appSecret:@"04b48b094faeb16683c32669824ebdad" redirectURL:@"https://sns.whalecloud.com/sina2/callback"];

}

#pragma mark   ==============支付宝回调==============
-(void)aliPayResult:(id)resultStatus{
    BOOL flag = false;
    NSString *jumpType = nil;
    NSArray *controllers = [AppConfig currentViewController].navigationController.viewControllers;
    NSMutableArray *tmpArray = [NSMutableArray array];
    if (controllers.count > 1) {
        for (UIViewController *vc in controllers) {
            if ([vc isKindOfClass:[PurchaseController class]]) {
                [tmpArray addObject:vc];
            }
            if ([vc isKindOfClass:[OrderPayController class]]) {
                flag = true;
            }
        }
        if (tmpArray.count > 0) {
            [AppConfig currentViewController].navigationController.viewControllers = tmpArray;
        }else{
            if ([@"1" isEqualToString:jumpType]) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"orderDetailPage" object:nil];
            }else if ([@"2" isEqualToString:jumpType]){
                [[NSNotificationCenter defaultCenter] postNotificationName:@"orderChangePage" object:nil];
            }
        }
    }
    HROrderPayResultViewController *vc = [[HROrderPayResultViewController alloc] init];
    if ([resultStatus integerValue] == 9000) {
        HRLog(@"支付成功")
        vc.result = YES;
    }else{
        HRLog(@"支付出错")
        vc.result = NO;
    }
    if (tmpArray.count <= 0) {
        vc.jumpType = @"2";
        if (flag) {
            [[AppConfig currentViewController].navigationController popViewControllerAnimated:YES];
        }
    }
    vc.hidesBottomBarWhenPushed = YES;
    [[AppConfig currentViewController].navigationController pushViewController:vc animated:YES];
}
#pragma mark   ==============微信回调,有支付结果的时候会回调这个方法==============
- (void)onResp:(BaseResp *)resp{
    BOOL flag = false;
    NSString *jumpType = nil;
    NSArray *controllers = [AppConfig currentViewController].navigationController.viewControllers;
    NSMutableArray *tmpArray = [NSMutableArray array];
    if (controllers.count > 1) {
        for (UIViewController *vc in controllers) {
            if ([vc isKindOfClass:[PurchaseController class]]) {
                [tmpArray addObject:vc];
            }
            if ([vc isKindOfClass:[OrderPayController class]]) {
                flag = true;
            }
            if ([vc isKindOfClass:[OrderDetailInfoController class]]) {
                jumpType = @"1";
            }
            if ([vc isKindOfClass:[OrderChangeController class]]) {
                jumpType = @"2";
            }
            
        }
        if (tmpArray.count > 0) {
            [AppConfig currentViewController].navigationController.viewControllers = tmpArray;
        }else{
            if ([@"1" isEqualToString:jumpType]) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"orderDetailPage" object:nil];
            }else if ([@"2" isEqualToString:jumpType]){
                [[NSNotificationCenter defaultCenter] postNotificationName:@"orderChangePage" object:nil];
            }
        }
    }
    
    HROrderPayResultViewController *vc = [[HROrderPayResultViewController alloc] init];
    if([resp isKindOfClass:[PayResp class]]){
        switch (resp.errCode) {
            case WXSuccess:{
                HRLog(@"支付成功")
                vc.result = YES;
                break;
            }
            default:{
                HRLog(@"支付失败")
                vc.result = NO;
                break;
            }
        }
        if (tmpArray.count <= 0) {
            vc.jumpType = @"2";
            if (flag) {
                [[AppConfig currentViewController].navigationController popViewControllerAnimated:YES];
            }
        }
        vc.hidesBottomBarWhenPushed = YES;
        [[AppConfig currentViewController].navigationController pushViewController:vc animated:YES];
    }
}

//测试使用   将通知的值显示在主界面上
- (void)showLabelWithUserInfo:(NSDictionary *)userInfo color:(UIColor *)color
{
    UILabel *label = [UILabel new];
    label.backgroundColor = color;
    label.frame = CGRectMake(0, 250, [UIScreen mainScreen].bounds.size.width, 300);
    label.text = userInfo.description;
    label.numberOfLines = 0;
    [[UIApplication sharedApplication].keyWindow addSubview:label];
}
@end
