//
//  OrderDetailChangeCell.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/7.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "OrderDetailChangeCell.h"
@interface OrderDetailChangeCell ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backBtnWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *changeBtnWidth;

@end
@implementation OrderDetailChangeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backBtn.layer.cornerRadius = 10;
    self.backBtn.layer.borderColor = [UIColor colorWithHexString:@"#FF980D"].CGColor;
    self.backBtn.layer.borderWidth = 1;
    self.changeBtn.layer.cornerRadius = 10;
    
    self.repayBtn.layer.cornerRadius = 10;
    self.repayBtn.layer.borderColor = [UIColor colorWithHexString:@"#FF980D"].CGColor;
    self.repayBtn.layer.borderWidth = 1;
    self.repayBtn.hidden = YES;
}
-(void)setIsCompletePayment:(BOOL)isCompletePayment{
    _isCompletePayment = isCompletePayment;
    if (!isCompletePayment) {
        self.backBtn.hidden = YES;
        self.changeBtn.hidden = YES;
        self.repayBtn.hidden = NO;
    }else{
        self.backBtn.hidden = NO;
        self.changeBtn.hidden = NO;
        self.repayBtn.hidden = YES;
    }
}
- (IBAction)backTagitClick:(id)sender {
    if (self.backBlock) {
        self.backBlock();
    }
}
- (IBAction)changeClick:(id)sender {
    if (self.changeBlock) {
        self.changeBlock();
    }
}
- (IBAction)repayClick:(id)sender {
    if (self.repayBlock) {
        self.repayBlock();
    }
}
@end
