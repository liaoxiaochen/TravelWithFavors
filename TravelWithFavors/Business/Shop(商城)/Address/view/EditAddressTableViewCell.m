//
//  EditAddressTableViewCell.m
//  TravelWithFavors
//
//  Created by MacBook on 2018/8/21.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "EditAddressTableViewCell.h"

@interface EditAddressTableViewCell()

@end

@implementation EditAddressTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    [self.contentView addSubview:self.tipLabel];
    [self.contentView addSubview:self.contentTf];
    [self.contentView addSubview:self.seletAreaBtn];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return YES;
}

- (UIButton *)seletAreaBtn {
    if (!_seletAreaBtn) {
        _seletAreaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _seletAreaBtn.frame = CGRectMake(CGRectGetMaxX(self.tipLabel.frame), 0, SCREEN_WIDTH - CGRectGetMaxX(self.tipLabel.frame) - 10, CONTENT_HEIGHT);
        [_seletAreaBtn setTitle:@"请选择省市区" forState:UIControlStateNormal];
        [_seletAreaBtn setTitleColor:[UIColor hdTextColor] forState:UIControlStateNormal];
        _seletAreaBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        _seletAreaBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;

    }
    return _seletAreaBtn;
}

- (UITextField *)contentTf {
    if (!_contentTf) {
        _contentTf = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.tipLabel.frame), 0, SCREEN_WIDTH - CGRectGetMaxX(self.tipLabel.frame) - 10, CONTENT_HEIGHT)];
        _contentTf.placeholder = @"请输入";
        _contentTf.textColor = [UIColor hdTextColor];
         _contentTf.font = [UIFont systemFontOfSize:12];
    }
    return _contentTf;
}

- (UILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 80, CONTENT_HEIGHT)];
        _tipLabel.textColor = [UIColor hdTextColor];
        _tipLabel.text = @"收货人";
        _tipLabel.font = [UIFont systemFontOfSize:12];
        
    }
    return _tipLabel;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
