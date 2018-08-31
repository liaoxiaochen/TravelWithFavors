//
//  SwitchTableViewCell.m
//  TravelWithFavors
//
//  Created by MacBook on 2018/8/21.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "SwitchTableViewCell.h"

@implementation SwitchTableViewCell
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
    [self.contentView addSubview:self.switchBtn];
}

- (void)switchBtnAction {
    NSString *isDefault = @"0";
    if (self.switchBtn.isOn) {
        isDefault = @"1";
    }
    if (self.SwitchBlock) {
        self.SwitchBlock(isDefault);
    }
}


- (UISwitch *)switchBtn {
    if (!_switchBtn) {
        _switchBtn = [[UISwitch alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 65, 0, 35, CONTENT_HEIGHT)];
        [_switchBtn addTarget:self action:@selector(switchBtnAction) forControlEvents:UIControlEventValueChanged];
        _switchBtn.centerY = self.centerY;
    }
    return _switchBtn;
}
- (UILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, CONTENT_HEIGHT)];
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
