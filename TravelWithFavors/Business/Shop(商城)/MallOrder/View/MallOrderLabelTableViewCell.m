//
//  MallOrderLabelTableViewCell.m
//  TravelWithFavors
//
//  Created by MacBook on 2018/8/23.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "MallOrderLabelTableViewCell.h"

@interface MallOrderLabelTableViewCell()

@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@end

@implementation MallOrderLabelTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        [self.contentView addSubview:self.tipLabel];
        [self.contentView addSubview:self.contentLabel];
    }
    return self;
}

- (void)setPriceStr:(NSString *)priceStr {
    _priceStr = priceStr;
    _contentLabel.attributedText = [NSString changeLabelColorAndFontWithMainStr:_priceStr diffrenStr:@"(运费 ￥10)" diffrenColor:[UIColor hdTipTextColor] diffrenFont:10];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (UILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 60, CONTENT_HEIGHT)];
        _tipLabel.text = @"支付金额";
        _tipLabel.font = [UIFont systemFontOfSize:12];
        _tipLabel.textColor = [UIColor hdTipTextColor];
    }
    return _tipLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.tipLabel.frame), 0, CONTENT_WIDTH - CGRectGetMaxX(self.tipLabel.frame) - 10, CONTENT_HEIGHT)];
        _contentLabel.text = @"￥678 (运费 ￥10)";
        _contentLabel.font = [UIFont systemFontOfSize:12];
        _contentLabel.textColor = [UIColor hdRedColor];
    }
    return _contentLabel;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
