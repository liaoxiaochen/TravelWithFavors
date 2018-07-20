//
//  RulePopupView.h
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/7.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RulePopupView : UIView
@property (nonatomic, strong) UILabel *headerLabel;
@property (nonatomic, strong) NSArray *dataLists;
- (void)showPopupView;
@end
