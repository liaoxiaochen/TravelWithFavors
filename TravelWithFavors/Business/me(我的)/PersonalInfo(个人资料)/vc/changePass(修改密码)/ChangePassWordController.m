//
//  ChangePassWordController.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/2.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "ChangePassWordController.h"
#import "ChangePassWordCodeController.h"
@interface ChangePassWordController ()
@property (nonatomic, strong) MyTextField *passTF;
@property (nonatomic, strong) MyTextField *nwPassTF;
@property (nonatomic, strong) MyTextField *nwRePassTF;
@end

@implementation ChangePassWordController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"修改密码";
    [self configView];
}
- (void)configView{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT - [AppConfig getButtomHeight])];
    bgView.backgroundColor = [UIColor hdTableViewBackGoundColor];
    [self.view addSubview:bgView];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, [AppConfig getNavigationBarHeight] + 10, SCREEN_WIDTH, 40)];
    topView.backgroundColor = [UIColor whiteColor];
    
    UILabel *topLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 60, 20)];
    topLabel.text = @"旧密码";
    topLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    topLabel.font = [UIFont systemFontOfSize:14.0f];
    [topView addSubview:topLabel];
    
    self.passTF = [[MyTextField alloc] initWithFrame:CGRectMake(80, 5, topView.bounds.size.width - 90, 30)];
//    self.passTF.placeholder = @"请输入旧密码";
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.alignment = NSTextAlignmentLeft;
    NSAttributedString *attri = [[NSAttributedString alloc] initWithString:@"请输入旧密码" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#999999"],NSFontAttributeName:[UIFont systemFontOfSize:12.0f], NSParagraphStyleAttributeName:style}];
    self.passTF.attributedPlaceholder = attri;
    self.passTF.secureTextEntry = YES;
    [topView addSubview:self.passTF];
    [self.view addSubview:topView];
    
    UIView *centerView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(topView.frame) + 1, SCREEN_WIDTH, 40)];
    centerView.backgroundColor = [UIColor whiteColor];
    
    UILabel *centerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 60, 20)];
    centerLabel.text = @"新密码";
    centerLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    centerLabel.font = [UIFont systemFontOfSize:14.0f];
    [centerView addSubview:centerLabel];
    
    self.nwPassTF = [[MyTextField alloc] initWithFrame:CGRectMake(80, 5, topView.bounds.size.width - 90, 30)];
    self.nwPassTF.secureTextEntry = YES;
    NSMutableParagraphStyle *newStyle = [[NSMutableParagraphStyle alloc] init];
    newStyle.alignment = NSTextAlignmentLeft;
    NSAttributedString *newAttri = [[NSAttributedString alloc] initWithString:@"请输入新密码" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#999999"],NSFontAttributeName:[UIFont systemFontOfSize:12.0f], NSParagraphStyleAttributeName:newStyle}];
    self.nwPassTF.attributedPlaceholder = newAttri;
    [centerView addSubview:self.nwPassTF];
    [self.view addSubview:centerView];
    
    UIView *buttomView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(centerView.frame) + 1, SCREEN_WIDTH, 40)];
    buttomView.backgroundColor = [UIColor whiteColor];
    
    UILabel *buttomLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 60, 20)];
    buttomLabel.text = @"确认密码";
    buttomLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    buttomLabel.font = [UIFont systemFontOfSize:14.0f];
    [buttomView addSubview:buttomLabel];
    
    self.nwRePassTF = [[MyTextField alloc] initWithFrame:CGRectMake(80, 5, topView.bounds.size.width - 90, 30)];
    self.nwRePassTF.secureTextEntry = YES;
    NSMutableParagraphStyle *reStyle = [[NSMutableParagraphStyle alloc] init];
    reStyle.alignment = NSTextAlignmentLeft;
    NSAttributedString *reAttri = [[NSAttributedString alloc] initWithString:@"请输入新密码" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#999999"],NSFontAttributeName:[UIFont systemFontOfSize:12.0f], NSParagraphStyleAttributeName:reStyle}];
    self.nwRePassTF.attributedPlaceholder = reAttri;
    [buttomView addSubview:self.nwRePassTF];
    [self.view addSubview:buttomView];
    
    UIButton *codeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    codeBtn.frame = CGRectMake(SCREEN_WIDTH - 138, CGRectGetMaxY(buttomView.frame) + 2, 130, 30);
    codeBtn.adjustsImageWhenHighlighted = NO;
    [codeBtn setTitleColor:[UIColor colorWithHexString:@"#2E8BE2"] forState:UIControlStateNormal];
    [codeBtn setTitle:@"短信验证码修改密码" forState:UIControlStateNormal];
    codeBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [codeBtn addTarget:self action:@selector(codeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:codeBtn];
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.adjustsImageWhenHighlighted = NO;
    sureBtn.frame = CGRectMake(10, CGRectGetMaxY(buttomView.frame) + 84, SCREEN_WIDTH - 20, 40);
    sureBtn.layer.cornerRadius = 3;
    sureBtn.backgroundColor = [UIColor hdMainColor];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [sureBtn addTarget:self action:@selector(saveClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sureBtn];
}
- (void)codeBtnClick{
    ChangePassWordCodeController *vc = [[ChangePassWordCodeController alloc] init];
    vc.userInfo = self.userInfo;
    [self.navigationController pushViewController:vc animated:YES];
}
- (BOOL)canCommit{
     [[IQKeyboardManager sharedManager] resignFirstResponder];
    if (self.passTF.text.length <= 0) {
//        [self.passTF becomeFirstResponder];
        [HSToast hsShowBottomWithText:@"请输入旧密码"];
        return NO;
    }
    if (![self.passTF.text isEqualToString:[AppConfig getPassWord]]) {
//        [self.passTF becomeFirstResponder];
        [HSToast hsShowBottomWithText:@"旧密码错误"];
        return NO;
    }
    if (self.nwPassTF.text.length <= 0) {
//        [self.nwPassTF becomeFirstResponder];
        [HSToast hsShowBottomWithText:@"请输入新密码"];
        return NO;
    }
    if (self.nwRePassTF.text.length <= 0) {
//        [self.nwRePassTF becomeFirstResponder];
        [HSToast hsShowBottomWithText:@"请再次输入新密码"];
        return NO;
    }
    if (![self.nwRePassTF.text isEqualToString:self.nwRePassTF.text]) {
//        [self.nwRePassTF becomeFirstResponder];
        [HSToast hsShowBottomWithText:@"新密码不一致"];
        return NO;
    }
    return YES;
}
- (void)saveClick{
    if ([self canCommit]) {
        [self changePass];
    }
}
- (void)changePass{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *url = [HttpNetRequestTool requestUrlString:@"/user/modify/index"];
    NSDictionary *dict = @{@"update_pass_type":@"1",@"password_old":self.passTF.text,@"password":self.nwPassTF.text,@"password2":self.nwRePassTF.text,@"field":@"user_pass"};
    [HttpNetRequestTool netRequestWithHeader:HttpNetRequestPost urlString:url paraments:dict success:^(id Json) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        BaseModel *model = [BaseModel yy_modelWithJSON:Json];
        if (model.code == 1) {
            [AppConfig setPassWord:self.nwRePassTF.text];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshUserInfo" object:nil];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [HSToast hsShowBottomWithText:model.msg];
        }
    } failure:^(NSString *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [HSToast hsShowBottomWithText:error];
    }];
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
