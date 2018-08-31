//
//  MallOrderOperationTableViewCell.m
//  TravelWithFavors
//
//  Created by MacBook on 2018/8/25.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "MallOrderOperationTableViewCell.h"

@implementation MallOrderOperationTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.leftLabel];
        [self.contentView addSubview:self.rightLabel];
        [self.contentView addSubview:self.copyBtn];
        [self.contentView addSubview:self.cancelBtn];

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
    
    CGFloat rightWidth = [UILabel getWidthWithText:self.rightLabel.text height:CONTENT_HEIGHT font:12];
    self.rightLabel.frame = CGRectMake(CGRectGetMaxX(self.leftLabel.frame) , 0, rightWidth, CONTENT_HEIGHT);
    
    self.copyBtn.frame = CGRectMake(CGRectGetMaxX(self.rightLabel.frame) + 10, (CONTENT_HEIGHT - 20) / 2, 40, 20);
    
    if (self.showCopyBtn) {
        self.copyBtn.hidden = NO;
    }else {
        self.copyBtn.hidden = YES;
    }
    if (self.showCancelBtn) {
        self.cancelBtn.hidden = NO;
    }else {
        self.cancelBtn.hidden = YES;
    }
}
- (void)copyBtnAction {
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.rightLabel.text;
    [HSToast hsShowBottomWithText:@"复制成功"];
}
- (void)cancelBtnAction {
    
}

- (UILabel *)leftLabel {
    if (!_leftLabel) {
        _leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 50, CONTENT_HEIGHT)];
        _leftLabel.textColor = [UIColor hdTipTextColor];
        _leftLabel.font = [UIFont systemFontOfSize:12];
        _leftLabel.text = @"订单状态";
        _leftLabel.textAlignment = NSTextAlignmentLeft;
        
    }
    return _leftLabel;
}
- (UILabel *)rightLabel {
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.leftLabel.frame), 0, SCREEN_WIDTH - CGRectGetMaxX(self.leftLabel.frame) - 10, CONTENT_HEIGHT)];
        _rightLabel.textColor = [UIColor hdTextColor];
        _rightLabel.font = [UIFont systemFontOfSize:12];
        _rightLabel.text = @"已发货";
        _rightLabel.numberOfLines = 0;
        _rightLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _rightLabel;
}
- (UIButton *)copyBtn {
    if (!_copyBtn) {
        _copyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _copyBtn.frame = CGRectMake(0, (CONTENT_HEIGHT - 20) / 2, 40, 20);
        [_copyBtn setTitle:@"复制" forState:UIControlStateNormal];
        [_copyBtn setTitleColor:[UIColor hdTextColor] forState:UIControlStateNormal];
        _copyBtn.titleLabel.font = [UIFont systemFontOfSize:12];
         _copyBtn.layer.cornerRadius = 8;
        _copyBtn.layer.borderColor = [UIColor hdTextColor].CGColor;
        _copyBtn.layer.borderWidth = 1;
        [_copyBtn addTarget:self action:@selector(copyBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _copyBtn;
}
- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelBtn.frame = CGRectMake(SCREEN_WIDTH - 80, (CONTENT_HEIGHT - 20) / 2, 70, 20);
        [_cancelBtn setTitle:@"取消申请" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor hdTextColor] forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        _cancelBtn.layer.cornerRadius = 8;
        _cancelBtn.layer.borderColor = [UIColor hdTextColor].CGColor;
        _cancelBtn.layer.borderWidth = 1;
        [_cancelBtn addTarget:self action:@selector(cancelBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
