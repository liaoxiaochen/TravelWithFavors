//
//  AboutUsController.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/3.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "AboutUsController.h"
#import "ShareCustomView.h"
#import <UMShare/UMShare.h>
@interface AboutUsController ()<ShareCustomViewDelegate>
  @end

@implementation AboutUsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"关于我们";
    self.view.backgroundColor = [UIColor hdTableViewBackGoundColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"xc_fenx"] style:(UIBarButtonItemStylePlain) target:self action:@selector(shareBtnClick)];
    
    [self configView];
}
- (void)configView{

    UIImageView *logoView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 75 * 301 / 132)/2, 50 + [AppConfig getNavigationBarHeight], 75 * 301 / 132, 75)];
    logoView.image = [UIImage imageNamed:@"xc_xiecongbiao"];
    [self.view addSubview:logoView];
    
    UIButton *adviceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [adviceBtn setTitle:@"建议我们：nobadin@126.com" forState:(UIControlStateNormal)];
    adviceBtn.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);
    adviceBtn.centerY = self.view.centerY;
    adviceBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [adviceBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    adviceBtn.backgroundColor = [UIColor whiteColor];
//    [adviceBtn addTarget:self action:@selector(phoneClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:adviceBtn];
    
    UIButton *telePhoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [telePhoneBtn setTitle:@"客服电话：0411-88255708" forState:(UIControlStateNormal)];
    telePhoneBtn.frame = CGRectMake(0, CGRectGetMinY(adviceBtn.frame) - 51, SCREEN_WIDTH, 50);
    telePhoneBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [telePhoneBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    telePhoneBtn.backgroundColor = [UIColor whiteColor];
    [telePhoneBtn addTarget:self action:@selector(phoneClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:telePhoneBtn];
    
    UIButton *aboutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [aboutBtn setTitle:@"关于携宠" forState:(UIControlStateNormal)];
    aboutBtn.frame = CGRectMake(0, CGRectGetMaxY(adviceBtn.frame) + 1, SCREEN_WIDTH, 50);
    aboutBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [aboutBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    aboutBtn.backgroundColor = [UIColor whiteColor];
//    [aboutBtn addTarget:self action:@selector(phoneClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:aboutBtn];
    
    
    UILabel *companyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 60, SCREEN_WIDTH, 20)];
    companyLabel.text = @"大连牛八鼎科技有限公司";
    companyLabel.textAlignment = NSTextAlignmentCenter;
    companyLabel.font = [UIFont systemFontOfSize:14];
    companyLabel.textColor = [UIColor hdPlaceHolderColor];
    [self.view addSubview:companyLabel];
    
    UILabel *versionLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 40) / 2, self.view.frame.size.height - 35, 40, 15)];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    versionLabel.text = [NSString stringWithFormat:@"v%@", [infoDictionary objectForKey:@"CFBundleShortVersionString"]];
    versionLabel.textAlignment = NSTextAlignmentCenter;
    versionLabel.font = [UIFont systemFontOfSize:14];
    versionLabel.textColor = [UIColor hdMainColor];
    versionLabel.layer.borderColor = [UIColor hdMainColor].CGColor;
    versionLabel.layer.borderWidth = 1;
    versionLabel.layer.cornerRadius = 5;
    [self.view addSubview:versionLabel];
    
    
}
#pragma mark --action
- (void)shareBtnClick{
    ShareCustomView *view = [[ShareCustomView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT)];
    view.delegate = self;
    [view showShareCustomView];
}
- (void)phoneClick{
    NSString * phoneNumber = @"0411-88255708";
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",phoneNumber];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}
#pragma mark --ShareCustomViewDelegate分享
- (void)shareSelected:(NSInteger)index{
    switch (index) {
        case 0:
        {
            //微信
            [self share:UMSocialPlatformType_WechatSession];
        }
            break;
        case 1:{
            //朋友圈
            [self share:UMSocialPlatformType_WechatTimeLine];
        }
            break;
        case 2:{
            //QQ
            [self share:UMSocialPlatformType_QQ];
        }
            break;
        default:{
            //微博
            [self share:UMSocialPlatformType_Sina];
        }
            break;
    }
}
- (void)share:(UMSocialPlatformType)type{
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //设置文本
    if (type == UMSocialPlatformType_Sina) {//图文
        messageObject.text = @"携宠旅行 你和世界只隔着一张机票 https://itunes.apple.com/cn/app/id1422568361";
        //创建图片内容对象
        UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
        //如果有缩略图，则设置缩略图
        shareObject.thumbImage = [UIImage imageNamed:@"ic_logo"];
        //[shareObject setShareImage:@"https://www.umeng.com/img/index/demo/1104.4b2f7dfe614bea70eea4c6071c72d7f5.jpg"];
        [shareObject setShareImage:[UIImage imageNamed:@"ic_logo"]];
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;
    }else{//不支持图文，使用webpage
        //创建网页内容对象
        UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"携宠旅行 你和世界只隔着一张机票" descr:@"" thumImage:[UIImage imageNamed:@"ic_logo"]];
        //设置网页地址
        shareObject.webpageUrl =@"https://itunes.apple.com/cn/app/id1422568361";
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;
    }
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:type messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            HRLog(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                HRLog(@"response message is %@",resp.message);
                //第三方原始返回的数据
                HRLog(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                HRLog(@"response data is %@",data);
            }
        }
    }];
    
    
    
    NSArray* imageArray = @[[UIImage imageNamed:@"ic_logo"]];
    //（注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    if (imageArray) {
//        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
//        [shareParams SSDKSetupShareParamsByText:@"携宠旅行" images:imageArray url:[NSURL URLWithString:@"http://www.mob.com/images/logo_black.png"] title:@"携宠旅行" type:SSDKContentTypeText];
//        [shareParams setObject:[UIImage imageNamed:@"wode_tx"] forKey:@"img"];
//        [shareParams SSDKEnableUseClientShare];
//        [ShareSDK share:type parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
//            switch (state) {
//                case SSDKResponseStateSuccess:
//                {
//                    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"分享成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
//                    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
//                    [alertVC addAction:ok];
//                    [self presentViewController:alertVC  animated:YES completion:nil];
//                    break;
//                }
//                case SSDKResponseStateFail:
//                {
//                    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"分享成功" message:[NSString stringWithFormat:@"%@",error] preferredStyle:UIAlertControllerStyleAlert];
//                    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
//                    [alertVC addAction:ok];
//                    [self presentViewController:alertVC  animated:YES completion:nil];
//                    break;
//                }
//                case SSDKResponseStateCancel:{
//                    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"分享已取消" message:[NSString stringWithFormat:@"%@",error] preferredStyle:UIAlertControllerStyleAlert];
//                    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
//                    [alertVC addAction:ok];
//                    [self presentViewController:alertVC  animated:YES completion:nil];
//                    break;
//                }
//                default:
//                    break;
//            }
//        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
