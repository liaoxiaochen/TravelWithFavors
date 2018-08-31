//
//  AddressViewController.m
//  TravelWithFavors
//
//  Created by MacBook on 2018/8/21.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "AddressViewController.h"
#import "AddressTableViewCell.h"
#import "AddAddressViewController.h"
#import "AddressInfoModel.h"
@interface AddressViewController () <AddressEditDelegate>

@property (nonatomic, strong) NSMutableArray *dataLists;

@end

@implementation AddressViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"收货地址";
    
    [self setupUI];
    
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(getData)];
    [header setImages:@[[UIImage imageNamed:@"mao"]] forState:MJRefreshStateIdle];
    self.tableView.mj_header = header;
    header.stateLabel.textColor = [UIColor hdPlaceHolderColor];
    header.lastUpdatedTimeLabel.hidden = YES;
    [self.tableView.mj_header beginRefreshing];
}
- (void)getData{
 
    NSString *url = [HttpNetRequestTool requestUrlString:@"/business/member/address/list"];
    [HttpNetRequestTool netRequestWithHeader:HttpNetRequestPost urlString:url paraments:nil success:^(id Json) {
        
        [self.tableView.mj_header endRefreshing];
        BaseModel *model = [BaseModel yy_modelWithJSON:Json];
         if (model.code == 1) {
            self.dataLists = [NSMutableArray arrayWithArray:[AddressInfoModel getAddressInfoList:model.data]];
            
            [self.tableView reloadData];
        }else{
            [HSToast hsShowBottomWithText:model.msg];
        }
    } failure:^(NSString *error) {
        
        [self.tableView.mj_header endRefreshing];
        [HSToast hsShowBottomWithText:error];
    }];

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AddressInfoModel *model = self.dataLists[indexPath.row];

    if (self.selectAdressBlock) {
        self.selectAdressBlock(model);
    }
    [self backPage];
    
}

- (void)backPage {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addNewAddress {
    AddAddressViewController *vc = [[AddAddressViewController alloc] init];
    vc.refreshBlock = ^{
        [self getData];
    };
     [self.navigationController pushViewController:vc animated:YES];
}

- (void)addressEditWithAddressId:(NSString *)addressId {
    NSString *url = [HttpNetRequestTool requestUrlString:@"/business/member/address/info"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [HttpNetRequestTool netRequestWithHeader:HttpNetRequestPost urlString:url paraments:@{@"id":addressId} success:^(id Json) {
        
        BaseModel *model = [BaseModel yy_modelWithJSON:Json];
         if (model.code == 1) {
            
            AddAddressViewController *vc = [[AddAddressViewController alloc] init];
             vc.infoModel = [AddressInfoModel yy_modelWithJSON:model.data];
             vc.refreshBlock = ^{
                 [self getData];
             };
            [self.navigationController pushViewController:vc animated:YES];
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } failure:^(NSString *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [HSToast hsShowBottomWithText:error];
    }];
}

- (void)deleteAddress:(NSInteger)index {
    
    AddressInfoModel *model = self.dataLists[index];

    NSString *url = [HttpNetRequestTool requestUrlString:@"/business/member/address/delete"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [HttpNetRequestTool netRequestWithHeader:HttpNetRequestPost urlString:url paraments:@{@"id":model.address_id} success:^(id Json) {
        
        BaseModel *model = [BaseModel yy_modelWithJSON:Json];
        if (model.code == 1) {
            [self.dataLists removeObjectAtIndex:index];
            [self.tableView reloadData];
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } failure:^(NSString *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [HSToast hsShowBottomWithText:error];
    }];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataLists.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddressTableViewCell"];
  
    cell.delegate = self;
    cell.addressModel = self.dataLists[indexPath.row];
    
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }

    return cell;
}
//先要设Cell可编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}
//定义编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}
//点击删除
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要删除吗？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       
        [self deleteAddress:indexPath.row];
        
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertVC addAction:action1];
    [alertVC addAction:cancelAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}
- (void)setupUI {
    [self.tableView registerNib:[UINib nibWithNibName:@"AddressTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"AddressTableViewCell"];
    [self setSepreStyle];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(0, 0, 40, 30);
    [addBtn setTitle:@"新增" forState:UIControlStateNormal];
    addBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [addBtn addTarget:self action:@selector(addNewAddress) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:addBtn];
}

- (void)setSepreStyle {
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
