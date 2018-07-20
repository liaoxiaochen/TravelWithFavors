//
//  HDNavigationController.m
//  HugeDiscountApp
//
//  Created by 江雅芹 on 2017/11/17.
//  Copyright © 2017年 江雅芹. All rights reserved.
//

#import "HDNavigationController.h"

@interface HDNavigationController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@end

@implementation HDNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont systemFontOfSize:17.0f]}];
    //隐藏横线
    [self.navigationBar setShadowImage:[UIImage new]];
    [self.navigationBar lt_setBackgroundColor:[UIColor hdMainColor]];
//    self.navigationBar.backgroundColor = [UIColor hdMainColor];
  
}
- (UIImageView *)getNavigationLineViewInNavigationBar:(UIView *)view
{
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self getNavigationLineViewInNavigationBar:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}
#pragma mark - UINavigationControllerDelegate
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    self.interactivePopGestureRecognizer.delegate = self;
    if (self.viewControllers.count!=0)
    {
        viewController.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"xc_daohan_fanhui"] style:0 target:self action:@selector(back)];
        viewController.navigationItem.leftBarButtonItem.imageInsets = UIEdgeInsetsMake(0, -5, 0, 0);
    }
    [super pushViewController:viewController animated:YES];
    
}
-(void)back
{
//    if([self.viewControllers count] < [self.navigationBar.items count]) {
        [self popViewControllerAnimated:YES];
//    }
//    BOOL shouldPop = YES;
//    UIViewController* vc = [self topViewController];
//    if([vc respondsToSelector:@selector(navigationShouldPopOnBackButton)]) {
//        shouldPop = [vc navigationShouldPopOnBackButton];
//    }
//    if(shouldPop) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self popViewControllerAnimated:YES];
//        });
//    } else {
//        for(UIView *subview in [self.navigationBar subviews]) {
//            if(0. < subview.alpha && subview.alpha < 1.) {
//                [UIView animateWithDuration:.25 animations:^{
//                    subview.alpha = 1.;
//                }];
//            }
//        }
//    }
}
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = YES;
    }
}
//使navigationcontroller中第一个控制器不响应右滑pop手势
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if ([self.childViewControllers count] == 1) {
        return NO;
    }
    return YES;
}
//解决多个手势冲突 同时接受多个手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}
//解决在手指滑动时候,被pop的viewController中的UIscrollView会跟着一起滚动
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return [gestureRecognizer isKindOfClass:UIScreenEdgePanGestureRecognizer.class];
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
