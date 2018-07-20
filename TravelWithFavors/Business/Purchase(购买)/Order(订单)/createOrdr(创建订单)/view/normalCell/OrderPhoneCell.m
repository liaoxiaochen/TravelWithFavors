//
//  OrderPhoneCell.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/6.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "OrderPhoneCell.h"

@implementation OrderPhoneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [_phoneTextField addTarget:self action:@selector(textFieldViewDidChange:) forControlEvents:UIControlEventEditingChanged];
}

-(void)textFieldViewDidChange:(UITextField*)textField {
    if (textField == _phoneTextField) {
        if (self.inputBlock) {
            self.inputBlock(_phoneTextField);
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
