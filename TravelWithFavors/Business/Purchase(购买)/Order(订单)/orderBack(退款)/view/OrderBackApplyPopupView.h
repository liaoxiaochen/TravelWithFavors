//
//  OrderBackApplyPopupView.h
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/7.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderBackApplyPopupView : UIView
@property (nonatomic, copy) void (^applyBlock)(void);
@end
