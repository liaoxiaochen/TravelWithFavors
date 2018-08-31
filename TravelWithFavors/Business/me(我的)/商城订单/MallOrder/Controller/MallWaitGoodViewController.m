//
//  MallWaitGoodViewController.m
//  TravelWithFavors
//
//  Created by MacBook on 2018/8/24.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "MallWaitGoodViewController.h"
#import "MallOrderStatus.h"
#import "MallOrderGoodsTableViewCell.h"
#import "MallOrderDetailViewController.h"

@interface MallWaitGoodViewController ()

@end

@implementation MallWaitGoodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.rowHeight = 100;
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    [self.tableView registerNib:[UINib nibWithNibName:@"MallOrderGoodsTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MallOrderGoodsTableViewCell"];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MallOrderDetailViewController *vc = [[MallOrderDetailViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)setVcFrame:(CGRect)vcFrame {
    self.tableView.frame = vcFrame;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MallOrderGoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MallOrderGoodsTableViewCell"];
    cell.showNumLabel = YES;
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    MallOrderStatus *view = [[MallOrderStatus alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
    return view;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor hdTableViewBackGoundColor];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 80;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
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
