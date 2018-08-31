//
//  MallOrderViewController.m
//  TravelWithFavors
//
//  Created by MacBook on 2018/8/23.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "MallOrderViewController.h"
#import "MallOrderAddressTableViewCell.h"
#import "MallOrderGoodsTableViewCell.h"
#import "MallOrderLabelTableViewCell.h"
#import "MallOrderSelectTableViewCell.h"
#import "MallRemarkTableViewCell.h"
#import "MallRemarkSectionHeader.h"
#import "MallOrderSelectView.h"
#import "MallOrderBottomView.h"
#import "AddressViewController.h"
#import "AddressInfoModel.h"
@interface MallOrderViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *payTipArr;
@property (nonatomic, strong) NSArray *logisticsTipArr;
@property (nonatomic, assign) PayWay payWay;
@property (nonatomic, assign) LogisticWay logisticsWay;
@property (nonatomic, strong) AddressInfoModel *addressModel;

@end

@implementation MallOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    [self initData];
    [self getDefaultAddress];
    
}

// 查找默认地址
- (void)getDefaultAddress {

    NSString *url = [HttpNetRequestTool requestUrlString:@"/business/member/address/default"];
    [HttpNetRequestTool netRequestWithHeader:HttpNetRequestPost urlString:url paraments:nil success:^(id Json) {

        BaseModel *model = [BaseModel yy_modelWithJSON:Json];
        if (model.code == 1) {
            self.addressModel = [AddressInfoModel yy_modelWithJSON:model.data];
            NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:0];
            [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    } failure:^(NSString *error) {

     }];

}

#pragma mark - Data
- (void)initData {
    self.payWay = 0;
    self.logisticsWay = 0;
    self.payTipArr = @[@[@"支付宝",@"zfbzf"], @[@"微信",@"weixzf"]];
    self.logisticsTipArr = @[@[@"顺丰",@"ddzf_sf"],@[@"邮政",@"ddzf_ems"]];
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        [self addressViewClick];
    } else if (indexPath.section == 3) {
        self.payWay = indexPath.row;
        [self tableViewReloadSection:indexPath.section];
    } else if (indexPath.section == 4) {
        self.logisticsWay = indexPath.row;
        [self tableViewReloadSection:indexPath.section];

    }
    
}
#pragma mark - 点击地址
- (void)addressViewClick {
    
    AddressViewController *vc = [[AddressViewController alloc] init];
    CZHWeakSelf(self);
    vc.selectAdressBlock = ^(AddressInfoModel *model) {
        weakself.addressModel = model;
        NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:0];
        [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    };
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        // 地址
        MallOrderAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MallOrderAddressTableViewCell" forIndexPath:indexPath];
        cell.addressModel = self.addressModel;
        return cell;
    }else if (indexPath.section == 1) {
        // 商品列表
        MallOrderGoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MallOrderGoodsTableViewCell" forIndexPath:indexPath];
        
        return cell;
    }else if (indexPath.section == 2) {
        // 支付金额
        MallOrderLabelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MallOrderLabelTableViewCell" forIndexPath:indexPath];
        cell.priceStr = @"￥678 (运费 ￥10)";
    
        return cell;
    }else if (indexPath.section == 3) {
        // 支付方式
        MallOrderSelectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MallOrderSelectTableViewCell" forIndexPath:indexPath];
        cell.itemSelect = (indexPath.row == self.payWay) ? YES : NO;
        cell.tipArr = self.payTipArr[indexPath.row];
        cell.orderSelectBlock = ^(NSInteger index) {
            self.payWay = index;
            [self tableViewReloadSection:indexPath.section];
        };
        return cell;
    }else if (indexPath.section == 4) {
        // 物流
        MallOrderSelectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MallOrderSelectTableViewCell" forIndexPath:indexPath];
        cell.itemSelect = (indexPath.row == self.logisticsWay) ? YES : NO;
        cell.tipArr = self.logisticsTipArr[indexPath.row];
        cell.orderSelectBlock = ^(NSInteger index) {
            self.logisticsWay = index;
            [self tableViewReloadSection:indexPath.section];
        };

        return cell;
    }else {
        // 备注
        MallRemarkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MallRemarkTableViewCell" forIndexPath:indexPath];
        
        return cell;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        MallRemarkSectionHeader *headerV = [[MallRemarkSectionHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        return headerV;
    }else if (section == 3) {
        MallOrderSelectView *view = [[MallOrderSelectView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        view.headerStr = @"支付方式";
        if (self.payWay + 1 <= self.payTipArr.count) {
            view.selectArr = self.payTipArr[self.payWay];
        }
        return view;
    }else if (section == 4) {
        MallOrderSelectView *view = [[MallOrderSelectView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        view.headerStr = @"物流";
        if (self.logisticsWay + 1 <= self.logisticsTipArr.count) {
            view.selectArr = self.logisticsTipArr[self.logisticsWay];
        }
        return view;
    }
    UIView *v = [UIView new];
    v.backgroundColor = [UIColor hdTableViewBackGoundColor];
    return v;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *v = [UIView new];
    v.backgroundColor = [UIColor hdTableViewBackGoundColor];
    return v;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0:
            return 60;
            break;
        case 1:
            return 100;
            break;
            
        default:
            return 44;
            break;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 10;
    }else if (section == 1 || section == 3 || section == 4) {
        return 40;
    }
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 2) {
        return 0.01;
    }
    return 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 3 || section == 4) {
        return 2;
    }
    return 1;
}

- (void)tableViewReloadSection:(NSInteger)section {
    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:section];
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}
#pragma mark - UI
- (void)setupUI {
    self.title = @"订单支付";
    self.tableView.frame = CGRectMake(0, [AppConfig getNavigationBarHeight], SCREEN_WIDTH, SCREENH_HEIGHT - 50 - [AppConfig getNavigationBarHeight]);
    [self setSepreStyle];
    
    [self.tableView registerClass:[MallOrderLabelTableViewCell class] forCellReuseIdentifier:@"MallOrderLabelTableViewCell"];
    [self.tableView registerClass:[MallOrderSelectTableViewCell class] forCellReuseIdentifier:@"MallOrderSelectTableViewCell"];
    [self.tableView registerClass:[MallRemarkTableViewCell class] forCellReuseIdentifier:@"MallRemarkTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MallOrderAddressTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MallOrderAddressTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MallOrderGoodsTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MallOrderGoodsTableViewCell"];
    
    MallOrderBottomView *bottom = [[MallOrderBottomView alloc] initWithFrame:CGRectMake(0, SCREENH_HEIGHT - 50, SCREEN_WIDTH, 50)];
    [self.view addSubview:bottom];
}

- (void)setSepreStyle {
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor = [UIColor hdSepreViewColor];
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
        
    }
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
