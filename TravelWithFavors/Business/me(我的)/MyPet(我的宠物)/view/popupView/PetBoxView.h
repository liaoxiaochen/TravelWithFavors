//
//  PetBoxView.h
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/8.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PetBoxView : UIView
@property (weak, nonatomic) IBOutlet MyTextField *changTextField;
@property (weak, nonatomic) IBOutlet MyTextField *kuanTextField;
@property (weak, nonatomic) IBOutlet MyTextField *gaoTextField;
@property (nonatomic, copy) void (^boxBlock)(NSString *chang,NSString *kuan, NSString *gao);
- (void)showPetBoxView;
@end
