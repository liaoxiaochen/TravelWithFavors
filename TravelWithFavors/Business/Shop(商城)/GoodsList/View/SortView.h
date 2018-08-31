//
//  SortView.h
//  TravelWithFavors
//
//  Created by MacBook on 2018/8/13.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol SortViewDelegate <NSObject>

- (void)sortBtnClick:(NSInteger)index;

@end

@interface SortView : UIView

@property (nonatomic, assign) id <SortViewDelegate> delegate;

@end
