//
//  MallOrderGoodsTableViewCell.m
//  TravelWithFavors
//
//  Created by MacBook on 2018/8/23.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "MallOrderGoodsTableViewCell.h"
#import "PPNumberButton.h"
@interface MallOrderGoodsTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *goodImg;
@property (weak, nonatomic) IBOutlet UILabel *goodName;
@property (weak, nonatomic) IBOutlet UILabel *goodPrice;

@property (weak, nonatomic) IBOutlet UIView *numberBtnbackViwe;
@property (nonatomic, strong) PPNumberButton *numberBtn;

@property (nonatomic, strong) UILabel *numberLabel;

@end

@implementation MallOrderGoodsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    [self.numberBtnbackViwe addSubview:self.numberBtn];

}

- (void)setShowNumLabel:(BOOL)showNumLabel {
    if (showNumLabel) {
        _numberBtn.hidden = YES;
        [self.numberBtnbackViwe addSubview:self.numberLabel];
    }else {
        _numberBtn.hidden = NO;
 
    }
}

- (PPNumberButton *)numberBtn {
    if (!_numberBtn) {
        
        _numberBtn = [PPNumberButton numberButtonWithFrame:CGRectMake(0, 0, 70, 20)];
        //设置边框颜色
        _numberBtn.borderColor = [UIColor clearColor];
        _numberBtn.increaseTitle = @"＋";
        _numberBtn.decreaseTitle = @"－";
        _numberBtn.minValue = 1;
        _numberBtn.buttonTitleFont = 12;
        _numberBtn.longPressSpaceTime = CGFLOAT_MAX;
        
        //        __weak typeof(self) weakSelf = self;
        _numberBtn.resultBlock = ^(PPNumberButton *ppBtn, CGFloat number, BOOL increaseStatus){
            //                weakSelf.productInfo.productCount = number;
            //                if ([weakSelf.delegate respondsToSelector:@selector(refreshPrice)]) {
            //                    [weakSelf.delegate refreshPrice];
            //                }
        };
    }
    return _numberBtn;
}
- (UILabel *)numberLabel {
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, 20)];
        _numberLabel.text = @"* 1";
        _numberLabel.textAlignment = NSTextAlignmentRight;
        _numberLabel.font = [UIFont systemFontOfSize:12];
        _numberLabel.textColor = [UIColor hdTipTextColor];
    }
    return _numberLabel;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
