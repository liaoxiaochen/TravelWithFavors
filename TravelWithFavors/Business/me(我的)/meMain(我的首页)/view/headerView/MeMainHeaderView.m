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
    self.bgView.backgroundColor = [UIColor hdMainColor];
    self.iconImageView.layer.cornerRadius = self.iconImageView.bounds.size.width/2;
    self.iconImageView.layer.masksToBounds = YES;
    
    self.loginBtn.layer.cornerRadius = self.loginBtn.bounds.size.height/2;
}
- (void)setInfo:(PersonalInfo *)info{
    _info = info;
    [AppConfig setUserIcon:info.avatar];
//    [[SDWebImageManager sharedManager] diskImageExistsForURL:[NSURL URLWithString:info.avatar] completion:^(BOOL isInCache) {
//        if (isInCache) {
//            UIImage *image = [[[SDWebImageManager sharedManager] imageCache] imageFromDiskCacheForKey:[NSURL URLWithString:info.avatar].absoluteString];
//            self.iconImageView.image = image;
//        }else{
//            [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:info.avatar] placeholderImage:[UIImage imageNamed:@"me_toux"]];
//        }
//    }];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:info.avatar] placeholderImage:[UIImage imageNamed:@"me_toux"]];
    self.nameLabel.text = [NSString nullString:info.user_nickname dispathString:@""];
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
- (IBAction)loginBtnClick:(UIButton *)sender {
    LoginController *vc = [[LoginController alloc] init];
    LoginNavigationController *nav = [[LoginNavigationController alloc] initWithRootViewController:vc];
    [[AppConfig currentViewController].navigationController presentViewController:nav animated:YES completion:nil];
}

@end
