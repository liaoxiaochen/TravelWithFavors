//
//  PetWeightController.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/9.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "PetWeightController.h"

@interface PetWeightController ()<UITextFieldDelegate>
@property (nonatomic, strong) HDSpaceTextField *weightTextField;

@property (nonatomic, strong) UILabel *top;


@end

@implementation PetWeightController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"宠物体重";
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT - [AppConfig getButtomHeight])];
    bgView.backgroundColor = [UIColor hdTableViewBackGoundColor];
    [self.view addSubview:bgView];
    
    self.top = [[UILabel alloc] initWithFrame:CGRectMake(10, [AppConfig getNavigationBarHeight], SCREEN_WIDTH - 20, 25)];
    self.top.text = @"输入宠物体重：（例如10kg）";
    self.top.textColor = [UIColor hdPlaceHolderColor];
    self.top.font = [UIFont systemFontOfSize:10.0f];
    [bgView addSubview:self.top];
    
    
//    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(10, [AppConfig getNavigationBarHeight] + 10, SCREEN_WIDTH - 20, 40)];
//    topView.backgroundColor = [UIColor whiteColor];
//    [bgView addSubview:topView];
//
//    self.weightTextField =[[HDSpaceTextField alloc] initWithFrame:CGRectMake(1, CGRectGetMaxY(self.top.frame), SCREEN_WIDTH - 2, 50)];
//    self.weightTextField.placeholder = @"输入宠物体重：（例如10kg）";
//    self.weightTextField.placeholderFont = [UIFont systemFontOfSize:14.0f];
//    self.weightTextField.placeholderColor = [UIColor colorWithHexString:@"#999999"];
//    self.weightTextField.keyboardType = UIKeyboardTypeDecimalPad;
    [bgView addSubview:self.weightTextField];
    
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    saveBtn.adjustsImageWhenHighlighted = NO;
    saveBtn.frame = CGRectMake(10, CGRectGetMaxY(self.weightTextField.frame) + 110, SCREEN_WIDTH - 20, 40);
    saveBtn.layer.cornerRadius = 20;
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

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    
    if (textField == self.weightTextField) {
        //这里的if时候为了获取删除操作,如果没有次if会造成当达到字数限制后删除键也不能使用的后果.
        if (range.length == 1 && string.length == 0) {
            return YES;
        }
        //so easy
        else if (self.weightTextField.text.length >= 6) {
            self.weightTextField.text = [textField.text substringToIndex:6];
            return NO;
        }
        
    }
    return [self validateNumber:string];
}

- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (MyTextField *)weightTextField{
    if (!_weightTextField) {
        _weightTextField = [[HDSpaceTextField alloc] initWithFrame:CGRectMake(1, CGRectGetMaxY(self.top.frame), SCREEN_WIDTH - 2, 40)];
        
        UIView *left = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
        _weightTextField.leftView = left;
        _weightTextField.leftViewMode = UITextFieldViewModeAlways;
        UIView *right = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
        _weightTextField.rightView = right;
        _weightTextField.rightViewMode = UITextFieldViewModeAlways;
        _weightTextField.borderStyle = UITextBorderStyleNone;
        _weightTextField.placeholder = @"输入宠物体重：（例如10kg）";
        _weightTextField.placeholderFont = [UIFont systemFontOfSize:14.0f];
        _weightTextField.placeholderColor = [UIColor hdPlaceHolderColor];
        _weightTextField.font = [UIFont systemFontOfSize:17.0f];
        _weightTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _weightTextField.backgroundColor = [UIColor whiteColor];
        _weightTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;//水平
        _weightTextField.keyboardType = UIKeyboardTypeNumberPad;
        _weightTextField.delegate = self;
    }
    return _weightTextField;
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
