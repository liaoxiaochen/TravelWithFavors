//
//  NetStateManager.m
//  ZiYuAution
//
//  Created by 江雅芹 on 2017/6/13.
//  Copyright © 2017年 江雅芹. All rights reserved.
//

#import "NetStateManager.h"
#import <AFNetworking/AFNetworkReachabilityManager.h>
static NetStateManager *netStateInstance = nil;
@implementation NetStateManager
+ (instancetype)shareManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (netStateInstance == nil) {
            netStateInstance = [[self alloc] init];
        }
    });
    
    return netStateInstance;
}
+ (id)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (netStateInstance == nil) {
            netStateInstance = [super allocWithZone:zone];
        }
    });
    
    return netStateInstance;
}

- (instancetype)mutableCopy {
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        _isNetCanWork = YES;
        AFNetworkReachabilityManager *manger = [AFNetworkReachabilityManager sharedManager];
        //开启监听，记得开启，不然不走block
        [manger startMonitoring];
        //2.监听改变
        [manger setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            /*
             AFNetworkReachabilityStatusUnknown = -1,
             AFNetworkReachabilityStatusNotReachable = 0,
             AFNetworkReachabilityStatusReachableViaWWAN = 1,
             AFNetworkReachabilityStatusReachableViaWiFi = 2,
             */
            switch (status) {
                case AFNetworkReachabilityStatusUnknown:{
                    NSLog(@"未知");
                    _stateType = NetStateTypeUnknown;
                    _isNetCanWork = YES;
                }

                    break;
                case AFNetworkReachabilityStatusNotReachable:{
                    NSLog(@"没有网络");
                    _stateType = NetStateTypeNotReachable;
                    _isNetCanWork = NO;
                }
                    break;
                case AFNetworkReachabilityStatusReachableViaWWAN:{
                     NSLog(@"3G|4G");
                    _stateType = NetStateTypeReachableViaWWAN;
                    _isNetCanWork = YES;
                }
                    break;
                case AFNetworkReachabilityStatusReachableViaWiFi:{
                     NSLog(@"WiFi");
                    _stateType = NetStateTypeReachableViaWiFi;
                    _isNetCanWork = YES;
                }
                    break;
                default:
                    break;
            }
            
            if (self.myBlock) {
                self.myBlock(_stateType);
            }

        }];
    }
    return self;
}
+ (void)hsNetworkReachabilityUpdateWithStatus:(networkReachabilityUpdateStatus)netStatus {
    [[self shareManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusNotReachable) {
            netStatus(NO);
        } else {
            netStatus(YES);
        }
    }];
}
@end
