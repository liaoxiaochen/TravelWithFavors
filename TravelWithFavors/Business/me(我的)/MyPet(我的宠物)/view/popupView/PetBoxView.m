//
//  PetBoxView.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/8.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "PetBoxView.h"
@interface PetBoxView ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UIView *changView;
@property (weak, nonatomic) IBOutlet UIView *kuanView;
@property (weak, nonatomic) IBOutlet UIView *gaoView;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

@property (nonatomic, assign) CGFloat keyboardHeight;

@end
@implementation PetBoxView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    self.bgView.frame = CGRectMake(0, self.frame.size.height, SCREEN_WIDTH, 250);
    self.bgView.layer.cornerRadius = 5;
    self.bgView.layer.masksToBounds = YES;
    self.sureBtn.layer.cornerRadius = 3;
    self.cancelBtn.layer.cornerRadius = 3;
    
    self.changView.layer.cornerRadius = 3;
    self.changView.layer.masksToBounds = YES;
    self.changView.layer.borderColor = [UIColor colorWithHexString:@"#DDDDDD"].CGColor;
    self.changView.layer.borderWidth = 1;
    
    self.kuanView.layer.cornerRadius = 3;
    self.kuanView.layer.masksToBounds = YES;
    self.kuanView.layer.borderColor = [UIColor colorWithHexString:@"#DDDDDD"].CGColor;
    self.kuanView.layer.borderWidth = 1;
    
    self.gaoView.layer.cornerRadius = 3;
    self.gaoView.layer.masksToBounds = YES;
    self.gaoView.layer.borderColor = [UIColor colorWithHexString:@"#DDDDDD"].CGColor;
    self.gaoView.layer.borderWidth = 1;
    
    self.changTextField.keyboardType = UIKeyboardTypeDecimalPad;
    self.kuanTextField.keyboardType = UIKeyboardTypeDecimalPad;
    self.gaoTextField.keyboardType = UIKeyboardTypeDecimalPad;
    
    self.changTextField.delegate = self;
    self.kuanTextField.delegate = self;
    self.gaoTextField.delegate = self;
    
  
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
 
}



- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    //这里的if时候为了获取删除操作,如果没有次if会造成当达到字数限制后删除键也不能使用的后果.
    if (range.length == 1 && string.length == 0) {
        return YES;
    } else if (textField.text.length >= 3) {
        textField.text = [textField.text substringToIndex:3];
        return NO;
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



- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    self.keyboardHeight = keyboardRect.size.height;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint point = [touch locationInView:self.bgView];
    if (![self.bgView.layer containsPoint:point]) {
        [self dismiss];
    }
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if (self.keyboardHeight == 0) {
        self.keyboardHeight = 250;
    }
    [UIView animateWithDuration:0.2 animations:^{
        
        self.bgView.frame = CGRectMake(0, self.frame.size.height - 250 - self.keyboardHeight, SCREEN_WIDTH, 250);
    }];
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    [UIView animateWithDuration:0.2 animations:^{
        self.bgView.frame = CGRectMake(0, self.frame.size.height - 250, SCREEN_WIDTH, 250);
    }];
}

- (void)showPetBoxView{
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0.2 animations:^{
        self.bgView.frame = CGRectMake(0, self.frame.size.height - 250, SCREEN_WIDTH, 250);
    }];
}
- (void)dismiss{
    [UIView animateWithDuration:0.2 animations:^{
        self.bgView.frame = CGRectMake(0, self.frame.size.height, SCREEN_WIDTH, 250);

    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
}
- (BOOL)canSure{
    if (self.changTextField.text.length <= 0) {
        [HSToast hsShowTopWithText:@"请填写长度"];
        return NO;
    }
    if (self.kuanTextField.text.length <= 0) {
        [HSToast hsShowTopWithText:@"请填写宽度"];
        return NO;
    }
    if (self.gaoTextField.text.length <= 0) {
        [HSToast hsShowTopWithText:@"请填写高度"];
        return NO;
    }
    [[IQKeyboardManager sharedManager] resignFirstResponder];
    return YES;
}
- (IBAction)sureBtnClick:(id)sender {
    if ([self canSure]) {
        if (self.boxBlock) {
            self.boxBlock(self.changTextField.text, self.kuanTextField.text, self.gaoTextField.text);
        }
        [self dismiss];
    }
}
- (IBAction)cancelBtnClick:(id)sender {
    [self dismiss];
}

@end
