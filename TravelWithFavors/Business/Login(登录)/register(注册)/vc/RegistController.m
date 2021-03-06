//
//  RegistController.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/8.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "RegistController.h"
#import "UserProtocolViewController.h"
#import "CaptchaInfo.h"//验证码
@interface RegistController (){
    dispatch_source_t _timer;
}
@property (weak, nonatomic) IBOutlet UIButton *choseBtn;
@property (weak, nonatomic) IBOutlet UIButton *registBtn;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
@property (weak, nonatomic) IBOutlet MyTextField *passTextField;
@property (weak, nonatomic) IBOutlet MyTextField *codeTexrField;

@property (weak, nonatomic) IBOutlet MyTextField *phoneTextField;
@property (nonatomic, strong) CaptchaInfo *codeInfo;
@property (nonatomic, assign) BOOL isAllow;
@end

@implementation RegistController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"注册";
    [self configView];
    // 添加监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewEditChanged:) name:UITextFieldTextDidChangeNotification object:nil];
}
- (void)configView{
    self.isAllow = YES;
    self.registBtn.layer.cornerRadius = 10;
    self.phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.passTextField.secureTextEntry = YES;
    self.codeBtn.layer.cornerRadius = 5;
    self.passTextField.keyboardType = UIKeyboardTypeASCIICapable;
}
- (IBAction)choseBtnClick:(id)sender {
    self.isAllow = !self.isAllow;
    if (self.isAllow) {
        [self.choseBtn setImage:[UIImage imageNamed:@"ic_yyd"] forState:UIControlStateNormal];
    }else{
        [self.choseBtn setImage:[UIImage imageNamed:@"wdcw_jxk"] forState:UIControlStateNormal];
    }
}

- (IBAction)protocolClick:(id)sender {
    UserProtocolViewController *vc = [[UserProtocolViewController alloc] init];
    vc.urlString = @"http://www.baidu.com";
    [self.navigationController pushViewController:vc animated:YES];
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *url = [HttpNetRequestTool requestUrlString:@"/user/index/text"];
    NSDictionary *dic = @{@"type":@"3"};
    [HttpNetRequestTool netRequest:HttpNetRequestPost urlString:url paraments:dic success:^(id Json) {
        HRLog(@"%@",Json)
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        BaseModel *model = [BaseModel yy_modelWithJSON:Json];
        if (model.code == 1) {
            UserProtocolViewController *vc = [[UserProtocolViewController alloc] init];
            vc.htmlStirng = model.data?:@"";
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            [HSToast hsShowBottomWithText:model.msg];
        }
    } failure:^(NSString *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [HSToast hsShowBottomWithText:error];
    }];
}
- (BOOL)canCommit{
    if (self.phoneTextField.text.length <= 0) {
        [HSToast hsShowTopWithText:@"请输入您的手机号码"];
        [self.phoneTextField becomeFirstResponder];
        return NO;
    }
    if (![NSString checkoutPhoneNum:self.phoneTextField.text]) {
        [HSToast hsShowTopWithText:@"请输入正确的手机号"];
        [self.phoneTextField becomeFirstResponder];
        return NO;
    }
    if (self.passTextField.text.length <= 0) {
        [HSToast hsShowTopWithText:@"请输入您的密码"];
        [self.passTextField becomeFirstResponder];
        return NO;
    }
    if (self.passTextField.text.length < 6) {
        [HSToast hsShowTopWithText:@"密码至少6位"];
        return NO;
    }
    if (self.codeTexrField.text.length <= 0) {
        [HSToast hsShowTopWithText:@"请输入验证码"];
        [self.codeTexrField becomeFirstResponder];
        return NO;;
    }
    [[IQKeyboardManager sharedManager] resignFirstResponder];
    if (!self.isAllow) {
        [HSToast hsShowBottomWithText:@"还未同意用户协议"];
        return NO;
    }
    return YES;
}
- (IBAction)registBtnClick:(id)sender {
    if ([self canCommit]) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSString *url = [HttpNetRequestTool requestUrlString:@"/user/login/register"];
        NSDictionary *dic = @{@"username":self.phoneTextField.text,@"password":self.passTextField.text,@"captcha":self.codeTexrField.text};
        [HttpNetRequestTool netRequest:HttpNetRequestPost urlString:url paraments:dic success:^(id Json) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            BaseModel *model = [BaseModel yy_modelWithJSON:Json];
            if (model.code == 1) {
                [AppConfig setUserName:self.phoneTextField.text];
                [AppConfig setPassWord:self.passTextField.text];
                debugLog(@"注册成功");
                [[NSNotificationCenter defaultCenter] postNotificationName:@"login" object:nil];
                [self.navigationController popViewControllerAnimated:YES];
                //登录
            }else{
                [HSToast hsShowBottomWithText:model.msg];
            }
        } failure:^(NSString *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [HSToast hsShowBottomWithText:error];
        }];
    }
}
- (BOOL)canCode{
    if (self.phoneTextField.text.length <= 0) {
        [HSToast hsShowBottomWithText:@"请输入手机号"];
        [self.phoneTextField becomeFirstResponder];
        return NO;
    }
    if (![NSString checkoutPhoneNum:self.phoneTextField.text]) {
        [HSToast hsShowBottomWithText:@"请输入正确的手机号"];
        [self.phoneTextField becomeFirstResponder];
        return NO;
    }
    return YES;
}
- (IBAction)codeBtnClick:(id)sender {
    if ([self canCode]) {
        [self getNumBtnAction];
        NSString *url = [HttpNetRequestTool requestUrlString:@"/user/login/captcha"];
        NSDictionary *dict = @{@"username":self.phoneTextField.text};
        [HttpNetRequestTool netRequest:HttpNetRequestPost urlString:url paraments:dict success:^(id Json) {
            BaseModel *model = [BaseModel yy_modelWithJSON:Json];
            if (model.code == 1) {
//                self.codeInfo = [CaptchaInfo yy_modelWithJSON:model.data];
//                self.codeTexrField.text = self.codeInfo.code;
            }else{
//                dispatch_source_cancel(_timer);
//                [self.codeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//                [self.codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
//                self.codeBtn.userInteractionEnabled = YES;
            }
        } failure:^(NSString *error) {
//            [HSToast hsShowBottomWithText:error];
//            dispatch_source_cancel(_timer);
//            [self.codeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//            [self.codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
//            self.codeBtn.userInteractionEnabled = YES;
        }];
    }
    
}
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
    //验证码
    if (textField == self.codeTexrField) {
        // 需要限制的长度
        NSUInteger maxLength = 6;
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
