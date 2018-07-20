//
//  ServiceMainController.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/2.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "ServiceMainController.h"
#import "LoginController.h"
#import "TestView.h"
#import "LoginNavigationController.h"
@interface ServiceMainController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;
@end

@implementation ServiceMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"服务";
    self.view.userInteractionEnabled = YES;
    [self cleanCacheAndCookie];
    self.webView.delegate = self;
    
//    self.webView.scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getData)];
//    [self.webView.scrollView.mj_header beginRefreshing];

//    TestView *view = [[TestView alloc] initWithFrame:CGRectMake(0, [AppConfig getNavigationBarHeight], SCREEN_WIDTH, SCREENH_HEIGHT - [AppConfig getNavigationBarHeight] - [AppConfig getTabBarHeight])];
//    [self.view addSubview:view];
}

- (void)getData{
    //NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@""] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];realase
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]];
    request.HTTPMethod = @"GET";
    request.timeoutInterval = 30;
    NSString *body = [NSString stringWithFormat:@"token=%@",@""];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    [self.webView loadRequest:request];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (![AppConfig getLoginState]) {
        LoginController *vc = [[LoginController alloc] init];
        LoginNavigationController *nav = [[LoginNavigationController alloc] initWithRootViewController:vc];
        [self.navigationController presentViewController:nav animated:YES completion:nil];
    }
}
-(void)webViewDidStartLoad:(UIWebView *)webView{
    HRLog(@"2====%@",webView.request.URL)
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.webView.scrollView.mj_header endRefreshing];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    HRLog(@"1====%@",webView.request.URL)
    //self.closeBtn.hidden = !self.webView.canGoBack;
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [self.webView.scrollView.mj_header endRefreshing];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if (error.code == -1001) {
        [HSToast hsShowCenterWithText:@"网络连接超时"];
    }else if (error.code == -1009){
        [HSToast hsShowCenterWithText:@"网络未连接，请检查网络"];
    }else if (error.code == -999){
    }else {
        [HSToast hsShowCenterWithText:@"网络连接错误"];
    }
}

//-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
//    return UIInterfaceOrientationMaskLandscapeRight;
//}
//-(BOOL)shouldAutorotate{
//    return NO;
//}
//-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
//    return UIInterfaceOrientationLandscapeRight;
//}
- (IBAction)goBackBtnClick:(UIButton *)sender {
    if (self.webView.canGoBack) {
        [self.webView goBack];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
- (IBAction)closeBtnClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)cleanCacheAndCookie{
    //清除cookies
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies]){
        [storage deleteCookie:cookie];
    }
    //清除UIWebView的缓存
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    NSURLCache * cache = [NSURLCache sharedURLCache];
    [cache removeAllCachedResponses];
    [cache setDiskCapacity:0];
    [cache setMemoryCapacity:0];
}

@end
