//
//  AddPersonCN_ENHeaderView.h
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/7.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddPersonCN_ENHeaderView : UIView
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UITextField *FirstTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (nonatomic, copy) void (^typeBlock)(void);
@end
