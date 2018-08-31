//
//  UIButton+ImageTitle.m
//  TravelWithFavors
//
//  Created by MacBook on 2018/8/10.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "UIButton+ImageTitle.h"

@implementation UIButton (ImageTitle)

//将按钮设置为图片在上，文字在下
+ (void)initButton:(UIButton*)btn spacing:(CGFloat)spacing{
    //图片和文字的上下间距 spacing
    btn.adjustsImageWhenHighlighted = NO;
    CGSize imageSize = btn.imageView.frame.size;
    CGSize titleSize = btn.titleLabel.frame.size;
    CGSize textSize = [btn.titleLabel.text sizeWithAttributes:@{NSFontAttributeName : btn.titleLabel.font}];
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    if (titleSize.width + 0.5 < frameSize.width) {
        titleSize.width = frameSize.width;
    }
    CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);
    btn.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (totalHeight - titleSize.height), 0);
    
}
//将按钮设置为图片在右，文字在左
- (void)initButtonTitleLeftImageRight{
    //图片和文字的上下间距 spacing
    self.adjustsImageWhenHighlighted = NO;

    self.titleEdgeInsets = UIEdgeInsetsMake(0, -self.imageView.frame.size.width - self.frame.size.width + self.titleLabel.frame.size.width, 0, 0);
    self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -self.titleLabel.frame.size.width - self.frame.size.width + self.imageView.frame.size.width);
}


@end
