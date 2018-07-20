//
//  ShareCustomView.h
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/3.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ShareCustomViewDelegate <NSObject>
@optional
//0 微信 1 朋友圈 2 QQ 3 微博
- (void)shareSelected:(NSInteger)index;
@end
@interface ShareCustomView : UIView
@property (nonatomic, assign) id <ShareCustomViewDelegate> delegate;
- (void)showShareCustomView;
@end
