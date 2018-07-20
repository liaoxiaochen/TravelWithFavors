//
//  OrderPetAddPopupView.h
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/7.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderPetAddPopupView : UIView
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *petImageView;
@property (weak, nonatomic) IBOutlet MyTextField *nameTextField;
@property (weak, nonatomic) IBOutlet UISwitch *choseSwitch;

- (void)showOrderPetAddPopupView;
@end
