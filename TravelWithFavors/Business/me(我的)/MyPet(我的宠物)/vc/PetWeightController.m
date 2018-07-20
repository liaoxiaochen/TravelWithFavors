//
//  PetWeightController.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/9.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "PetWeightController.h"

@interface PetWeightController ()
@property (nonatomic, strong) MyTextField *weightTextField;
@end

@implementation PetWeightController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"宠物体重";
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT - [AppConfig getButtomHeight])];
    bgView.backgroundColor = [UIColor hdTableViewBackGoundColor];
    [self.view addSubview:bgView];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(10, [AppConfig getNavigationBarHeight] + 10, SCREEN_WIDTH - 20, 40)];
    topView.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:topView];
    
    self.weightTextField = [[MyTextField alloc] initWithFrame:CGRectMake(10, 5, bgView.bounds.size.width - 20, 30)];
    self.weightTextField.placeholder = @"输入宠物体重：（例如10kg）";
    self.weightTextField.placeholderFont = [UIFont systemFontOfSize:14.0f];
    self.weightTextField.placeholderColor = [UIColor colorWithHexString:@"#999999"];
    self.weightTextField.keyboardType = UIKeyboardTypeDecimalPad;
    [topView addSubview:self.weightTextField];
    
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    saveBtn.adjustsImageWhenHighlighted = NO;
    saveBtn.frame = CGRectMake(10, CGRectGetMaxY(topView.frame) + 96, SCREEN_WIDTH - 20, 40);
    saveBtn.layer.cornerRadius = 3;
    saveBtn.backgroundColor = [UIColor hdMainColor];
    saveBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:saveBtn];
    
    self.weightTextField.text = self.weight;
}
- (void)saveBtnClick{
    [[IQKeyboardManager sharedManager] resignFirstResponder];
    if (self.weightTextField.text.length > 0) {
        if (self.weightBlock) {
            self.weightBlock(self.weightTextField.text);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [HSToast hsShowBottomWithText:@"请输入宠物体重"];
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
