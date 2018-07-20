//
//  OrderPayCell.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/7.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "OrderPayCell.h"
@interface OrderPayCell ()
@end
@implementation OrderPayCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    // 还可增设间距
    CGFloat spacing = 5.0;
    
    // 图片右移
    CGSize imageSize = self.detailBtn.imageView.frame.size;
    self.detailBtn.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width * 2 - spacing, 0.0, 0.0);
    
    // 文字左移
    CGSize titleSize = self.detailBtn.titleLabel.frame.size;
    self.detailBtn.imageEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, - titleSize.width * 2 - spacing);
    
}
- (void)setIsOpen:(BOOL)isOpen{
    _isOpen = isOpen;
    [self.detailBtn setImage:self.isOpen ? [UIImage imageNamed:@"zf_zk"] : [UIImage imageNamed:@"zf_sj"] forState:UIControlStateNormal];
}
- (IBAction)detailBtnClick:(id)sender {

    if (self.detailBtn) {
        self.detailBlock();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
