//
//  AddressTableViewCell.m
//  TravelWithFavors
//
//  Created by MacBook on 2018/8/21.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "AddressTableViewCell.h"

@interface AddressTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *idnumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIImageView *editImg;

@end

@implementation AddressTableViewCell

- (void)setAddressModel:(AddressInfoModel *)addressModel {
    _addressModel = addressModel;
    _nameLabel.text = _addressModel.name;
    _idnumberLabel.text = _addressModel.mobile;
    _addressLabel.text = [NSString stringWithFormat:@"%@%@%@%@", _addressModel.province, _addressModel.city, _addressModel.area, _addressModel.address];
    
    if ([_addressModel.is_default intValue] == 1) {
        _selectImg.image = [UIImage imageNamed:@"sc_xzdz_dui"];
    }else {
        _selectImg.image = [UIImage imageNamed:@""];
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.editImg addTapGestureRecognizer:^(id parameter) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(addressEditWithAddressId:)]) {
            [self.delegate addressEditWithAddressId:_addressModel.address_id];
        }
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
