//
//  HDTabBarController.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/2.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "HDTabBarController.h"
#import "HDNavigationController.h"
#import "PurchaseController.h"
//#import "TripMainController.h"
#import "TripMainViewController.h"
#import "ServiceMainController.h"
#import "MeMainController.h"
@interface HDTabBarController ()

@end

@implementation HDTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    PurchaseController *purchaseVC = [[PurchaseController alloc] init];
    [self addChildViewController:purchaseVC title:@"机票购买" imageName:@"purchase_aircraftgray" selectedImageName:@"purchase_aircraft"];
    
    TripMainViewController *tripVC = [[TripMainViewController alloc] init];
    [self addChildViewController:tripVC title:@"行程" imageName:@"purchase_walletgray" selectedImageName:@"purchase_wallet"];
    
    ServiceMainController *serviceVC = [[ServiceMainController alloc] init];
    [self addChildViewController:serviceVC title:@"服务" imageName:@"purchase_heartgray" selectedImageName:@"purchase_heart"];
    
    MeMainController *meVC = [[MeMainController alloc] init];
    [self addChildViewController:meVC title:@"我的" imageName:@"purchase_peoplegray" selectedImageName:@"purchase_people"];
    
    [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0, -2)];
    [self.tabBar setBackgroundImage:[UIImage new]];
    [self.tabBar setShadowImage:[UIImage new]];
    
    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
    
    
    
}
- (void)addChildViewController:(UIViewController *)childViewController title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName{
    UITabBarItem *item = [[UITabBarItem alloc] init];
    [item setTitle:title];
    [item setImage:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [item setSelectedImage:[[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor hdYellowColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:10.0]}
                        forState:UIControlStateSelected];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#4B5578"],NSFontAttributeName:[UIFont boldSystemFontOfSize:10.0F]} forState:UIControlStateNormal];
    HDNavigationController *nav = [[HDNavigationController alloc] initWithRootViewController:childViewController];
    nav.tabBarItem = item;
    [self addChildViewController:nav];
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
