//
//  HttpNetRequestTool.m
//  HugeDiscountApp
//
//  Created by 江雅芹 on 2018/1/10.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "HttpNetRequestTool.h"
#import <AFNetworking/AFNetworking.h>
#import "NetStateManager.h"
#import "LoginController.h"
#import "LoginNavigationController.h"

NSString *const base_url = @"http://xiechong.hlhjapp.com";
NSInteger const outTime = 120;
@implementation HttpNetRequestTool
+ (void)netRequest:(HttpNetRequestType)type urlString:(NSString *)url paraments:(id)paraments progress:(downloadProgress)progress success:(HttpRequestSuccessBlock)success failure:(HttpRequestFailureBlock)failure{
    [self netRequest:type urlString:url outTime:outTime paraments:paraments isHeader:NO progress:progress success:success failure:failure];
}
+ (void)netRequest:(HttpNetRequestType)type urlString:(NSString *)url outTime:(NSTimeInterval)time paraments:(id)paraments isHeader:(BOOL)header progress:(downloadProgress)progress success:(HttpRequestSuccessBlock)success failure:(HttpRequestFailureBlock)failure{
    if ([NetStateManager shareManager].isNetCanWork) {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer.timeoutInterval = time;
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"application/json",@"text/javascript",@"text/html", @"application/javascript", @"text/js", nil];
        if (header) {
            [manager.requestSerializer setValue:[AppConfig getloginID] forHTTPHeaderField:@"uid"];
            [manager.requestSerializer setValue:[AppConfig getLoginToken] forHTTPHeaderField:@"logintoken"];
            HRLog(@"loginID====%@,token===%@",[AppConfig getloginID],[AppConfig getLoginToken])
        }
        switch (type) {
            case HttpNetRequestGet:{
                
                [manager GET:url parameters:paraments progress:^(NSProgress * _Nonnull downloadProgress) {
                    if (downloadProgress) {
                        if (progress) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                progress((CGFloat)downloadProgress.completedUnitCount / (CGFloat)downloadProgress.totalUnitCount);
                            });
                        }
                        
                    }
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    //存cookie
//                    NSData *cookiesData = [NSKeyedArchiver archivedDataWithRootObject: [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]];
//                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//                    [defaults setObject: cookiesData forKey:@"Cookie"];
//                    [defaults synchronize];
                    if ([responseObject[@"code"] integerValue] == 10002) {
                        [AppConfig setLoginState:NO];
                        [AppConfig setLoginID:nil];
                        [AppConfig setLoginToken:nil];
                        [AppConfig setUserName:nil];
                        [AppConfig setPassWord:nil];
                        [AppConfig setUserIcon:nil];
                        LoginController *vc = [[LoginController alloc] init];
                        LoginNavigationController *nav = [[LoginNavigationController alloc] initWithRootViewController:vc];
                        [[AppConfig currentViewController].navigationController presentViewController:nav animated:YES completion:nil];
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"logout" object:nil];
                        if (success) {
                            success(responseObject);
                        }
                    }else{
                        if (success) {
                            success(responseObject);
                        }
                    }
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    if (failure) {
//                        failure(error.localizedDescription);
                        failure(@"哎呀，服务器开小差了");
                        HRLog(@"%@",error);
                    }
                }];
            }
                break;
                
            default:{
                [manager POST:url parameters:paraments progress:^(NSProgress * _Nonnull uploadProgress) {
                    if (uploadProgress) {
                        if (progress) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                progress((CGFloat)uploadProgress.completedUnitCount / (CGFloat)uploadProgress.totalUnitCount);
                            });
                        }
                    }
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    //存cookie
//                    NSData *cookiesData = [NSKeyedArchiver archivedDataWithRootObject: [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]];
//                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//                    [defaults setObject: cookiesData forKey:@"Cookie"];
//                    [defaults synchronize];
                    if ([responseObject[@"code"] integerValue] == 10002) {
                        [AppConfig setLoginState:NO];
                        [AppConfig setLoginID:nil];
                        [AppConfig setLoginToken:nil];
                        [AppConfig setUserName:nil];
                        [AppConfig setPassWord:nil];
                        LoginController *vc = [[LoginController alloc] init];
                        LoginNavigationController *nav = [[LoginNavigationController alloc] initWithRootViewController:vc];
                        [[AppConfig currentViewController].navigationController presentViewController:nav animated:YES completion:nil];
//                        [MBProgressHUD hideHUDForView:[AppConfig currentViewController].view animated:YES];
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"logout" object:nil];
                        if (success) {
                            success(responseObject);
                        }
                    }else{
                        if (success) {
                            success(responseObject);
                        }
                    }
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    if (failure) {
//                        failure(error.localizedDescription);//@"请求数据错误"
                        failure(@"哎呀，服务器开小差了");
                        HRLog(@"%@",error);
                    }
                }];
            }
                break;
        }
    }else{
        if (failure) {
            dispatch_async(dispatch_get_main_queue(), ^{
                failure(noneNetWorking);
            });
        }
    }
}
//返回
+ (NSURLSessionDataTask *)netRequestReturnTask:(HttpNetRequestType)type urlString:(NSString *)url outTime:(NSTimeInterval)time paraments:(id)paraments isHeader:(BOOL)header progress:(downloadProgress)progress success:(HttpRequestSuccessBlock)success failure:(HttpRequestFailureBlock)failure{
    if ([NetStateManager shareManager].isNetCanWork) {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer.timeoutInterval = time;
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"application/json",@"text/javascript",@"text/html", @"application/javascript", @"text/js", nil];
        if (header) {
            [manager.requestSerializer setValue:[AppConfig getloginID] forHTTPHeaderField:@"uid"];
            [manager.requestSerializer setValue:[AppConfig getLoginToken] forHTTPHeaderField:@"logintoken"];
        }
        switch (type) {
            case HttpNetRequestGet:{
                
                return [manager GET:url parameters:paraments progress:^(NSProgress * _Nonnull downloadProgress) {
                    if (downloadProgress) {
                        if (progress) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                progress((CGFloat)downloadProgress.completedUnitCount / (CGFloat)downloadProgress.totalUnitCount);
                            });
                        }
                        
                    }
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    //存cookie
                    //                    NSData *cookiesData = [NSKeyedArchiver archivedDataWithRootObject: [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]];
                    //                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                    //                    [defaults setObject: cookiesData forKey:@"Cookie"];
                    //                    [defaults synchronize];
                    if (success) {
                        success(responseObject);
                    }
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    if (failure) {
                        //                        failure(error.localizedDescription);
                        failure(@"哎呀，服务器开小差了");
                    }
                }];
            }
                break;
                
            default:{
                return [manager POST:url parameters:paraments progress:^(NSProgress * _Nonnull uploadProgress) {
                    if (uploadProgress) {
                        if (progress) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                progress((CGFloat)uploadProgress.completedUnitCount / (CGFloat)uploadProgress.totalUnitCount);
                            });
                        }
                    }
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    //存cookie
                    //                    NSData *cookiesData = [NSKeyedArchiver archivedDataWithRootObject: [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]];
                    //                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                    //                    [defaults setObject: cookiesData forKey:@"Cookie"];
                    //                    [defaults synchronize];
                    if (success) {
                        success(responseObject);
                    }
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    if (failure) {
                        //                        failure(error.localizedDescription);//@"请求数据错误"
                        failure(@"哎呀，服务器开小差了");
                    }
                }];
            }
                break;
        }
    }else{
        if (failure) {
            dispatch_async(dispatch_get_main_queue(), ^{
                failure(noneNetWorking);
            });
        }
    }
    return nil;
}

+ (void)uploadHeaderImage:(NSString *)url paraments:(id)paraments imageName:(NSString *)imageName image:(UIImage *)image progress:(downloadProgress)progress success:(HttpRequestSuccessBlock)success failure:(HttpRequestFailureBlock)failure{
    if ([NetStateManager shareManager].isNetCanWork) {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer.timeoutInterval = outTime;
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"application/json",@"text/javascript",@"text/html", @"application/javascript", @"text/js", nil];
        [manager POST:url parameters:paraments constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            NSData *imageDatas = UIImageJPEGRepresentation(image, 0.5);
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
            [formData appendPartWithFileData:imageDatas name:imageName fileName:fileName mimeType:@"image/jpeg"];
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            if (uploadProgress) {
                if (progress) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        progress((CGFloat)uploadProgress.completedUnitCount / (CGFloat)uploadProgress.totalUnitCount);
                    });
                }
            }
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //存cookie
            NSData *cookiesData = [NSKeyedArchiver archivedDataWithRootObject: [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]];
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject: cookiesData forKey:@"Cookie"];
            [defaults synchronize];
            if (success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
//                failure(error.localizedDescription);//@"请求数据错误"
                failure(@"哎呀，服务器开小差了");
            }
        }];
    }else{
        if (failure) {
            dispatch_async(dispatch_get_main_queue(), ^{
                failure(noneNetWorking);
            });
        }
    }
}
+ (void)netRequest:(HttpNetRequestType)type urlString:(NSString *)url outTime:(NSTimeInterval)time paraments:(id)paraments isHeader:(BOOL)header success:(HttpRequestSuccessBlock)success failure:(HttpRequestFailureBlock)failure{
    [self netRequest:type urlString:url outTime:time paraments:paraments isHeader:header progress:nil success:success failure:failure];
}
//返回
+ (NSURLSessionDataTask *)netRequestReturnTask:(HttpNetRequestType)type urlString:(NSString *)url outTime:(NSTimeInterval)time paraments:(id)paraments isHeader:(BOOL)header success:(HttpRequestSuccessBlock)success failure:(HttpRequestFailureBlock)failure{
    return [self netRequestReturnTask:type urlString:url outTime:time paraments:paraments isHeader:header progress:nil success:success failure:failure];
}

+ (void)netRequest:(HttpNetRequestType)type urlString:(NSString *)url paraments:(id)paraments success:(HttpRequestSuccessBlock)success failure:(HttpRequestFailureBlock)failure{
    [self netRequest:type urlString:url outTime:outTime paraments:paraments isHeader:NO success:success failure:failure];
}
////返回
+ (NSURLSessionDataTask *)netRequestReturnTask:(HttpNetRequestType)type urlString:(NSString *)url paraments:(id)paraments success:(HttpRequestSuccessBlock)success failure:(HttpRequestFailureBlock)failure{
    return [self netRequestReturnTask:type urlString:url outTime:outTime paraments:paraments isHeader:NO success:success failure:failure];
}

+ (void)netRequestWithHeader:(HttpNetRequestType)type urlString:(NSString *)url paraments:(id)paraments success:(HttpRequestSuccessBlock)success failure:(HttpRequestFailureBlock)failure{
    
    [self netRequest:type urlString:url outTime:outTime paraments:paraments isHeader:YES success:success failure:failure];
}
+ (void)upLoadImage:(NSString *)url paraments:(NSDictionary *)paraments imageName:(NSString *)name imageLists:(NSArray *)imageLists progress:(downloadProgress)progress successBlock:(HttpRequestSuccessBlock)success failureBlock:(HttpRequestFailureBlock)failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = outTime;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"application/json",@"text/javascript",@"text/html", @"application/javascript", @"text/js", nil];
    [manager.requestSerializer setValue:[AppConfig getloginID] forHTTPHeaderField:@"uid"];
    [manager.requestSerializer setValue:[AppConfig getLoginToken] forHTTPHeaderField:@"logintoken"];
    [manager POST:url parameters:paraments constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (UIImage *image in imageLists) {
            NSData *imageDatas = UIImageJPEGRepresentation(image, 0.5);
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
            //上传的参数(上传图片，以文件流的格式)
            [formData appendPartWithFileData:imageDatas
                                        name:[NSString stringWithFormat:@"%@",name]
                                    fileName:fileName
                                    mimeType:@"image/jpeg"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
//            failure(error);
            failure(@"哎呀，服务器开小差了");
        }
    }];
}
+ (NSString *)requestUrlString:(NSString *)url{
    return [NSString stringWithFormat:@"%@%@",base_url,url];
}

@end
