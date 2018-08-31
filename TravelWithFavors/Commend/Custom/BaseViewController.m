//
//  BaseViewController.m
//  TravelWithFavors
//
//  Created by MacBook on 2018/8/16.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.hidesBottomBarWhenPushed = YES;
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor hdTableViewBackGoundColor];
    
    [self setNavView];
}
- (void)setNavView
{
    _navigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [AppConfig getNavigationBarHeight])];
    _navigationView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_navigationView];
    
    _navigationBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,  [AppConfig getNavigationBarHeight])];
    _navigationBgView.backgroundColor = [UIColor clearColor];
    [_navigationView addSubview:_navigationBgView];
}

- (void)setTitle:(NSString *)title
{
    [_navigationView addSubview:self.titleLabel];
    _titleLabel.text = title;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_navigationView.mj_w/2 - 50, _navigationView.mj_h - 30, 100, 20)];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = [UIColor darkGrayColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _titleLabel;
}

- (void)showLeftBackButton
{
    _leftButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _leftButton.frame = CGRectMake(15, [AppConfig getStatusBarHeight] + 5, 45, 35);
    [_leftButton setImage:[UIImage imageNamed:@"daohan_fanhui"] forState:(UIControlStateNormal)];
    [_leftButton addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
    [_navigationView addSubview:_leftButton];
}


#pragma mark - action

- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
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
