//
//  UIView+ViewTouch.m
//  GeorgeLi
//
//  Created by Lanan on 2018/1/18.
//  Copyright © 2018年 Lanan. All rights reserved.
//

#import "UIView+ViewTouch.h"
#import <objc/runtime.h>

@implementation UIView (ViewTouch)

- (void)addTapGestureRecognizer:(blockHadParameterAndNoReturn)click {
    self.userInteractionEnabled = YES;
    //创建手势对象
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    objc_setAssociatedObject(tap, @"click", click, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    //配置属性
    //轻拍次数
    tap.numberOfTapsRequired = 1;
    //轻拍手指个数
    tap.numberOfTouchesRequired = 1;
    //讲手势添加到指定的视图上
    [self addGestureRecognizer:tap];
}

- (void)tapAction:(UITapGestureRecognizer *)sender {
    blockHadParameterAndNoReturn click = objc_getAssociatedObject(sender, @"click");
    if (click) {
        click(sender);
    }
}

@end
