//
//  ZSWebViewController.h
//  ZhiShang
//
//  Created by mac on 2018/4/20.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RootViewController.h"
#import <WebKit/WebKit.h>
@interface ZSWebViewController : RootViewController

@property (nonatomic, copy) NSString  *htmlStirng;

@property (nonatomic, copy) NSString  *urlString;

@property (nonatomic, strong) WKWebView   *webView;
@end
