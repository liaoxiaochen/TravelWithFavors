//
//  DefaultView.m
//  PlaceHolderView
//
//  Created by yh on 17/5/16.
//  Copyright © 2017年 yh. All rights reserved.
//

#import "DefaultView.h"

@implementation DefaultView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width - 165)/2, (frame.size.height - 140 - 40)/2, 165, 140)];
        imageView.image = [UIImage imageNamed:@"tableViewPloder"];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
//        imageView.center = self.center;
        [self addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame), frame.size.width, 40)];
        label.textColor = [UIColor colorWithHexString:@"#DECBCB"];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"暂无数据";
        [self addSubview:label];
    }
    return self;
}

@end
