//
//  JPushManager.h
//  LQHuangHuaiCollegeApp
//
//  Created by ASooner on 2017/2/28.
//  Copyright © 2017年 LQKJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JPushManager : NSObject

+ (JPushManager *)shareManager;

/*!
 *  @brief 配置注册本地推送
 *
 *  @param launchOptions 启动设置
 */
+ (void)hsConfigureJPushWithOptions:(NSDictionary*)launchOptions;
/*!
 *  @brief 应用启动时判断是否有推送消息
 *
 *  @return YES / NO
 */
+ (BOOL)hsHasLaunchJPushRemoteNotification;
/*!
 *  @brief 本地推送消息
 *
 *  @return NSDictionary 信息
 */
+ (NSDictionary *)hsHasJPushRemotionInfo;

@end
