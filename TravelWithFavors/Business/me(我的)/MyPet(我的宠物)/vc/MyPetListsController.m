//
//  MyPetListsController.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/8.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "MyPetListsController.h"
#import "MyPetListsCell.h"
#import "MyPetController.h"
#import "MyPetInfo.h"
static NSString *const cellID = @"MyPetListsCell";
@interface MyPetListsController ()
@property (nonatomic, strong) NSMutableArray *dataLists;
@end

@implementation MyPetListsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"宠物信息";
    self.tableView.backgroundColor = [UIColor hdTableViewBackGoundColor];
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    self.tableView.tableHeaderView = header;
    self.tableView.rowHeight = 76;
    
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 220)];
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake((footer.bounds.size.width - 150)/2, footer.bounds.size.height - 42, 150, 40);
    addBtn.adjustsImageWhenHighlighted = NO;
    addBtn.backgroundColor = [UIColor hdYellowColor];
    addBtn.layer.cornerRadius = 3;
    [addBtn setImage:[UIImage imageNamed:@"zjck"] forState:UIControlStateNormal];
    [addBtn setTitle:@"新增宠物信息" forState:UIControlStateNormal];
    addBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    //左文右图
//    // 还可增设间距
//    CGFloat spacing = 10.0;
//    // 图片右移
//    CGSize imageSize = addBtn.imageView.frame.size;
//    addBtn.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width * 2 - spacing, 0.0, 0.0);
//
//    // 文字左移
//    CGSize titleSize = addBtn.titleLabel.frame.size;
//    addBtn.imageEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, - titleSize.width * 2 - spacing);
    //左图右文
    CGFloat spacing = 5.0;//(是间距的一半)
    addBtn.imageEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, spacing);
    addBtn.titleEdgeInsets = UIEdgeInsetsMake(0.0, spacing, 0.0, 0.0);
    [addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:addBtn];
    self.tableView.tableFooterView = footer;
    
    self.tableView.enablePlaceHolderView = YES;
    TableViewNoneDataView *bgView = [[TableViewNoneDataView alloc] initWithFrame:self.tableView.bounds];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.titileLabel.text = @"您还未添加宠物信息";
    self.tableView.yh_PlaceHolderView = bgView;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getPetInfo)];
    [self.tableView.mj_header beginRefreshing];
}
- (void)addBtnClick{
    MyPetController *vc = [[MyPetController alloc] init];
    __weak typeof(self) weakSelf = self;
    vc.refreshPet = ^{
        [weakSelf getPetInfo];
    };
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark --data
- (void)getPetInfo{
    NSString *url = [HttpNetRequestTool requestUrlString:@"/user/pet"];
    __weak typeof(self) weakSelf = self;
    [HttpNetRequestTool netRequestWithHeader:HttpNetRequestPost urlString:url paraments:nil success:^(id Json) {
        [self.tableView.mj_header endRefreshing];
        BaseModel *model = [BaseModel yy_modelWithJSON:Json];
        if (model.code == 1) {
            weakSelf.dataLists = [NSMutableArray arrayWithArray:[MyPetInfo getMyPetInfoLists:model.data]];
            [weakSelf.tableView reloadData];
            if (weakSelf.dataLists.count > 0) {
                weakSelf.tableView.backgroundView = nil;
            }
        }else{
            [HSToast hsShowBottomWithText:model.msg];
        }
    } failure:^(NSString *error) {
        [self.tableView.mj_header endRefreshing];
        [HSToast hsShowBottomWithText:error];
    }];
}
#pragma mark --UITableViewDatasouce
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataLists.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyPetListsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:cellID owner:self options:nil] objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.info = self.dataLists[indexPath.section];
    return cell;
}
#pragma mark --UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MyPetController *vc = [[MyPetController alloc] init];
    vc.petInfo = self.dataLists[indexPath.section];
    __weak typeof(self) weakSelf = self;
    vc.refreshPet = ^{
        [weakSelf getPetInfo];
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
//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return UITableViewCellEditingStyleDelete;
//}
//点击删除
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要删除吗？" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            MyPetInfo *info = self.dataLists[indexPath.section];
            //在这里实现删除操作
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            NSString *url = [HttpNetRequestTool requestUrlString:@"/user/pet/delete"];
            NSDictionary *dict = @{@"pet_id":info.id};
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
