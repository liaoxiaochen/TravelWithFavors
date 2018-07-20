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
@property (nonatomic, strong) UIButton *shareBtn;
@property (nonatomic, strong) UILabel *phoneLabel;
@end

@implementation AboutUsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"关于我们";
    self.view.backgroundColor = [UIColor hdMainColor];
    [self configView];
}
- (void)configView{
    self.shareBtn.frame = CGRectMake(10, SCREENH_HEIGHT/2 - 40, SCREEN_WIDTH - 20, 40);
    [self.view addSubview:self.shareBtn];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMinY(self.shareBtn.frame) - 11, SCREEN_WIDTH - 20, 1)];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#4E587A"];
    [self.view addSubview:lineView];
    
    self.phoneLabel.frame = CGRectMake(0, 0, 10, 34);
    [self.phoneLabel sizeToFit];
    self.phoneLabel.frame = CGRectMake(SCREEN_WIDTH - self.phoneLabel.frame.size.width - 10, CGRectGetMinY(lineView.frame) - 34, self.phoneLabel.frame.size.width, 34);
    [self.view addSubview:self.phoneLabel];
    
    UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.phoneLabel.frame.origin.y, SCREEN_WIDTH/2 - 10, self.phoneLabel.frame.size.height)];
    leftLabel.text = @"联系我们";
    leftLabel.textColor = [UIColor whiteColor];
    leftLabel.font = [UIFont systemFontOfSize:14.0f];
    leftLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:leftLabel];
    
    CGFloat h = CGRectGetMinY(self.shareBtn.frame);
    UIImageView *logoView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 75)/2, (h - 75)/2, 75, 75)];
    logoView.layer.cornerRadius = 13.0f;
    logoView.layer.masksToBounds = YES;
    logoView.backgroundColor = [UIColor colorWithHexString:@"#6477B8"];
    logoView.image = [UIImage imageNamed:@"ic_logo"];
    [self.view addSubview:logoView];
    
}
#pragma mark --action
- (void)shareBtnClick{
    ShareCustomView *view = [[ShareCustomView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT)];
    view.delegate = self;
    [view showShareCustomView];
}
- (void)phoneClick{
    NSString * phoneNumber = self.phoneLabel.text;
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
        messageObject.text = @"携宠旅行 你和世界只隔着一张机票 https://itunes.apple.com/cn/app/id1407665400";
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
        shareObject.webpageUrl =@"https://itunes.apple.com/cn/app/id1407665400";
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
#pragma mark --load--
- (UIButton *)shareBtn{
    if (!_shareBtn) {
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _shareBtn.backgroundColor = [UIColor colorWithHexString:@"#4E587A"];
        _shareBtn.layer.cornerRadius = 3;
        [_shareBtn setTitle:@"分享" forState:UIControlStateNormal];
        _shareBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [_shareBtn addTarget:self action:@selector(shareBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareBtn;
}
- (UILabel *)phoneLabel{
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc] init];
        _phoneLabel.text = @"028-028-028";
        _phoneLabel.textColor = [UIColor whiteColor];
        _phoneLabel.font = [UIFont systemFontOfSize:14.0f];
        _phoneLabel.textAlignment = NSTextAlignmentRight;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(phoneClick)];
        _phoneLabel.userInteractionEnabled = YES;
        [_phoneLabel addGestureRecognizer:tap];
    }
    return _phoneLabel;
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
