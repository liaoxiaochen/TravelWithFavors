//
//  ApplyDescribeView.h
//  TravelWithFavors
//
//  Created by MacBook on 2018/8/25.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PYPhotosView.h"

@protocol AppleDescribeViewDelegate<NSObject>

- (void)describeViewGetPhoto;

@end

@interface ApplyDescribeView : UIView

@property (nonatomic, assign) id<AppleDescribeViewDelegate>delegate;

@property (nonatomic, weak) PYPhotosView *publishPhotosView;//属性 保存选择的图片

@end
