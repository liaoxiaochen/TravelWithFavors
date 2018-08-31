//
//  GoodsDetailTableViewCell.m
//  TravelWithFavors
//
//  Created by MacBook on 2018/8/17.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "GoodsDetailTableViewCell.h"

@implementation GoodsDetailTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.leftLabel];
        [self.contentView addSubview:self.rightLabel];
        [self.contentView addSubview:self.sepreView];

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
    self.leftLabel.frame = CGRectMake(10, 5, textWidth + 10, 15);
    
    CGFloat cellHeight = [UILabel getLabelHeightWithText:self.rightLabel.text width:SCREEN_WIDTH - 70 font:12];
    CGRect frame = self.rightLabel.frame;
    frame.size.height = cellHeight;
    frame.origin.x = CGRectGetMaxX(self.leftLabel.frame);
    frame.size.width = SCREEN_WIDTH - CGRectGetMaxX(self.leftLabel.frame) - 10;
    self.rightLabel.frame = frame;
    
    CGRect sepreFrame = self.sepreView.frame;
    sepreFrame.origin.y = CONTENT_HEIGHT - 1;
    self.sepreView.frame = sepreFrame;
 
   
}
- (UIView *)sepreView {
    if (!_sepreView) {
        _sepreView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        _sepreView.backgroundColor = [UIColor hdTableViewBackGoundColor];
    }
    return _sepreView;
}

- (UILabel *)leftLabel {
    if (!_leftLabel) {
        _leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 50, 15)];
        _leftLabel.textColor = [UIColor hdTipTextColor];
        _leftLabel.font = [UIFont systemFontOfSize:12];
        _leftLabel.text = @"已选";
        _leftLabel.textAlignment = NSTextAlignmentLeft;

    }
    return _leftLabel;
}
- (UILabel *)rightLabel {
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.leftLabel.frame), 5, SCREEN_WIDTH - CGRectGetMaxX(self.leftLabel.frame) - 10, CONTENT_HEIGHT - 10)];
        _rightLabel.textColor = [UIColor blackColor];
        _rightLabel.font = [UIFont systemFontOfSize:12];
        _rightLabel.text = @"已选";
        _rightLabel.numberOfLines = 0;
        _rightLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _rightLabel;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
