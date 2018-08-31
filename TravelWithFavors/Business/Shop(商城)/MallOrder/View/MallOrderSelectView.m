//
//  MallOrderSelectView.m
//  TravelWithFavors
//
//  Created by MacBook on 2018/8/23.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "MallOrderSelectView.h"

@interface MallOrderSelectView()

@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UIImageView *selectImg;
@property (nonatomic, strong) UILabel *selectLabel;
@property (nonatomic, strong) UIImageView *spreadImg;

@end

@implementation MallOrderSelectView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.tipLabel];
        [self addSubview:self.selectImg];
        [self addSubview:self.selectLabel];
//        [self addSubview:self.spreadImg];
    }
    return self;
}
- (void)setHeaderStr:(NSString *)headerStr {
    _headerStr = headerStr;
    _tipLabel.text = _headerStr;
    CGFloat tipLabelwidth = [UILabel getWidthWithText:_headerStr height:SELF_HEIGHT font:12];
    _tipLabel.frame = CGRectMake(10, 0, tipLabelwidth, SELF_HEIGHT);
    _selectImg.frame = CGRectMake(CGRectGetMaxX(self.tipLabel.frame) + 20, (SELF_HEIGHT - 15) /2, 15,  15);
    _selectLabel.frame = CGRectMake(CGRectGetMaxX(self.selectImg.frame) + 5, 0, 100, SELF_HEIGHT);

    
}
- (void)setSelectArr:(NSArray *)selectArr {
    _selectArr = selectArr;
    _selectLabel.text = _selectArr[0];
    _selectImg.image = [UIImage imageNamed:_selectArr[1]];

}
- (UILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 50, SELF_HEIGHT)];
        _tipLabel.text = @"支付方式";
        
        _tipLabel.font = [UIFont systemFontOfSize:12];
        _tipLabel.textColor = [UIColor hdTipTextColor];
    }
    return _tipLabel;
}
- (UIImageView *)selectImg {
    if (!_selectImg) {
        _selectImg = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.tipLabel.frame) + 20, (SELF_HEIGHT - 15) /2, 15,  15)];
        _selectImg.image = [UIImage imageNamed:@"sc_dptb"];
    }
    return _selectImg;
}
- (UILabel *)selectLabel {
    if (!_selectLabel) {
        _selectLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.selectImg.frame) + 5, 0, 100, SELF_HEIGHT)];
        _selectLabel.text = @"支付宝";
        _selectLabel.font = [UIFont systemFontOfSize:12];
        _selectLabel.textColor = [UIColor hdTipTextColor];
    }
    return _selectLabel;
}
- (UIImageView *)spreadImg {
    if (!_spreadImg) {
        _spreadImg = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 25, (SELF_HEIGHT - 15) /2, 15,  10)];
        _spreadImg.image = [UIImage imageNamed:@"ddzf_jtx"];
    }
    return _spreadImg;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
