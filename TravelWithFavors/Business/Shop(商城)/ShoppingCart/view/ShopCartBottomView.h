//
//  ShopCartBottomView.h
//  TravelWithFavors
//
//  Created by MacBook on 2018/8/22.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ShopCartBottomView;

typedef void (^ShopCartBottomBtnClickBlock)(NSInteger index,BOOL isClick);

@interface ShopCartBottomView : UIView

@property (nonatomic, copy) ShopCartBottomBtnClickBlock shopCartbottomBlock;
@property (nonatomic, strong) UIButton *checkAllBtn;


@end
