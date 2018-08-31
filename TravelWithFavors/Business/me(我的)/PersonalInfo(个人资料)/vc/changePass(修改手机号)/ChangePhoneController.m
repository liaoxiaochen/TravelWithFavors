//
//  ChangePhoneController.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/2.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "ChangePhoneController.h"
#import "ChangePhoneCodeController.h"
@interface ChangePhoneController ()
@property (nonatomic, strong) HDSpaceTextField *passTextField;
@property (nonatomic, strong) UIButton *nextBtn;
@end

@implementation ChangePhoneController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"修改手机号";
    self.view.backgroundColor = [UIColor hdTableViewBackGoundColor];
    [self configView];
}
- (void)configView{
    UILabel *top = [[UILabel alloc] initWithFrame:CGRectMake(10, [AppConfig getNavigationBarHeight], SCREEN_WIDTH - 20, 20)];
    top.text = @"为了确认是您本人的操作，需要输入密码才能修改手机号";
    top.textColor = [UIColor hdPlaceHolderColor];
    top.font = [UIFont systemFontOfSize:10.0f];
    [self.view addSubview:top];
    self.passTextField.frame = CGRectMake(1, CGRectGetMaxY(top.frame), SCREEN_WIDTH - 2, 40);
    [self.view addSubview:self.passTextField];
    self.nextBtn.frame = CGRectMake(10, CGRectGetMaxY(self.passTextField.frame) + 68, SCREEN_WIDTH - 20, 40);
    [self.view addSubview:self.nextBtn];
}
- (BOOL)canNext{
    if (self.passTextField.text.length <= 0) {
        [HSToast hsShowBottomWithText:@"请输入密码"];
        return NO;
    }
    if (![self.passTextField.text isEqualToString:[AppConfig getPassWord]]) {
        [HSToast hsShowBottomWithText:@"密码不正确"];
        return NO;
    }
    return YES;
}
- (void)nextClick{
    [self.passTextField resignFirstResponder];
    if ([self canNext]) {
        ChangePhoneCodeController *vc = [[ChangePhoneCodeController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
#pragma mark --laod--
- (MyTextField *)passTextField{
    if (!_passTextField) {
        _passTextField = [[HDSpaceTextField alloc] init];
        
        UIView *left = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
        _passTextField.leftView = left;
        _passTextField.leftViewMode = UITextFieldViewModeAlways;
        UIView *right = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
        _passTextField.rightView = right;
        _passTextField.rightViewMode = UITextFieldViewModeAlways;
        _passTextField.borderStyle = UITextBorderStyleNone;
        _passTextField.placeholder = @"请输入登录密码";
        _passTextField.placeholderFont = [UIFont systemFontOfSize:14.0f];
        _passTextField.secureTextEntry = YES;
        _passTextField.placeholderColor = [UIColor hdPlaceHolderColor];
        _passTextField.font = [UIFont systemFontOfSize:17.0f];
        _passTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _passTextField.backgroundColor = [UIColor whiteColor];
        _passTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;//水平
    }
    return _passTextField;
}
- (UIButton *)nextBtn{
    if (!_nextBtn) {
        _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextBtn.layer.cornerRadius = 20;
        _nextBtn.backgroundColor = [UIColor hdMainColor];
        [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
        _nextBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
        [_nextBtn addTarget:self action:@selector(nextClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextBtn;
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
