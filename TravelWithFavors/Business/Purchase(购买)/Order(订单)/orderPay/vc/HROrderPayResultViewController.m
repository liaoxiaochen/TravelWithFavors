//
//  HROrderPayResultViewController.m
//  TravelWithFavors
//
//  Created by cushiro on 2018/4/11.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "HROrderPayResultViewController.h"
#import "HRmyOrderListViewController.h"
#import "PurchaseController.h"

@interface HROrderPayResultViewController ()
@property (weak, nonatomic) IBOutlet UIButton *jumpMainPageBtn;
@property (weak, nonatomic) IBOutlet UIButton *jumpOrderListBtn;
@property (weak, nonatomic) IBOutlet UIButton *repayBtn;

@end

@implementation HROrderPayResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.repayBtn.layer.cornerRadius = self.repayBtn.height/2;
    self.jumpOrderListBtn.layer.cornerRadius = self.jumpOrderListBtn.height/2;
    self.jumpMainPageBtn.layer.cornerRadius = self.jumpMainPageBtn.height/2;
    self.jumpMainPageBtn.layer.borderWidth = 1;
    self.jumpMainPageBtn.layer.borderColor = [UIColor colorWithHexString:@"#269D2E"].CGColor;
    
    if (self.result) {
        self.title = @"支付成功";
        self.tipsLB.text = @"支付成功";
        self.imageView.image = [UIImage imageNamed:@"ic_zf_cg"];
    }else{
        self.title = @"支付失败";
        self.tipsLB.text = @"支付失败";
        self.imageView.image = [UIImage imageNamed:@"ic_zf_sb"];
    }
    
}
- (IBAction)JumpMainPageBtnClick:(UIButton *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (IBAction)jumpOrderListBtnClick:(UIButton *)sender {
    if ([@"2" isEqualToString:self.jumpType]) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        NSArray *controllers = [AppConfig currentViewController].navigationController.viewControllers;
        NSMutableArray *tmpArray = [NSMutableArray array];
        if (controllers.count > 1) {
            for (UIViewController *vc in controllers) {
                if ([vc isKindOfClass:[PurchaseController class]]) {
                    [tmpArray addObject:vc];
                }
            }
            [AppConfig currentViewController].navigationController.viewControllers = tmpArray;
        }
        HRmyOrderListViewController *vc = [[HRmyOrderListViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [[AppConfig currentViewController].navigationController pushViewController:vc animated:YES];
    }
}
- (IBAction)repayBtnClick:(UIButton *)sender {
}

@end
