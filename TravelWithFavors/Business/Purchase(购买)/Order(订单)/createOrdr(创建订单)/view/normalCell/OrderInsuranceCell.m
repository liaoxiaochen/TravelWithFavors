//
//  OrderInsuranceCell.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/6.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "OrderInsuranceCell.h"

@implementation OrderInsuranceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)selectBtnClick:(UIButton *)sender {
    if (self.selectBlock) {
        self.selectBlock(self.insuranceModel);
    }
}
-(void)setInsuranceModel:(InsuranceModel *)insuranceModel{
    _insuranceModel = insuranceModel;
    _nameLabel.text = _insuranceModel.i_name;
    _priceLabel.text = [NSString stringWithFormat:@"￥%@/份",_insuranceModel.i_price];
    if (_insuranceModel.isSelected) {
        _leftImageView.image = [UIImage imageNamed:@"bx_gxh.png"];
    }else{
        _leftImageView.image = [UIImage imageNamed:@"bx_gx.png"];
    }
    if (insuranceModel.i_account) {
        _detailLabel.text = [NSString stringWithFormat:@"最高保额￥%@，让您行程无忧！",insuranceModel.i_account];
    }else{
        _detailLabel.text = @"最高保额￥0元，让您行程无忧！";
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
