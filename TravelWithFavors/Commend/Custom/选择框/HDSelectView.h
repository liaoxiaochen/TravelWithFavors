//
//  HDSelectView.h
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/2.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HDSelectView;
@protocol HDSelectViewDelegate <NSObject>
- (void)selectView:(HDSelectView *)view didSelected:(NSInteger)index;
@end
@interface HDSelectView : UIView
@property (nonatomic, assign) id <HDSelectViewDelegate> delegate;
@property (nonatomic, strong) NSArray *colorLists;
@property (nonatomic, assign) BOOL isAutoDismiss;
@property (nonatomic, assign) NSInteger selectedRow;
- (void)showSelectView:(NSArray *)dataLists;
- (void)hide;
@end
