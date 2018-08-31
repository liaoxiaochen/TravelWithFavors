//
//  MallOrderListViewController.m
//  TravelWithFavors
//
//  Created by MacBook on 2018/8/24.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "MallOrderListViewController.h"
#import "MallAllOrderViewController.h"
#import "MallWaitGoodViewController.h"
#import "MallCompleteViewController.h"
#import "MallReturnGoodViewController.h"

#define BUTTONHEIGHT 40

@interface MallOrderListViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView; /**< 容器视图控制器*/
@property (nonatomic, strong) UIView *scroll; /**<选择下面的小条*/
@property (nonatomic, assign) CGRect rect;  /**<小条的大小*/
@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) UIView *greenView;

@end

@implementation MallOrderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"商城订单";
    self.titleArr = @[@"全部订单", @"待收货", @"已完成", @"退换货"];
    [self createNavItem];
    [self.view addSubview:self.scrollView];
    [self createContainer];

}

#pragma mark - 点击button，改变字体和偏移量
- (void)buttonActionScroll:(UIButton *)button {
    
    UIButton *currentButton = [_scroll viewWithTag:button.tag];
    [currentButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    for (NSInteger i = 0; i < 4; i++) {
        UIButton *oldButton = [_scroll viewWithTag:2500 + i];
        if (oldButton.tag != button.tag) {
            [oldButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        }
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        self.greenView.frame = CGRectMake(SCREEN_WIDTH / 4 * (button.tag - 2500), _scroll.frame.size.height - 2, SCREEN_WIDTH / 4, 2);
    }];
    
    _scrollView.contentOffset = CGPointMake(SCREEN_WIDTH * (button.tag - 2500), 0);
    
}

#pragma mark - 滑动collection,改变button的位置
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    UIButton *currentButton = [_scroll viewWithTag:_scrollView.contentOffset.x / SCREEN_WIDTH + 2500];
    for (NSInteger i = 0; i < 4; i++) {
        UIButton *oldButton = [_scroll viewWithTag:2500 + i];
        if (oldButton.tag != currentButton.tag) {
            [oldButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        }
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        
        self.greenView.frame = CGRectMake(SCREEN_WIDTH / 4 * (_scrollView.contentOffset.x / SCREEN_WIDTH), _scroll.frame.size.height - 2, SCREEN_WIDTH / 4, 2);
    }];
    
    // 获取到当前的button，并改变字体
    [currentButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

}
#pragma mark - 创建导航栏下面一条
- (void)createNavItem {
    
    self.view.backgroundColor = [UIColor hdTableViewBackGoundColor];
    
    self.scroll = [[UIView alloc] initWithFrame:CGRectMake(0, [AppConfig getNavigationBarHeight], SCREEN_WIDTH, BUTTONHEIGHT)];
    _scroll.backgroundColor = [UIColor hdMainColor];
    [self.view addSubview:_scroll];
    
    self.greenView = [[UIView alloc] initWithFrame:CGRectMake(0, _scroll.frame.size.height - 2, SCREEN_WIDTH / 4, 2)];
    self.greenView.backgroundColor = [UIColor whiteColor];
    [_scroll addSubview:_greenView];
    
    for (NSInteger i = 0; i < 4; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(SCREEN_WIDTH / 4 * i, 0, SCREEN_WIDTH / 4, BUTTONHEIGHT - 2);
        [button addTarget:self action:@selector(buttonActionScroll:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 2500 + i;
        [button setTitle:self.titleArr[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [_scroll addSubview:button];
        if (i == 0) {
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
    }
}

#pragma mark - 容器视图控制器
- (void)createContainer {

    MallAllOrderViewController *allVC = [[MallAllOrderViewController alloc] init];
    allVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetHeight(self.scrollView.frame));
    allVC.vcFrame = CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetHeight(self.scrollView.frame));
    [_scrollView addSubview:allVC.view];
    [self addChildViewController:allVC];
    
    MallWaitGoodViewController *waitVC = [[MallWaitGoodViewController alloc] init];
    waitVC.view.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT - BUTTONHEIGHT - [AppConfig getNavigationBarHeight]);
    waitVC.vcFrame = CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetHeight(self.scrollView.frame));
    [_scrollView addSubview:waitVC.view];
    [self addChildViewController:waitVC];
    
    MallCompleteViewController *completeVC = [[MallCompleteViewController alloc] init];
    completeVC.view.frame = CGRectMake(SCREEN_WIDTH * 2, 0, SCREEN_WIDTH, SCREEN_HEIGHT - BUTTONHEIGHT - [AppConfig getNavigationBarHeight]);
    completeVC.vcFrame = CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetHeight(self.scrollView.frame));
    [_scrollView addSubview:completeVC.view];
    [self addChildViewController:completeVC];
    
    MallReturnGoodViewController *returnVC = [[MallReturnGoodViewController alloc] init];
    returnVC.view.frame = CGRectMake(SCREEN_WIDTH * 3, 0, SCREEN_WIDTH, SCREEN_HEIGHT - BUTTONHEIGHT - [AppConfig getNavigationBarHeight]);
    returnVC.vcFrame = CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetHeight(self.scrollView.frame));
    [_scrollView addSubview:returnVC.view];
    [self addChildViewController:returnVC];
    
}
#pragma mark - scrollView
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.scroll.frame), SCREEN_WIDTH, SCREEN_HEIGHT - CGRectGetMaxY(self.scroll.frame))];
        _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 4, SCREEN_HEIGHT - CGRectGetMaxY(self.scroll.frame));
        _scrollView.bounces = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
    }
    return _scrollView;
}
- (void)buttonBackContain:(UIButton *)button {
    
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
