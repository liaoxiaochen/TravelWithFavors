//
//  JPushManager.m
//  LQHuangHuaiCollegeApp
//
//  Created by ASooner on 2017/2/28.
//  Copyright © 2017年 LQKJ. All rights reserved.
//

#import "JPushManager.h"

static BOOL hasJPush = NO;

static NSDictionary *launchOptions = nil;

@interface JPushManager ()

@property (nonatomic, strong) NSDictionary *jPushDic;

@end

@implementation JPushManager

static JPushManager *pusnInstance = nil;

+ (JPushManager *)shareManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (pusnInstance == nil) {
            pusnInstance = [[self alloc] init];
        }
    });
    
    return pusnInstance;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (pusnInstance == nil) {
            pusnInstance = [super allocWithZone:zone];
        }
    });
    
    return pusnInstance;
}

- (instancetype)mutableCopy {
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (NSDictionary *)jPushDic{
    if (_jPushDic == nil) {
        _jPushDic = [NSDictionary dictionary];
    }
    return _jPushDic;
}

+ (void)hsConfigureJPushWithOptions:(NSDictionary*)launchOptions{
    if (launchOptions != nil) {
        UILocalNotification *note = launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey];
        NSDictionary *jPushRem = note.userInfo;
        if (jPushRem != nil) {
            hasJPush = YES;
            [self shareManager].jPushDic = jPushRem;
        }else{
            hasJPush = NO;
            [self shareManager].jPushDic = @{};
        }
    } else {
        hasJPush = NO;
        [self shareManager].jPushDic = @{};
    }
}
/*!
 *  @brief 应用启动时判断是否有本地推送消息
 *
 *  @return YES / NO
 */
+ (BOOL)hsHasLaunchJPushRemoteNotification{
    return hasJPush;
}
/*!
 *  @brief 本地推送消息
 *
 *  @return NSDictionary 信息
 */
+ (NSDictionary *)hsHasJPushRemotionInfo{
    return [self shareManager].jPushDic;
}


@end
