//
//  HDDateSelctedView.h
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/4.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HDDateSelctedView : UIView
@property (nonatomic, copy) NSString *birth;
@property (nonatomic, copy) void (^birthBlocl)(NSString *year, NSString *month, NSString *day);
- (void)showHDDateSelctedView;
@end
