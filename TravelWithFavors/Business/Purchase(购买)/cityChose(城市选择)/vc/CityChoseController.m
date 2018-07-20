//
//  CityChoseController.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/14.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "CityChoseController.h"
#import "ChineseCityController.h"
#import "InternationalCityController.h"
#import "CityInfo.h"

@interface CityChoseController ()

@end

@implementation CityChoseController
- (instancetype)init{
    self = [super init];
    if (self) {
        self.titles = @[@"国内城市",@"国际城市"];
        self.viewControllerClasses = @[@"ChineseCityController",@"InternationalCityController"];
        self.titleSizeNormal = 14.0f;
        self.titleSizeSelected = 14.0f;
        self.titleColorNormal = [UIColor whiteColor];
        self.titleColorSelected = [UIColor colorWithHexString:@"#333333"];
        self.menuViewStyle = WMMenuViewStyleSegmented;
        self.progressColor = [UIColor whiteColor];
//        self.progressWidth = SCREEN_WIDTH/2;
        self.menuView.backgroundColor = [UIColor blackColor];
        self.menuViewContentMargin = 0;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"城市选择";
}
- (__kindof UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index{
    if (index == 0) {
        ChineseCityController *vc = [[ChineseCityController alloc] init];
        __weak typeof(self) weakSelf = self;
        vc.cityChose = ^(CityInfo *info) {
            if (weakSelf.cityBlock) {
                weakSelf.cityBlock(info);
            }
        };
        return vc;
    }
    return [[InternationalCityController alloc] init];
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index{
    return self.titles[index];
}
- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView{
    return CGRectMake(0, [AppConfig getNavigationBarHeight], SCREEN_WIDTH, 40);
}
- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView{
    return CGRectMake(0, [AppConfig getNavigationBarHeight] + 40, SCREEN_WIDTH, SCREENH_HEIGHT - [AppConfig getNavigationBarHeight] - 40 - [AppConfig getButtomHeight]);
}

- (void)dealloc{
    debugLog(@"一簇了");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
