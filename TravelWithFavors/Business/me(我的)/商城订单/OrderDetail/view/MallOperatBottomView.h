//
//  MallOperatBottomView.h
//  TravelWithFavors
//
//  Created by MacBook on 2018/8/25.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MallOperatBottomView;

typedef void (^BottomBtnClickBlock)(MallOperatBottomView *bottomView);

@interface MallOperatBottomView : UIView


 @property (nonatomic, copy) BottomBtnClickBlock bottomBlock;



@end
