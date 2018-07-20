//
//  OrderPetAddPopupView.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/7.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "OrderPetAddPopupView.h"

@implementation OrderPetAddPopupView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    self.bgView.layer.cornerRadius = 5;
    self.bgView.layer.masksToBounds = YES;
    
    self.nameTextField.placeholderFont = [UIFont systemFontOfSize:13.0f];
    self.nameTextField.placeholderColor = [UIColor colorWithHexString:@"#999999"];
    self.choseSwitch.transform = CGAffineTransformMakeScale( 36.0/51.0, 21.0/31.0);//缩放
}

- (IBAction)sureBtnClick:(id)sender {
}
- (IBAction)cancelBtnClick:(id)sender {
    [self dismiss];
}

- (void)showOrderPetAddPopupView{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}
- (void)dismiss{
    [self removeFromSuperview];
}
@end
