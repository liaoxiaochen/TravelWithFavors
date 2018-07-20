//
//  GuideViewController.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/9.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "GuideViewController.h"
#import "HDTabBarController.h"
@interface GuideViewController ()

@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImageView *bgview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT)];
    bgview.image = [UIImage imageNamed:@"yfbj"];
    [self.view addSubview:bgview];
    
    UIButton *starttBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    starttBtn.frame = CGRectMake((SCREEN_WIDTH - 100)/2, SCREENH_HEIGHT - (80 * SCREENH_HEIGHT / 667) - 30, 100, 30);
    starttBtn.adjustsImageWhenHighlighted = NO;
    starttBtn.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    [starttBtn setTitle:@"马上去看看" forState:UIControlStateNormal];
    starttBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [starttBtn addTarget:self action:@selector(startClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:starttBtn];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 280 * SCREENH_HEIGHT/667.0, SCREEN_WIDTH - 20, 20)];
    label.text = @"你和世界只隔着一张机票";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:18.0f];
    [self.view addSubview:label];
}
- (void)startClick{
    [self mainVC];
}
- (void)mainVC{
    HDTabBarController *tabbarVC = [[HDTabBarController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = tabbarVC;
    [[UIApplication sharedApplication].keyWindow makeKeyAndVisible];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
