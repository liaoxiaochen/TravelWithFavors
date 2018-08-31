//
//  MallOrderAddressTableViewCell.m
//  TravelWithFavors
//
//  Created by MacBook on 2018/8/23.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "MallOrderAddressTableViewCell.h"
#import "AddressInfoModel.h"
@interface MallOrderAddressTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *personName;
@property (weak, nonatomic) IBOutlet UILabel *personAddress;

@end

@implementation MallOrderAddressTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    // Initialization code
}

- (void)setAddressModel:(AddressInfoModel *)addressModel {
    _addressModel = addressModel;
    if (!_addressModel) {
        
        self.personName.text = @"姓名";
        self.personAddress.text = @"省市区地址";
    }else {
        self.personName.text = _addressModel.name;
        self.personAddress.text = [NSString stringWithFormat:@"%@%@%@%@", _addressModel.province, _addressModel.city, _addressModel.area, _addressModel.address];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
