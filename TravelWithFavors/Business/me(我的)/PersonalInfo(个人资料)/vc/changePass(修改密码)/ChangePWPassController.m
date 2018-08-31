//
//  ChangePWPassController.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/9.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "ChangePWPassController.h"
#import "PersonalInfoController.h"
@interface ChangePWPassController ()
@property (nonatomic, strong) UITextField *passTF;
@property (nonatomic, strong) UITextField *rePassTF;
@end

@implementation ChangePWPassController

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
    topLabel.text = @"新密码";
    topLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    topLabel.font = [UIFont systemFontOfSize:14.0f];
    [topView addSubview:topLabel];
    
    self.passTF = [[MyTextField alloc] initWithFrame:CGRectMake(80, 5, topView.bounds.size.width - 90, 30)];
    self.passTF.secureTextEntry = YES;
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.alignment = NSTextAlignmentLeft;
    NSAttributedString *attri = [[NSAttributedString alloc] initWithString:@"请输入新密码" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#999999"],NSFontAttributeName:[UIFont systemFontOfSize:12.0f], NSParagraphStyleAttributeName:style}];
    self.passTF.attributedPlaceholder = attri;
    [topView addSubview:self.passTF];
    [self.view addSubview:topView];
    
    UIView *centerView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(topView.frame) + 1, SCREEN_WIDTH, 40)];
    centerView.backgroundColor = [UIColor whiteColor];
    
    UILabel *centerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 60, 20)];
    centerLabel.text = @"确认密码";
    centerLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    centerLabel.font = [UIFont systemFontOfSize:14.0f];
    [centerView addSubview:centerLabel];
    
    self.rePassTF = [[MyTextField alloc] initWithFrame:CGRectMake(80, 5, topView.bounds.size.width - 90, 30)];
    self.rePassTF.secureTextEntry = YES;
    NSMutableParagraphStyle *newStyle = [[NSMutableParagraphStyle alloc] init];
    newStyle.alignment = NSTextAlignmentLeft;
    NSAttributedString *newAttri = [[NSAttributedString alloc] initWithString:@"请再次输入密码" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#999999"],NSFontAttributeName:[UIFont systemFontOfSize:12.0f], NSParagraphStyleAttributeName:newStyle}];
    self.rePassTF.attributedPlaceholder = newAttri;
    [centerView addSubview:self.rePassTF];
    [self.view addSubview:centerView];
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.adjustsImageWhenHighlighted = NO;
    sureBtn.frame = CGRectMake(10, CGRectGetMaxY(centerView.frame) + 74, SCREEN_WIDTH - 20, 40);
    sureBtn.layer.cornerRadius = 20;
    sureBtn.backgroundColor = [UIColor hdMainColor];
    [sureBtn setTitle:@"完成" forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [sureBtn addTarget:self action:@selector(saveClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sureBtn];
}
- (BOOL)canSave{
    [[IQKeyboardManager sharedManager] resignFirstResponder];
    if (self.passTF.text.length <= 0) {
//        [self.passTF becomeFirstResponder];
        [HSToast hsShowBottomWithText:@"请输入新密码"];
        return NO;
    }
    if (self.rePassTF.text.length <= 0) {
//        [self.rePassTF becomeFirstResponder];
        [HSToast hsShowBottomWithText:@"请再次输入新密码"];
        return NO;
    }
    if (![self.passTF.text isEqualToString:self.rePassTF.text]) {
//        [self.rePassTF becomeFirstResponder];
        [HSToast hsShowBottomWithText:@"新密码不一致"];
        return NO;
    }
    return YES;
}
- (void)saveClick{
    if ([self canSave]) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSString *url = [HttpNetRequestTool requestUrlString:@"/user/modify/index"];
        NSDictionary *dict = @{@"field":@"user_pass",@"update_pass_type":@"2",@"password":self.passTF.text,@"password2":self.rePassTF.text,@"captcha":self.code};
        [HttpNetRequestTool netRequestWithHeader:HttpNetRequestPost urlString:url paraments:dict success:^(id Json) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            BaseModel *model = [BaseModel yy_modelWithJSON:Json];
            if (model.code == 1) {
                [HSToast hsShowBottomWithText:@"修改成功"];
                [AppConfig setPassWord:self.passTF.text];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshUserInfo" object:nil];
                NSArray *lists = self.navigationController.viewControllers;
                UIViewController *vc = lists[lists.count - 4];
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
