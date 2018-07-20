//
//  OrderBackApplyController.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/7.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "OrderBackApplyController.h"
#import "OrderBackApplyView.h"

@interface OrderBackApplyController ()
@property (nonatomic, strong) OrderBackApplyView *footerView;
@end

@implementation OrderBackApplyController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    self.view.userInteractionEnabled = YES;
    
    [self.view addSubview:self.footerView];
   
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point=[[touches anyObject] locationInView:self.view];
    point = [self.footerView.layer convertPoint:point fromLayer:self.view.layer];
    if (![self.footerView.layer containsPoint:point]) {
        [self dismiss];
    }
}
- (void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (OrderBackApplyView *)footerView{
    if (!_footerView) {
        _footerView = [[[NSBundle mainBundle] loadNibNamed:@"OrderBackApplyView" owner:self options:nil] objectAtIndex:0];
        _footerView.frame = CGRectMake(0, SCREENH_HEIGHT - [AppConfig getButtomHeight] - 326, SCREEN_WIDTH, 316);
    }
    return _footerView;
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
