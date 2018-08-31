//
//  OrderChangePopupView.h
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/7.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderChangePopupView : UIView

@property (nonatomic, strong) NSString *headerText;
@property (nonatomic, strong) NSArray *dataLists;

- (void)showPopupView;
@end
