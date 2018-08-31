//
//  ApplyTextFieldTableViewCell.m
//  TravelWithFavors
//
//  Created by MacBook on 2018/8/25.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "ApplyTextFieldTableViewCell.h"

@implementation ApplyTextFieldTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.leftLabel];
        [self.contentView addSubview:self.rightTf];
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat textWidth  = [UILabel getWidthWithText:self.leftLabel.text height:CONTENT_HEIGHT font:14];
    self.leftLabel.frame = CGRectMake(10, 0, textWidth , CONTENT_HEIGHT);
    
    self.rightTf.frame = CGRectMake(CGRectGetMaxX(self.leftLabel.frame) + 10, 0, SCREEN_WIDTH - CGRectGetMaxX(self.leftLabel.frame) - 10, CONTENT_HEIGHT);
    
}


- (UILabel *)leftLabel {
    if (!_leftLabel) {
        _leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 50, CONTENT_HEIGHT)];
        _leftLabel.textColor = [UIColor hdTextColor];
        _leftLabel.font = [UIFont systemFontOfSize:14];
        _leftLabel.text = @"联系人";
        _leftLabel.textAlignment = NSTextAlignmentLeft;
        
    }
    return _leftLabel;
}
- (UITextField *)rightTf {
    if (!_rightTf) {
        _rightTf = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.leftLabel.frame), 0, SCREEN_WIDTH - CGRectGetMaxX(self.leftLabel.frame) - 10, CONTENT_HEIGHT )];
        _rightTf.textColor = [UIColor hdTextColor];
        _rightTf.font = [UIFont systemFontOfSize:14];
        _rightTf.placeholder = @"请输入";
     }
    return _rightTf;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
