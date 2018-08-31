//
//  MyCertificatesController.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/7.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "MyCertificatesController.h"
#import "MyCertificatesCell.h"//正常
#import "MyCertificatesCardCell.h"//护照
#import "MyCertificatesCodeCell.h"//身份证
#import "AddPersonController.h"
#import "CertificatesInfo.h"
@interface MyCertificatesController ()
@property (nonatomic, strong) NSMutableArray *dataLists;
@end

@implementation MyCertificatesController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configView];
}
- (void)configView{
    self.navigationItem.title = @"我的证件";
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 10)];
    self.tableView.tableHeaderView = view;
    
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 200)];
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake((footer.bounds.size.width - 150)/2, footer.bounds.size.height - 100, 150, 40);
    addBtn.adjustsImageWhenHighlighted = NO;
    addBtn.backgroundColor = [UIColor hdMainColor];
    [addBtn setTitle:@"新增常用旅客" forState:UIControlStateNormal];
    [addBtn setImage:[UIImage imageNamed:@"zjck"] forState:UIControlStateNormal];
    addBtn.layer.cornerRadius = 20;
    // 还可增设间距
    CGFloat spacing = 5.0;
    // 图片右移
//    CGSize imageSize = addBtn.imageView.frame.size;
    addBtn.titleEdgeInsets = UIEdgeInsetsMake(0.0, spacing, 0.0, 0.0);
    // 文字左移
//    CGSize titleSize = addBtn.titleLabel.frame.size;
    addBtn.imageEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0,  spacing);
    
    [addBtn addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:addBtn];
    self.tableView.tableFooterView = footer;
    self.tableView.enablePlaceHolderView = YES;
    TableViewNoneDataView *bgView = [[TableViewNoneDataView alloc] initWithFrame:self.tableView.bounds];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.titileLabel.text = @"您还未添加证件信息";
    self.tableView.yh_PlaceHolderView = bgView;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getData)];
    [self.tableView.mj_header beginRefreshing];
}
//新增
- (void)addClick{
    AddPersonController *vc = [[AddPersonController alloc] init];
    vc.refreshBlock = ^{
        [self refreshDatainfo];
    };
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)refreshDatainfo{
    NSString *url = [HttpNetRequestTool requestUrlString:@"/user/paper"];
    __weak typeof(self) weakSelf = self;
    [HttpNetRequestTool netRequestWithHeader:HttpNetRequestPost urlString:url paraments:nil success:^(id Json) {
        BaseModel *model = [BaseModel yy_modelWithJSON:Json];
        if (model.code == 1) {
            weakSelf.dataLists = [NSMutableArray arrayWithArray:[CertificatesInfo getCertificatesInfoLists:model.data]];
            [weakSelf.tableView reloadData];
            if (weakSelf.dataLists.count > 0) {
                weakSelf.tableView.backgroundView = nil;
            }
        }else{
            [HSToast hsShowBottomWithText:model.msg];
        }
        
    } failure:^(NSString *error) {
        [HSToast hsShowBottomWithText:error];
    }];
}
- (void)getData{
    NSString *url = [HttpNetRequestTool requestUrlString:@"/user/paper"];
    [HttpNetRequestTool netRequestWithHeader:HttpNetRequestPost urlString:url paraments:nil success:^(id Json) {
        [self.tableView.mj_header endRefreshing];
        BaseModel *model = [BaseModel yy_modelWithJSON:Json];
        if (model.code == 1) {
            self.dataLists = [NSMutableArray arrayWithArray:[CertificatesInfo getCertificatesInfoLists:model.data]];
            [self.tableView reloadData];
            if (self.dataLists.count > 0) {
                self.tableView.backgroundView = nil;
            }
        }else{
            [HSToast hsShowBottomWithText:model.msg];
        }
        
    } failure:^(NSString *error) {
        [self.tableView.mj_header endRefreshing];
        [HSToast hsShowBottomWithText:error];
    }];
}
#pragma mark --UITbaleViewDatasouce
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataLists.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CertificatesInfo *info = self.dataLists[indexPath.section];
    //    if ([info.card_type isEqualToString:@"1"]) {
    //身份证
    static NSString *const codeCellID = @"MyCertificatesCodeCell";
    MyCertificatesCodeCell *cell = [tableView dequeueReusableCellWithIdentifier:codeCellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:codeCellID owner:self options:nil] objectAtIndex:0];
    }
    
    if ([info.card_type isEqualToString:@"1"]) {
        cell.cardLabel.text = [NSString stringWithFormat:@"身份证：%@",info.card_no];
        cell.nameLabel.text = info.id_card_name;
    }
    if ([info.card_type isEqualToString:@"2"]) {
        cell.cardLabel.text = [NSString stringWithFormat:@"护  照  ：%@",info.card_no];
        cell.nameLabel.text = [NSString stringWithFormat:@"%@%@",info.surname,info.given_name];
    }
    if ([info.card_type isEqualToString:@"3"]) {
        cell.cardLabel.text = [NSString stringWithFormat:@"通行证：%@",info.card_no];
        cell.nameLabel.text = [NSString stringWithFormat:@"%@%@",info.surname,info.given_name];
    }
    if ([info.card_type isEqualToString:@"4"]) {
        cell.cardLabel.text = [NSString stringWithFormat:@"台胞证：%@",info.card_no];
        cell.nameLabel.text = [NSString stringWithFormat:@"%@%@",info.surname,info.given_name];
    }
    NSString *sex;
    if (info.sex == 0) {
        sex = @"男";
    }else {
        sex = @"女";
    }
    cell.sexAndBirthdayLabel.text = [NSString stringWithFormat:@"性别：%@      生日：%@", sex, info.birthday];

    return cell;

    
}
#pragma mark --UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.section == 0) {
//        return 108;
//    }
//    if (indexPath.section == 1) {
//        return 108;
//    }
    return 105;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CertificatesInfo *info = self.dataLists[indexPath.section];
    AddPersonController *vc = [[AddPersonController alloc] init];
    vc.p_id = info.id;
    vc.refreshBlock = ^{
        [self refreshDatainfo];
    };
    [self.navigationController pushViewController:vc animated:YES];
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
        CertificatesInfo *info = self.dataLists[indexPath.section];
        //在这里实现删除操作
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSString *url = [HttpNetRequestTool requestUrlString:@"/user/paper/delete"];
        NSDictionary *dict = @{@"p_id":info.id};
        [HttpNetRequestTool netRequestWithHeader:HttpNetRequestPost urlString:url paraments:dict success:^(id Json) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            BaseModel *model = [BaseModel yy_modelWithJSON:Json];
            if (model.code == 1) {
                [self.dataLists removeObject:info];
                NSIndexSet *set = [NSIndexSet indexSetWithIndex:indexPath.section];
                [tableView deleteSections:set withRowAnimation:UITableViewRowAnimationAutomatic];
            }else{
                [HSToast hsShowBottomWithText:model.msg];
                tableView.editing = NO;
            }
        } failure:^(NSString *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [HSToast hsShowBottomWithText:error];
            tableView.editing = NO;
        }];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVC addAction:action1];
    [alertVC addAction:cancelAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}
- (NSMutableArray *)dataLists{
    if (!_dataLists) {
        _dataLists = [[NSMutableArray alloc] init];
    }
    return _dataLists;
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
