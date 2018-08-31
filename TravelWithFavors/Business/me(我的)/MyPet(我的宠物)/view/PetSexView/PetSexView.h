//
//  PetSexView.h
//  TravelWithFavors
//
//  Created by MacBook on 2018/7/30.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PetSexViewDelegate <NSObject>

- (void)PetSexdidSelected:(NSInteger)index;

@end

@interface PetSexView : UIView

@property (nonatomic, assign) id <PetSexViewDelegate> delegate;


- (void)showView;

- (void)hideView;

@end
