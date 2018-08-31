//
//  MallRemarkTableViewCell.m
//  TravelWithFavors
//
//  Created by MacBook on 2018/8/23.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "MallRemarkTableViewCell.h"

@interface MallRemarkTableViewCell()

@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UITextField *remarkTf;

@end

@implementation MallRemarkTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.tipLabel];
        [self.contentView addSubview:self.remarkTf];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (UILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 50, CONTENT_HEIGHT)];
        _tipLabel.text = @"备注";
        _tipLabel.font = [UIFont systemFontOfSize:12];
        _tipLabel.textColor = [UIColor hdTipTextColor];
    }
    return _tipLabel;
}

- (UITextField *)remarkTf {
    if (!_remarkTf) {
        _remarkTf = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.tipLabel.frame), 0, SCREEN_WIDTH - CGRectGetMaxX(self.tipLabel.frame) - 10, CONTENT_HEIGHT)];
        _remarkTf.placeholder = @"留言给卖家";
        _remarkTf.textColor = [UIColor hdTipTextColor];
        _remarkTf.font = [UIFont systemFontOfSize:12];
    }
    return _remarkTf;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
