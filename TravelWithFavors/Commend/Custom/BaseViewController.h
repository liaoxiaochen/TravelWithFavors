//
//  BaseViewController.h
//  TravelWithFavors
//
//  Created by MacBook on 2018/8/16.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property (nonatomic, strong) UIView *navigationView;
@property (nonatomic, strong) UIView *navigationBgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;


- (void)setTitle:(NSString *)title;
- (void)showLeftBackButton;


@end
