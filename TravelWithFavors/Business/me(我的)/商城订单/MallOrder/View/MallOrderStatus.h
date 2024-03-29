//
//  MallOrderStatus.h
//  TravelWithFavors
//
//  Created by MacBook on 2018/8/24.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MallOrderStatusDelegate<NSObject>

- (void)orderStatusChangeBtnAction:(UIButton *)sender;

@end

@interface MallOrderStatus : UIView

@property (nonatomic, assign) id<MallOrderStatusDelegate>delegate;

@end
