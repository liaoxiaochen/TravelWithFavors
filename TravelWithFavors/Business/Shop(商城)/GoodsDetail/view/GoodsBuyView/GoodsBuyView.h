//
//  KJBuyView.h
//  Shopping
//
//  Created by apple on 2018/7/30.
//  Copyright © 2018年 CoderYS. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GoodsBuyViewDelegate <NSObject>

- (void)hideBuyView;

@end

@interface GoodsBuyView : UIView

// index 是加入购物车还是立即购买
- (void)showInView:(UIView *)view transformView:(UIView *)transformView index:(NSInteger)index;

@property (nonatomic, assign) id<GoodsBuyViewDelegate>delegate;

@end
