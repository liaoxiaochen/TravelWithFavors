//
//  MallOrderDetailViewController.m
//  TravelWithFavors
//
//  Created by MacBook on 2018/8/25.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "MallOrderDetailViewController.h"
#import "MallOrderOperationTableViewCell.h"
#import "MallOrderGoodsTableViewCell.h"
#import "MallRemarkSectionHeader.h"
#import "MallOrderLabelInfoTableViewCell.h"
#import "MallOperatBottomView.h"
#import "ApplyAftersaleViewController.h"

@interface MallOrderDetailViewController ()
@property (nonatomic, strong) NSArray *tipArr;
@property (nonatomic, strong) NSArray *tipContentArr;

@property (nonatomic, strong) NSArray *priceTipArr;

@end

@implementation MallOrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self setupUI];
    self.title = @"订单详情";
    
}

- (void)initData {
    self.tipArr = @[@"订单状态：", @"订单编号：", @"下单时间：", @"支付方式：", @"支付时间：", @"配送方式：", @"承运人电话："];
    self.tipContentArr = @[@"已发货", @"8743423434", @"2018年08月28日 16:19", @"支付宝", @"2018年08月28日 16:19", @"顺丰", @"18833332324"];

    self.priceTipArr = @[@"商品总额：", @"运费："];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        MallOrderOperationTableViewCell *detailCell = [tableView dequeueReusableCellWithIdentifier:@"MallOrderOperationTableViewCell"];
        detailCell.leftLabel.text = self.tipArr[indexPath.row];
        detailCell.rightLabel.text = self.tipContentArr[indexPath.row];
        if (indexPath.row == 0) {
            detailCell.showCancelBtn = YES;
        }else {
            detailCell.showCancelBtn = NO;
        }
        if (indexPath.row == 1) {
            detailCell.showCopyBtn = YES;
        }else {
            detailCell.showCopyBtn = NO;
        }
        return detailCell;
    }else if (indexPath.section == 1) {
        
        MallOrderGoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MallOrderGoodsTableViewCell"];
        cell.showNumLabel = YES;
        
        return cell;
    }else {
        MallOrderLabelInfoTableViewCell *detailCell = [tableView dequeueReusableCellWithIdentifier:@"MallOrderLabelInfoTableViewCell"];
        detailCell.leftLabel.text = self.priceTipArr[indexPath.row];
        detailCell.rightLabel.text = @"￥567";

        return detailCell;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        UIView *headV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 41)];
        headV.backgroundColor = [UIColor hdSepreViewColor];
        MallRemarkSectionHeader *view = [[MallRemarkSectionHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        [headV addSubview:view];
        return headV;
    }
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor hdTableViewBackGoundColor];
    return view;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor hdTableViewBackGoundColor];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        return 100;
    }
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 50;
        }
    }
    return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 41;
    }
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.tipArr.count;
    }else if (section == 1) {
        return 2;
    }
    return self.priceTipArr.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (void)setupUI {
    self.tableView.frame = CGRectMake(0, [AppConfig getNavigationBarHeight], SCREEN_WIDTH, self.view.frame.size.height - 44 - [AppConfig getNavigationBarHeight]);
    [self.tableView registerClass:[MallOrderOperationTableViewCell class] forCellReuseIdentifier:@"MallOrderOperationTableViewCell"];
    [self.tableView registerClass:[MallOrderLabelInfoTableViewCell class] forCellReuseIdentifier:@"MallOrderLabelInfoTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MallOrderGoodsTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MallOrderGoodsTableViewCell"];
    
    MallOperatBottomView *bottomView = [[MallOperatBottomView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 44 , SCREEN_WIDTH, 44)];
    [bottomView setBottomBlock:^(MallOperatBottomView *bottomView) {

        ApplyAftersaleViewController *vc = [[ApplyAftersaleViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }];
    [self.view addSubview:bottomView];
    
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
