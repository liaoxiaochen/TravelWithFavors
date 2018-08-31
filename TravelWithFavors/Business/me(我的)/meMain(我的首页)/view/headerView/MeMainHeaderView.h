//
//  MeMainHeaderView.h
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/2.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PersonalInfo;
@interface MeMainHeaderView : UIView
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *levelLabel;
@property (weak, nonatomic) IBOutlet UILabel *jifenLabel;

@property (nonatomic, strong) PersonalInfo *info;
@property (nonatomic, copy) void (^jifenBlock)(void);
@property (nonatomic, copy) void (^levelBlock)(void);
@end
