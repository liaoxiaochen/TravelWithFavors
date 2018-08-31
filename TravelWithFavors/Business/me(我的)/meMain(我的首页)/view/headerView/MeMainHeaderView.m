//
//  MeMainHeaderView.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/2.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "MeMainHeaderView.h"
#import "PersonalInfo.h"
#import "LoginController.h"
#import "LoginNavigationController.h"
@implementation MeMainHeaderView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.bgView.backgroundColor = [UIColor whiteColor];
  
    
    self.iconImageView.layer.cornerRadius = self.iconImageView.bounds.size.width/2;
    self.iconImageView.layer.masksToBounds = YES;
 
//    self.loginBtn.layer.cornerRadius = self.loginBtn.bounds.size.height/2;

    self.iconImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconTapAction:)];
    [self.iconImageView addGestureRecognizer:tap];
    
}

- (void)iconTapAction:(UITapGestureRecognizer *)tap {

    NSMutableArray *items = [[NSMutableArray alloc]init];
    LBPhotoWebItem *item = [[LBPhotoWebItem alloc]initWithURLString:_info.avatar frame:self.iconImageView.frame];
    [items addObject:item];
    
    [LBPhotoBrowserManager.defaultManager showImageWithWebItems:items selectedIndex:0 fromImageViewSuperView:self].lowGifMemory = YES;
 }

- (void)setInfo:(PersonalInfo *)info{
    _info = info;
    [AppConfig setUserIcon:info.avatar];

    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:info.avatar] placeholderImage:[UIImage imageNamed:@"me_toux"]];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(10, 15, 70, 70) cornerRadius:35];
    [path stroke];
    [path fill];
    
    self.nameLabel.text = [NSString nullString:info.user_nickname dispathString:@"懒人快去添加昵称"];
    self.jifenLabel.text = [NSString stringWithFormat:@"飞行积分： %@分",[NSString nullString:info.score dispathString:@"--"]];
    self.levelLabel.text = [NSString stringWithFormat:@"会员等级： %@级",[NSString nullString:info.grade dispathString:@"--"]];
}
- (IBAction)levelBtnClick:(id)sender {
    if (self.levelBlock) {
        self.levelBlock();
    }
}
- (IBAction)jifenBtnClick:(id)sender {
    if (self.jifenBlock) {
        self.jifenBlock();
    }
}
- (void)loginBtnClick:(UIButton *)sender {
    LoginController *vc = [[LoginController alloc] init];
    LoginNavigationController *nav = [[LoginNavigationController alloc] initWithRootViewController:vc];
    [[AppConfig currentViewController].navigationController presentViewController:nav animated:YES completion:nil];
}

@end
