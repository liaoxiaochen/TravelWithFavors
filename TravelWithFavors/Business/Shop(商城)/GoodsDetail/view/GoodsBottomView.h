//
//  GoodsBottomView.h
//  TravelWithFavors
//
//  Created by MacBook on 2018/8/16.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GoodsBottomView;

typedef void (^BottomBtnClickBlock)(GoodsBottomView *bottomView, NSInteger index);


@interface GoodsBottomView : UIView

// 1是全选  2是结算
@property (nonatomic, copy) BottomBtnClickBlock bottomBlock;


@end
