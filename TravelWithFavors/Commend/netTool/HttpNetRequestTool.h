//
//  HttpNetRequestTool.h
//  HugeDiscountApp
//
//  Created by 江雅芹 on 2018/1/10.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <Foundation/Foundation.h>
UIKIT_EXTERN NSString *const base_url;
typedef NS_ENUM(NSUInteger,HttpNetRequestType){
    
    HttpNetRequestGet = 0,
    HttpNetRequestPost
};
typedef NS_ENUM(NSInteger, PayWay)
{
    AliPayWay = 0,
    WeChatPayWay,
};
typedef NS_ENUM(NSInteger, LogisticWay)
{
    ShunFengWay = 0,
    EMSWay,
};
typedef void(^HttpRequestSuccessBlock)(id Json);
typedef void(^HttpRequestFailureBlock)(NSString *error);
typedef void(^downloadProgress)(float progress);
@interface HttpNetRequestTool : NSObject
+ (NSString *)requestUrlString:(NSString *)url;
 
/**
 *  带超时、进度请求
 *
 *  @param type        请求类型
 *  @param url         请求地址
 *  @param time        超时时限
 *  @param paraments   请求参数
 *  @param progress    请求进度
 *  @param success     请求成功过返回值
 *  @param failure     请求失败返回值
 */
+ (void)netRequest:(HttpNetRequestType)type urlString:(NSString *)url outTime:(NSTimeInterval)time paraments:(id)paraments isHeader:(BOOL)header progress:(downloadProgress)progress success:(HttpRequestSuccessBlock)success failure:(HttpRequestFailureBlock)failure;
/**
 *  默认超时、带进度请求
 *
 *  @param type        请求类型
 *  @param url         请求地址
 *  @param paraments   请求参数
 *  @param progress    请求进度
 *  @param success     请求成功过返回值
 *  @param failure     请求失败返回值
 */
+ (void)netRequest:(HttpNetRequestType)type urlString:(NSString *)url paraments:(id)paraments progress:(downloadProgress)progress success:(HttpRequestSuccessBlock)success failure:(HttpRequestFailureBlock)failure;
/**
 *  带超时、无进度请求
 *
 *  @param type        请求类型
 *  @param url         请求地址
 *  @param time        超时时限
 *  @param paraments   请求参数
 *  @param success     请求成功过返回值
 *  @param failure     请求失败返回值
 */
+ (void)netRequest:(HttpNetRequestType)type urlString:(NSString *)url outTime:(NSTimeInterval)time paraments:(id)paraments isHeader:(BOOL)header success:(HttpRequestSuccessBlock)success failure:(HttpRequestFailureBlock)failure;
//返回
+ (NSURLSessionDataTask *)netRequestReturnTask:(HttpNetRequestType)type urlString:(NSString *)url outTime:(NSTimeInterval)time paraments:(id)paraments isHeader:(BOOL)header success:(HttpRequestSuccessBlock)success failure:(HttpRequestFailureBlock)failure;
/**
 *  默认超时、无进度请求
 *
 *  @param type        请求类型
 *  @param url         请求地址
 *  @param paraments   请求参数
 *  @param success     请求成功过返回值
 *  @param failure     请求失败返回值
 */
+ (void)netRequest:(HttpNetRequestType)type urlString:(NSString *)url paraments:(id)paraments success:(HttpRequestSuccessBlock)success failure:(HttpRequestFailureBlock)failure;
//返回
+ (NSURLSessionDataTask *)netRequestReturnTask:(HttpNetRequestType)type urlString:(NSString *)url paraments:(id)paraments success:(HttpRequestSuccessBlock)success failure:(HttpRequestFailureBlock)failure;
/**
 *  设置请求头
 *
 */
+ (void)netRequestWithHeader:(HttpNetRequestType)type urlString:(NSString *)url paraments:(id)paraments success:(HttpRequestSuccessBlock)success failure:(HttpRequestFailureBlock)failure;
/**
 *  上传单张图片
 *
 */
+ (void)uploadHeaderImage:(NSString *)url paraments:(id)paraments imageName:(NSString *)imageName image:(UIImage *)image progress:(downloadProgress)progress success:(HttpRequestSuccessBlock)success failure:(HttpRequestFailureBlock)failure;
+ (void)upLoadImage:(NSString *)url paraments:(NSDictionary *)paraments imageName:(NSString *)name imageLists:(NSArray *)imageLists progress:(downloadProgress)progress successBlock:(HttpRequestSuccessBlock)success failureBlock:(HttpRequestFailureBlock)failure;
@end
