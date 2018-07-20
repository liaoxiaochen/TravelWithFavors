//
//  PetBoxView.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/8.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "PetBoxView.h"
@interface PetBoxView ()
@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UIView *changView;
@property (weak, nonatomic) IBOutlet UIView *kuanView;
@property (weak, nonatomic) IBOutlet UIView *gaoView;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;


@end
@implementation PetBoxView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
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
}
- (void)showPetBoxView{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}
- (void)dismiss{
    [self removeFromSuperview];
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
