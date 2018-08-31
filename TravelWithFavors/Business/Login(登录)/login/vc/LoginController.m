//
//  LoginController.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/8.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "LoginController.h"
#import "RegistController.h"
#import "ForgetLoginPassWordController.h"
#import "LoginInfo.h"
#import "JPUSHService.h"
#import <UMShare/UMShare.h>

@interface LoginController ()
@property (nonatomic, strong) MyTextField *passTextField;
@property (nonatomic, strong) MyTextField *phoneTextField;
@property (nonatomic, strong) UIImageView *catImg;
@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //    self.navigationItem.title = @"登录";
    [self configView];
    [self setupUI];
     // 添加监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewEditChanged:) name:UITextFieldTextDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewEndEditing:) name:UITextFieldTextDidEndEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewBeginEditing:) name:UITextFieldTextDidBeginEditingNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(login) name:@"login" object:nil];
}

#pragma mark - 登录方法
//注册成功 登录
- (void)login{
    self.phoneTextField.text = [AppConfig getUserName];
    self.passTextField.text = [AppConfig getPassWord];
    [self loginBtnClick];
}

- (BOOL)isCanLogin{
    [[IQKeyboardManager sharedManager] resignFirstResponder];
    if (self.phoneTextField.text.length <= 0) {
        [HSToast hsShowBottomWithText:@"请输入手机号"];
        //[self.phoneTextField becomeFirstResponder];
        return NO;
    }
    if (self.passTextField.text.length <= 0) {
        [HSToast hsShowBottomWithText:@"请输入密码"];
        //[self.passTextField becomeFirstResponder];
        return NO;
    }
    if (![NSString checkoutPhoneNum:self.phoneTextField.text]) {
        [HSToast hsShowBottomWithText:@"请输入正确的手机号"];
        //[self.phoneTextField becomeFirstResponder];
        return NO;
    }
    return YES;
}
- (void)loginBtnClick{
    if ([self isCanLogin]) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSString *url = [HttpNetRequestTool requestUrlString:@"/user/login/index"];
        NSDictionary *dict = @{@"username":self.phoneTextField.text,@"password":self.passTextField.text};
        [HttpNetRequestTool netRequest:HttpNetRequestPost urlString:url paraments:dict success:^(id Json) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            BaseModel *model = [BaseModel yy_modelWithJSON:Json];
            if (model.code == 1) {
                LoginInfo *info = [LoginInfo yy_modelWithJSON:model.data];
                [AppConfig setLoginState:YES];
                [AppConfig setUserName:self.phoneTextField.text];
                [AppConfig setPassWord:self.passTextField.text];
                [AppConfig setLoginToken:info.login_token];
                [AppConfig setLoginID:info.uid];
                [JPUSHService setTags:[NSSet setWithObject:@"loginSeccess"] completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
                    HRLog(@"iResCode==%ld:标签：%@ 会话序列号：%ld",iResCode,iTags,seq);
                } seq:0];
                if (self.LoginSuccess) {
                    self.LoginSuccess();
                }
                [self.navigationController dismissViewControllerAnimated:YES completion:^{
                    //登录成功
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"loginSeccess" object:nil];
                }];
                [HSToast hsShowBottomWithText:@"登录成功"];
            }else{
                [HSToast hsShowBottomWithText:model.msg];
            }
        } failure:^(NSString *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }];
    }
}
#pragma mark --UITextFieldDelegate
/**
 *  当 text field 文本内容改变时 会调用此方法
 */
-(void)textViewEditChanged:(NSNotification *)notification{
    // 拿到文本改变的 text field
    UITextField *textField = (UITextField *)notification.object;
    if (textField == self.phoneTextField) {
        
        // 需要限制的长度
        NSUInteger maxLength = 11;
        // text field 的内容
        NSString *contentText = textField.text;
        
        // 获取高亮内容的范围
        UITextRange *selectedRange = [textField markedTextRange];
        // 这行代码 可以认为是 获取高亮内容的长度
        NSInteger markedTextLength = [textField offsetFromPosition:selectedRange.start toPosition:selectedRange.end];
        // 没有高亮内容时,对已输入的文字进行操作
        if (markedTextLength == 0) {
            // 如果 text field 的内容长度大于我们限制的内容长度
            if (contentText.length > maxLength) {
                // 截取从前面开始maxLength长度的字符串
                //            textField.text = [contentText substringToIndex:maxLength];
                // 此方法用于在字符串的一个range范围内，返回此range范围内完整的字符串的range
                NSRange rangeRange = [contentText rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, maxLength)];
                textField.text = [contentText substringWithRange:rangeRange];
            }
        }
    }
    //密码
    if (textField == self.passTextField) {
        
        // 需要限制的长度
        NSUInteger maxLength = 16;
        // text field 的内容
        NSString *contentText = textField.text;
        
        // 获取高亮内容的范围
        UITextRange *selectedRange = [textField markedTextRange];
        // 这行代码 可以认为是 获取高亮内容的长度
        NSInteger markedTextLength = [textField offsetFromPosition:selectedRange.start toPosition:selectedRange.end];
        // 没有高亮内容时,对已输入的文字进行操作
        if (markedTextLength == 0) {
            // 如果 text field 的内容长度大于我们限制的内容长度
            if (contentText.length > maxLength) {
                // 截取从前面开始maxLength长度的字符串
                //            textField.text = [contentText substringToIndex:maxLength];
                // 此方法用于在字符串的一个range范围内，返回此range范围内完整的字符串的range
                NSRange rangeRange = [contentText rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, maxLength)];
                textField.text = [contentText substringWithRange:rangeRange];
            }
        }
    }
}

- (void)textViewEndEditing:(NSNotification *)notification {
    
    _catImg.image = [UIImage imageNamed:@"lind_cat_head"];
}

- (void)textViewBeginEditing:(NSNotification *)notification {
    UITextField *textField = (UITextField *)notification.object;
    if (textField == self.passTextField) {
        _catImg.image = [UIImage imageNamed:@"lind_cat"];
    }
}

#pragma mark - 页面跳转
- (void)registBtnClick{
    RegistController *vc = [[RegistController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)forgetBtnClick{
    ForgetLoginPassWordController *vc = [[ForgetLoginPassWordController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)backToLast{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
 
    
}

#pragma mark - 三方登录
- (void)qqLogin {
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_QQ currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
        } else {
            UMSocialUserInfoResponse *resp = result;
            // 授权信息
            NSLog(@"QQ uid: %@", resp.uid);
            NSLog(@"QQ openid: %@", resp.openid);
            NSLog(@"QQ unionid: %@", resp.unionId);
            NSLog(@"QQ accessToken: %@", resp.accessToken);
            NSLog(@"QQ expiration: %@", resp.expiration);
            // 用户信息
            NSLog(@"QQ name: %@", resp.name);
            NSLog(@"QQ iconurl: %@", resp.iconurl);
            NSLog(@"QQ gender: %@", resp.unionGender);
            // 第三方平台SDK源数据
            NSLog(@"QQ originalResponse: %@", resp.originalResponse);
        }
    }];
}

- (void)wechatLogin {
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
        } else {
            UMSocialUserInfoResponse *resp = result;
            // 授权信息
            NSLog(@"Wechat uid: %@", resp.uid);
            NSLog(@"Wechat openid: %@", resp.openid);
            NSLog(@"Wechat unionid: %@", resp.unionId);
            NSLog(@"Wechat accessToken: %@", resp.accessToken);
            NSLog(@"Wechat refreshToken: %@", resp.refreshToken);
            NSLog(@"Wechat expiration: %@", resp.expiration);
            // 用户信息
            NSLog(@"Wechat name: %@", resp.name);
            NSLog(@"Wechat iconurl: %@", resp.iconurl);
            NSLog(@"Wechat gender: %@", resp.unionGender);
            // 第三方平台SDK源数据
            NSLog(@"Wechat originalResponse: %@", resp.originalResponse);
        }
    }];
}

- (void)aliLogin {
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_Sina currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
        } else {
            UMSocialUserInfoResponse *resp = result;
            // 授权信息
            NSLog(@"Sina uid: %@", resp.uid);
            NSLog(@"Sina accessToken: %@", resp.accessToken);
            NSLog(@"Sina refreshToken: %@", resp.refreshToken);
            NSLog(@"Sina expiration: %@", resp.expiration);
            // 用户信息
            NSLog(@"Sina name: %@", resp.name);
            NSLog(@"Sina iconurl: %@", resp.iconurl);
            NSLog(@"Sina gender: %@", resp.unionGender);
            // 第三方平台SDK源数据
            NSLog(@"Sina originalResponse: %@", resp.originalResponse);
        }
    }];
}

#pragma mark - UI绘制
- (void)setupUI {
    
    [self.view addSubview:self.catImg];
    
    UIButton *qqBtn = [self setupButton:@"lind_qq" buttonFrame:CGRectMake((SCREEN_WIDTH - 35) / 2, SCREENH_HEIGHT - 65, 35, 35)];
    [qqBtn addTarget:self action:@selector(qqLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:qqBtn];
    
    UIButton *wechatBtn = [self setupButton:@"lind_wechat" buttonFrame:CGRectMake(CGRectGetMinX(qqBtn.frame) - 45, SCREENH_HEIGHT - 65, 35, 35)];
    [wechatBtn addTarget:self action:@selector(wechatLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:wechatBtn];
    
    UIButton *aliBtn = [self setupButton:@"lind_sina" buttonFrame:CGRectMake(CGRectGetMaxX(qqBtn.frame) + 10, SCREENH_HEIGHT - 65, 35, 35)];
    [aliBtn addTarget:self action:@selector(aliLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:aliBtn];
    
    
}

- (UIButton *)setupButton:(NSString *)imageName buttonFrame:(CGRect)rect {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    button.frame = rect;
    
    return button;
}

- (void)configView{
    
    
    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = [UIColor whiteColor];
    backView.userInteractionEnabled = YES;
    [self.view addSubview:backView];
    backView.frame = CGRectMake(50, 0, SCREEN_WIDTH - 100, 177);
    backView.center = self.view.center;
    CGFloat backWidth = CGRectGetWidth(backView.frame);
    
    //手机号
    self.phoneTextField.frame = CGRectMake(0, 0,backWidth, 29);
    [backView addSubview:self.phoneTextField];
    UIView *phoneline = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.phoneTextField.frame), backWidth, 1)];
    phoneline.backgroundColor = [UIColor colorWithHexString:@"#999999"];
    [backView addSubview:phoneline];
    
    //密码
    self.passTextField.frame = CGRectMake(0, CGRectGetMaxY(self.phoneTextField.frame) + 25, backWidth, 29);
    [backView addSubview:self.passTextField];
    UIView *passline = [[UIView alloc] initWithFrame:CGRectMake(0, 84, backWidth, 1)];
    passline.backgroundColor = [UIColor colorWithHexString:@"#999999"];
    [backView addSubview:passline];
    
    //登录
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.adjustsImageWhenHighlighted = NO;
    loginBtn.frame = CGRectMake(0, CGRectGetMaxY(self.passTextField.frame) + 20, backWidth, 40);
    loginBtn.backgroundColor = [UIColor hdMainColor];
    loginBtn.layer.cornerRadius = 10;
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:loginBtn];
    
    //注册
    UIButton *registBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registBtn.adjustsImageWhenHighlighted = NO;
    //    registBtn.frame = CGRectMake(36, forgetBtn.frame.origin.y, 30, forgetBtn.frame.size.height);
    registBtn.frame = CGRectMake(0, CGRectGetMaxY(loginBtn.frame) + 2, 30, 30);
    
    [registBtn setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
    [registBtn setTitle:@"注册" forState:UIControlStateNormal];
    registBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [registBtn addTarget:self action:@selector(registBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:registBtn];
    
    //忘记密码
    UIButton * forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    forgetBtn.frame = CGRectMake(SCREEN_WIDTH - 66 - 36, SCREENH_HEIGHT/2, 66, 30);
    forgetBtn.frame = CGRectMake(backWidth - 66,  CGRectGetMaxY(loginBtn.frame) + 2, 66, 30);
    forgetBtn.adjustsImageWhenHighlighted = NO;
    [forgetBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [forgetBtn setTitleColor:[UIColor colorWithHexString:@"#4790F9"] forState:UIControlStateNormal];
    forgetBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [forgetBtn addTarget:self action:@selector(forgetBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:forgetBtn];
    
}


- (MyTextField *)phoneTextField{
    if (!_phoneTextField) {
        _phoneTextField = [[MyTextField alloc] init];
        _phoneTextField.placeholder = @"请输入你的手机号";
        _phoneTextField.placeholderFont = [UIFont systemFontOfSize:14.0f];
        _phoneTextField.placeholderColor = [UIColor colorWithHexString:@"#999999"];
        _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
        _phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _phoneTextField;
}
- (MyTextField *)passTextField{
    if (!_passTextField) {
        _passTextField = [[MyTextField alloc] init];
        _passTextField.placeholder = @"请输入密码";
        _passTextField.placeholderFont = [UIFont systemFontOfSize:14.0f];
        _passTextField.placeholderColor = [UIColor colorWithHexString:@"#999999"];
        _passTextField.secureTextEntry = YES;
        _passTextField.keyboardType = UIKeyboardTypeASCIICapable;
        _passTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _passTextField;
}
- (UIImageView *)catImg {
    
    if (!_catImg) {
        _catImg = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 157)/2, 100, 157, 103)];
        _catImg.image = [UIImage imageNamed:@"lind_cat_head"];
    }
    
    return _catImg;
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
