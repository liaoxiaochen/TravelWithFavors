//
//  PetNickNameController.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/8.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "PetNickNameController.h"

@interface PetNickNameController ()
@property (nonatomic, strong) MyTextField *nickTextField;
@property (nonatomic, strong) UIButton *commitBtn;
@end

@implementation PetNickNameController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"宠物名字";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.nickTextField];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.nickTextField.frame), SCREEN_WIDTH - 20, 1)];
    line.backgroundColor = [UIColor colorWithHexString:@"#DDDDDD"];
    [self.view addSubview:line];
    self.commitBtn.frame = CGRectMake(10, CGRectGetMaxY(line.frame) + 28, SCREEN_WIDTH - 20, 40);
    [self.view addSubview:self.commitBtn];
    
    self.nickTextField.text = self.nickName;
}
- (void)saveClick{
    [[IQKeyboardManager sharedManager] resignFirstResponder];
    if (self.nickTextField.text.length > 0) {
        if (self.nickBlock) {
            self.nickBlock(self.nickTextField.text);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [HSToast hsShowBottomWithText:@"请输入宠物昵称"];
    }
}
#pragma mark --laod--
- (MyTextField *)nickTextField{
    if (!_nickTextField) {
        _nickTextField = [[MyTextField alloc] initWithFrame:CGRectMake(20, [AppConfig getNavigationBarHeight] + 20, SCREEN_WIDTH - 40, 30)];
//        UIView *left = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 50)];
//        _nickTextField.leftView = left;
//        _nickTextField.leftViewMode = UITextFieldViewModeAlways;
//        UIView *right = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 50)];
//        _nickTextField.rightView = right;
//        _nickTextField.rightViewMode = UITextFieldViewModeAlways;
        _nickTextField.borderStyle = UITextBorderStyleNone;
        _nickTextField.placeholder = @"输入宠物名称";
        _nickTextField.placeholderFont = [UIFont systemFontOfSize:14.0f];
        _nickTextField.placeholderColor = [UIColor colorWithHexString:@"#999999"];
        _nickTextField.font = [UIFont systemFontOfSize:14.0f];
        _nickTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
//        _nickTextField.backgroundColor = [UIColor whiteColor];
        _nickTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;//水平
    }
    return _nickTextField;
}
- (UIButton *)commitBtn{
    if (!_commitBtn) {
        _commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _commitBtn.layer.cornerRadius = 3;
        _commitBtn.backgroundColor = [UIColor hdMainColor];
        [_commitBtn setTitle:@"保存" forState:UIControlStateNormal];
        _commitBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
        [_commitBtn addTarget:self action:@selector(saveClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commitBtn;
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
