//
//  ShopCartCollectionViewCell.m
//  TravelWithFavors
//
//  Created by MacBook on 2018/8/22.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "ShopCartCollectionViewCell.h"
#import "PPNumberButton.h"

@interface ShopCartCollectionViewCell()

@property (nonatomic, strong) PPNumberButton *numberBtn;

@end

@implementation ShopCartCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.contentView.backgroundColor = [UIColor hdTableViewBackGoundColor];
    [self.numbeBtnView addSubview:self.numberBtn];
}

- (IBAction)shopCartClick:(id)sender {

    UIButton *btn = (UIButton *)sender;
    btn.selected = !btn.selected;
    if (btn.selected) {
        [btn setImage:[UIImage imageNamed:@"sc_js_xz"] forState:UIControlStateNormal];
    }else {
        [btn setImage:[UIImage imageNamed:@"sc_js_wxz"] forState:UIControlStateNormal];
    }
    if (self.shopCarListClickBlock) {
        self.shopCarListClickBlock(btn.selected);
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
- (void)layoutSubviews {
    [super layoutSubviews];
}

@end
