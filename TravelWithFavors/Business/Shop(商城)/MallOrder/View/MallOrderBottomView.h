//
//  MallOrderBottomView.h
//  TravelWithFavors
//
//  Created by MacBook on 2018/8/23.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MallOrderBottomView;

typedef void (^MallOrderBottomBtnClickBlock)(MallOrderBottomView *bottomView, NSInteger index);
@interface MallOrderBottomView : UIView

@property (nonatomic, copy) MallOrderBottomBtnClickBlock mallOrderbottomBlock;

@end
