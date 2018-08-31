//
//  MyCertificatesCodeCell.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/7.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "MyCertificatesCodeCell.h"

@implementation MyCertificatesCodeCell

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.backgroundColor = [UIColor hdTableViewBackGoundColor];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    self.layer.cornerRadius = 5;
//    self.layer.masksToBounds = YES;
    
    self.certificatesBgView.size = CGSizeMake(SCREEN_WIDTH, 105);
    [UIView addShadowToView:self.certificatesBgView withOpacity:0.8 shadowRadius:2 andCornerRadius:5];

}
//- (void)setFrame:(CGRect)frame{
//    frame.origin.x += 10;
//    frame.size.width -= 20;
//    [super setFrame:frame];
//}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
