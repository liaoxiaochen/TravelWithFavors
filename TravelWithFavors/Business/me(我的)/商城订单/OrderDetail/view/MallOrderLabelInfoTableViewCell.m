//
//  MallOrderLabelInfoTableViewCell.m
//  TravelWithFavors
//
//  Created by MacBook on 2018/8/25.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "MallOrderLabelInfoTableViewCell.h"

@implementation MallOrderLabelInfoTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.leftLabel];
        [self.contentView addSubview:self.rightLabel];
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat textWidth  = [UILabel getWidthWithText:self.leftLabel.text height:CONTENT_HEIGHT font:12];
    self.leftLabel.frame = CGRectMake(10, 0, textWidth , CONTENT_HEIGHT);
    
     self.rightLabel.frame = CGRectMake(CGRectGetMaxX(self.leftLabel.frame) , 0, SCREEN_WIDTH - CGRectGetMaxX(self.leftLabel.frame) - 10, CONTENT_HEIGHT);

}
- (void)cancelBtnAction {
    
}

- (UILabel *)leftLabel {
    if (!_leftLabel) {
        _leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 50, CONTENT_HEIGHT)];
        _leftLabel.textColor = [UIColor hdTipTextColor];
        _leftLabel.font = [UIFont systemFontOfSize:12];
        _leftLabel.text = @"已选";
        _leftLabel.textAlignment = NSTextAlignmentLeft;
        
    }
    return _leftLabel;
}
- (UILabel *)rightLabel {
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.leftLabel.frame), 0, SCREEN_WIDTH - CGRectGetMaxX(self.leftLabel.frame) - 10, CONTENT_HEIGHT )];
        _rightLabel.textColor = [UIColor hdTextColor];
        _rightLabel.font = [UIFont systemFontOfSize:12];
        _rightLabel.text = @"已选";
        _rightLabel.numberOfLines = 0;
        _rightLabel.textAlignment = NSTextAlignmentRight;
    }
    return _rightLabel;
}
 
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
