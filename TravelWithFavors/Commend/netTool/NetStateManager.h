//
//  NetStateManager.h
//  ZiYuAution
//
//  Created by 江雅芹 on 2017/6/13.
//  Copyright © 2017年 江雅芹. All rights reserved.
//

#import <Foundation/Foundation.h>
#define noneNetWorking   @"已与网络断开链接，请检查网络！"
typedef NS_ENUM (NSInteger,NetStateType){
    NetStateTypeUnknown = 0,
    NetStateTypeNotReachable,
    NetStateTypeReachableViaWWAN,
    NetStateTypeReachableViaWiFi
};
typedef void (^netStateBlock)(NetStateType state);
typedef void(^networkReachabilityUpdateStatus)(BOOL networkStatus);
@interface NetStateManager : NSObject
+ (instancetype)shareManager;
@property (nonatomic, assign, readonly) BOOL isNetCanWork;
@property (nonatomic, assign, readonly) NetStateType stateType;
@property (nonatomic, copy) netStateBlock myBlock;
+ (void)hsNetworkReachabilityUpdateWithStatus:(networkReachabilityUpdateStatus)netStatus;
@end
