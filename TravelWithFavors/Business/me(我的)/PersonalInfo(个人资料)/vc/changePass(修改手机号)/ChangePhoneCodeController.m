//
//  ChangePhoneCodeController.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/2.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "ChangePhoneCodeController.h"
#import "CaptchaInfo.h"
@interface ChangePhoneCodeController (){
    dispatch_source_t _timer;
}
@property (nonatomic, strong) HDSpaceTextField *phoneTextField;
@property (nonatomic, strong) HDSpaceTextField *codeTextField;
@property (nonatomic, strong) UIButton *codeBtn;
@property (nonatomic, strong) UIButton *commitBtn;
@end

@implementation ChangePhoneCodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"修改手机号";
    self.view.backgroundColor = [UIColor hdTableViewBackGoundColor];
    [self configView];
}
- (void)configView{
    self.phoneTextField.frame = CGRectMake(1, [AppConfig getNavigationBarHeight] + 10, SCREEN_WIDTH - 2, 50);
    [self.view addSubview:self.phoneTextField];
    
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 1 - 120, CGRectGetMaxY(self.phoneTextField.frame) + 1, 120, 50)];
    rightView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:rightView];
    
    self.codeBtn.frame = CGRectMake(10, 12.5, 100, 25);
    [rightView addSubview:self.codeBtn];
    
    self.codeTextField.frame = CGRectMake(1, rightView.frame.origin.y, CGRectGetMinX(rightView.frame) - 1, rightView.frame.size.height);
    [self.view addSubview:self.codeTextField];
    
    self.commitBtn.frame = CGRectMake(10, CGRectGetMaxY(self.codeTextField.frame) + 80, SCREEN_WIDTH - 20, 40);
    [self.view addSubview:self.commitBtn];
}
#pragma mark --actionClick
- (BOOL)canCode{
    [[IQKeyboardManager sharedManager] resignFirstResponder];
    if (self.phoneTextField.text.length <= 0) {
        [HSToast hsShowBottomWithText:@"请输入手机号"];
//        [self.phoneTextField becomeFirstResponder];
        return NO;;
    }
    if (![NSString checkoutPhoneNum:self.phoneTextField.text]) {
        [HSToast hsShowBottomWithText:@"请输入正确的手机号"];
//        [self.phoneTextField becomeFirstResponder];
        return NO;
    }
    return YES;
}
- (void)codeClick{
    if ([self canCode]) {
        [self getNumBtnAction];
        NSString *url = [HttpNetRequestTool requestUrlString:@"/user/login/captcha"];
        NSDictionary *dict = @{@"username":self.phoneTextField.text};
        [HttpNetRequestTool netRequest:HttpNetRequestPost urlString:url paraments:dict success:^(id Json) {
            BaseModel *model = [BaseModel yy_modelWithJSON:Json];
            if (model.code == 1) {
//                CaptchaInfo *codeInfo = [CaptchaInfo yy_modelWithJSON:model.data];
//                self.codeTextField.text = codeInfo.code;
            }else{
                dispatch_source_cancel(_timer);
                [self.codeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [self.codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                self.codeBtn.userInteractionEnabled = YES;
            }
        } failure:^(NSString *error) {
            [HSToast hsShowBottomWithText:error];
            dispatch_source_cancel(_timer);
            [self.codeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
            self.codeBtn.userInteractionEnabled = YES;
        }];
    }
}
- (BOOL)canCommit{
    [[IQKeyboardManager sharedManager] resignFirstResponder];
    if (self.phoneTextField.text.length <= 0) {
        [HSToast hsShowBottomWithText:@"请输入手机号"];
//        [self.phoneTextField becomeFirstResponder];
        return NO;;
    }
    if (![NSString checkoutPhoneNum:self.phoneTextField.text]) {
        [HSToast hsShowBottomWithText:@"请输入正确的手机号"];
//        [self.phoneTextField becomeFirstResponder];
        return NO;
    }
    if (self.codeTextField.text.length <= 0) {
        [HSToast hsShowBottomWithText:@"请输入验证码"];
//        [self.codeTextField becomeFirstResponder];
        return NO;;
    }
    return YES;
}
- (void)commitClick{
    if ([self canCommit]) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSString *url = [HttpNetRequestTool requestUrlString:@"/user/modify/index"];
        NSDictionary *dict = @{@"field":@"mobile",@"captcha":self.codeTextField.text,@"username":self.phoneTextField.text};
        [HttpNetRequestTool netRequestWithHeader:HttpNetRequestPost urlString:url paraments:dict success:^(id Json) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            BaseModel *model = [BaseModel yy_modelWithJSON:Json];
            if (model.code == 1) {
                [HSToast hsShowBottomWithText:@"修改成功"];
                [AppConfig setUserName:self.phoneTextField.text];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshUserInfo" object:nil];
                NSArray *lists = self.navigationController.viewControllers;
                UIViewController *vc = lists[lists.count - 3];
                [self.navigationController popToViewController:vc animated:YES];
            }else{
                [HSToast hsShowBottomWithText:model.msg];
            }
        } failure:^(NSString *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [HSToast hsShowBottomWithText:error];
        }];
    }
}
#pragma mark---验证码
- (void)getNumBtnAction{
    __block NSInteger second = 60;
    //全局队列    默认优先级
    dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //定时器模式  事件源
    if (!_timer) {
         _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, quene);
    }
   
    //NSEC_PER_SEC是秒，＊1是每秒
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), NSEC_PER_SEC * 1, 0);
    //设置响应dispatch源事件的block，在dispatch源指定的队列上运行
    __block typeof(self) weakSelf = self;
    dispatch_source_set_event_handler(_timer, ^{
        //回调主线程，在主线程中操作UI
        dispatch_async(dispatch_get_main_queue(), ^{
            if (second >= 0) {
                NSString *title = [NSString stringWithFormat:@"(%d)重新获取",(int)second];
                [weakSelf.codeBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                [weakSelf.codeBtn setTitle:title forState:UIControlStateNormal];
                weakSelf.codeBtn.userInteractionEnabled = NO;
                second--;
            }
            else
            {
                //这句话必须写否则会出问题
                dispatch_source_cancel(_timer);
                _timer = nil;
                //                weakSelf.achaveBtn.backgroundColor = [UIColor colorWithHexString:@"#FAEC5F"];
                [weakSelf.codeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [weakSelf.codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                weakSelf.codeBtn.userInteractionEnabled = YES;
            }
        });
    });
    //启动源
    dispatch_resume(_timer);
}
#pragma mark --load--
- (MyTextField *)phoneTextField{
    if (!_phoneTextField) {
        _phoneTextField = [[HDSpaceTextField alloc] init];
        UIView *left = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 50)];
        _phoneTextField.leftView = left;
        _phoneTextField.leftViewMode = UITextFieldViewModeAlways;
        UIView *right = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 50)];
        _phoneTextField.rightView = right;
        _phoneTextField.rightViewMode = UITextFieldViewModeAlways;
        _phoneTextField.borderStyle = UITextBorderStyleNone;
        _phoneTextField.placeholder = @"请输入新手机号码";
        _phoneTextField.placeholderFont = [UIFont systemFontOfSize:14.0f];
        _phoneTextField.placeholderColor = [UIColor colorWithHexString:@"#999999"];
        _phoneTextField.font = [UIFont systemFontOfSize:17.0f];
        _phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _phoneTextField.backgroundColor = [UIColor whiteColor];
        _phoneTextField.keyboardType = UIKeyboardTypePhonePad;
        _phoneTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;//水平
    }
    return _phoneTextField;
}
- (MyTextField *)codeTextField{
    if (!_codeTextField) {
        _codeTextField = [[HDSpaceTextField alloc] init];
        UIView *left = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 50)];
        _codeTextField.leftView = left;
        _codeTextField.leftViewMode = UITextFieldViewModeAlways;
        UIView *right = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 50)];
        _codeTextField.rightView = right;
        _codeTextField.rightViewMode = UITextFieldViewModeAlways;
        _codeTextField.borderStyle = UITextBorderStyleNone;
        _codeTextField.placeholder = @"请输入验证码";
        _codeTextField.placeholderFont = [UIFont systemFontOfSize:14.0f];
        _codeTextField.placeholderColor = [UIColor colorWithHexString:@"#999999"];
        _codeTextField.font = [UIFont systemFontOfSize:17.0f];
        _codeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _codeTextField.backgroundColor = [UIColor whiteColor];
        _codeTextField.keyboardType = UIKeyboardTypeNumberPad;
        _codeTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;//水平
    }
    return _codeTextField;
}
- (UIButton *)codeBtn{
    if (!_codeBtn) {
        _codeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _codeBtn.layer.cornerRadius = 2;
        _codeBtn.backgroundColor = [UIColor hdMainColor];
        [_codeBtn setTitle:@"发送到手机" forState:UIControlStateNormal];
        _codeBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [_codeBtn addTarget:self action:@selector(codeClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _codeBtn;
}
- (UIButton *)commitBtn{
    if (!_commitBtn) {
        _commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _commitBtn.layer.cornerRadius = 3;
        _commitBtn.backgroundColor = [UIColor hdMainColor];
        [_commitBtn setTitle:@"确定" forState:UIControlStateNormal];
        _commitBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
        [_commitBtn addTarget:self action:@selector(commitClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commitBtn;
}
#pragma mark --other--
//退出的时候
- (void)didMoveToParentViewController:(UIViewController *)parent{
    [super didMoveToParentViewController:parent];
    if(!parent){
        if (_timer) {
            //这句话必须写否则会出问题
            dispatch_source_cancel(_timer);
        }
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
