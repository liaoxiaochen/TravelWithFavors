//
//  ChangeNickController.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/2.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "ChangeNickController.h"

@interface ChangeNickController ()
@property (nonatomic, strong) HDSpaceTextField *nickTextField;
@property (nonatomic, strong) UIButton *commitBtn;

@property (nonatomic, strong) UILabel *top;

@end

@implementation ChangeNickController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"编辑昵称";
    self.view.backgroundColor = [UIColor hdTableViewBackGoundColor];
    
    self.top = [[UILabel alloc] initWithFrame:CGRectMake(10, [AppConfig getNavigationBarHeight], SCREEN_WIDTH - 20, 25)];
    self.top.text = @"昵称由中英文组成，不可添加特殊符号";
    self.top.textColor = [UIColor hdPlaceHolderColor];
    self.top.font = [UIFont systemFontOfSize:10.0f];
    [self.view addSubview:self.top];
    
    [self.view addSubview:self.nickTextField];
    self.commitBtn.frame = CGRectMake(10, CGRectGetMaxY(self.nickTextField.frame) + 110, SCREEN_WIDTH - 20, 40);
    [self.view addSubview:self.commitBtn];
    
    self.nickTextField.text = self.nickName;
}
- (void)saveClick{
    if (self.nickTextField.text.length > 0) {
        [[IQKeyboardManager sharedManager] resignFirstResponder];
        [self changeNickName];
    }else{
        [self.nickTextField becomeFirstResponder];
        [HSToast hsShowBottomWithText:@"请输入昵称"];
    }
}
- (void)changeNickName{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *url = [HttpNetRequestTool requestUrlString:@"/user/modify/index"];
    NSDictionary *dict = @{@"field":@"user_nickname",@"value":self.nickTextField.text};
    [HttpNetRequestTool netRequestWithHeader:HttpNetRequestPost urlString:url paraments:dict success:^(id Json) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        BaseModel *model = [BaseModel yy_modelWithJSON:Json];
        if (model.code == 1) {
            if (self.refreshBlock) {
                self.refreshBlock();
            }
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [HSToast hsShowBottomWithText:model.msg];
        }
    } failure:^(NSString *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [HSToast hsShowBottomWithText:error];
    }];
}
#pragma mark --laod--
- (MyTextField *)nickTextField{
    if (!_nickTextField) {
        _nickTextField = [[HDSpaceTextField alloc] initWithFrame:CGRectMake(1, CGRectGetMaxY(self.top.frame), SCREEN_WIDTH - 2, 40)];
       
        UIView *left = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
        _nickTextField.leftView = left;
        _nickTextField.leftViewMode = UITextFieldViewModeAlways;
        UIView *right = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
        _nickTextField.rightView = right;
        _nickTextField.rightViewMode = UITextFieldViewModeAlways;
        _nickTextField.borderStyle = UITextBorderStyleNone;
        _nickTextField.placeholder = @"输入昵称";
        _nickTextField.placeholderFont = [UIFont systemFontOfSize:14.0f];
        _nickTextField.placeholderColor = [UIColor hdPlaceHolderColor];
        _nickTextField.font = [UIFont systemFontOfSize:17.0f];
        _nickTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _nickTextField.backgroundColor = [UIColor whiteColor];
        _nickTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;//水平
    }
    return _nickTextField;
}
- (UIButton *)commitBtn{
    if (!_commitBtn) {
        _commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _commitBtn.layer.cornerRadius = 20;
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
