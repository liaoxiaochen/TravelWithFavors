//
//  HRmyOrderListViewController.m
//  TravelWithFavors
//
//  Created by cushiro on 2018/4/11.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "HRmyOrderListViewController.h"
#import "HRmyOrderListTableViewCell.h"
#import "HRorderModel.h"

#import "OrderDetailInfoController.h"

static NSString *const cellID = @"HRmyOrderListTableViewCell";
@interface HRmyOrderListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView* tableView;
@property (nonatomic,strong) NSMutableArray* dataSource;
@property (nonatomic , strong) NSMutableDictionary * dict;
@property (nonatomic , assign) NSInteger pageNumber;
/** 标记刷新 */
@property (nonatomic,assign) BOOL updateFlag;
@end

@implementation HRmyOrderListViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的订单";
    
    [self initTableView];
    
    WeakObj(self)
    BlockObj(_pageNumber)
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        block_pageNumber = 1;
        [weakself.dict setObject:@"1" forKey:@"page"];
        [weakself getDataSourceWithParams:weakself.dict];
        
    }];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        block_pageNumber ++;
        [weakself.dict setObject:@(block_pageNumber) forKey:@"page"];
        [weakself getDataSourceWithParams:weakself.dict];
    }];
//    [footer setAutomaticallyHidden:YES];
    self.tableView.mj_footer = footer;
    
    [self.tableView.mj_header beginRefreshing];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateDataSource) name:@"orderDetailPage" object:nil];
}

-(void)updateDataSource{
    [self.tableView.mj_header beginRefreshing];
}

-(void)getDataSourceWithParams:(NSMutableDictionary *)dict{
    WeakObj(self)
    NSString *url = [HttpNetRequestTool requestUrlString:@"/user/order/index"];
    HRLog(@"请求参数======%@",dict);
    [HttpNetRequestTool netRequestWithHeader:HttpNetRequestPost urlString:url paraments:dict success:^(id Json) {
        [weakself.tableView.mj_header endRefreshing];
        [weakself.tableView.mj_footer endRefreshing];
        BaseModel *model = [BaseModel yy_modelWithJSON:Json];
        HRLog(@"返回数据======%@",Json);
        if (model.code == 1) {
            NSArray *tempArray = [NSArray yy_modelArrayWithClass:[HRorderModel class] json:model.data];
            if (tempArray.count <= 0) {
                [weakself.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            if (!tempArray.count && !weakself.dataSource.count) {
                weakself.tableView.mj_footer.hidden = YES;
            } else {
                weakself.tableView.mj_footer.hidden = NO;
            }
            if ([[weakself.dict objectForKey:@"page"] integerValue] == 1) {
                [weakself.dataSource removeAllObjects];
            }
            [weakself.dataSource addObjectsFromArray:tempArray];
            if (weakself.dataSource.count > 0) {
                weakself.tableView.backgroundView = nil;
            }
            [weakself.tableView reloadData];
        }else{
            [HSToast hsShowBottomWithText:model.msg];
            if (weakself.pageNumber > 1) {
                weakself.pageNumber--;
            }
        }
    } failure:^(NSString *error) {
        [weakself.tableView.mj_header endRefreshing];
        [weakself.tableView.mj_footer endRefreshing];
        [HSToast hsShowBottomWithText:error];
        if (weakself.pageNumber > 1) {
            weakself.pageNumber--;
        }
    }];
}
- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (NSMutableDictionary *)dict
{
    if (!_dict) {
        _dict = [NSMutableDictionary dictionary];
    }
    return _dict;
}
-(void)initTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [AppConfig getNavigationBarHeight], SCREEN_WIDTH, SCREENH_HEIGHT - [AppConfig getNavigationBarHeight]) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor hdTableViewBackGoundColor];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
//    self.tableView.tableFooterView = [UIView new];
//    self.tableView.tableHeaderView = [UIView new];
    self.tableView.rowHeight = 127;
    self.tableView.estimatedRowHeight = 127;
    //    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.tableView.estimatedSectionFooterHeight = 0;
        self.tableView.estimatedSectionHeaderHeight = 0;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HRmyOrderListTableViewCell class]) bundle:nil] forCellReuseIdentifier:cellID];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HRmyOrderListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.dataSource.count > 0) {
        cell.orderModel = [self.dataSource objectAtIndex:indexPath.section];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *url = [HttpNetRequestTool requestUrlString:@"/user/order/detail"];
    HRorderModel *model = self.dataSource[indexPath.section];
    NSDictionary *dict = @{@"order_id":model.pid};
    [HttpNetRequestTool netRequest:HttpNetRequestPost urlString:url outTime:20 paraments:dict isHeader:YES success:^(id Json) {
        HRLog(@"%@",Json)
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        BaseModel *model = [BaseModel yy_modelWithJSON:Json];
        if (model.code == 1) {
            HRorderModel *orderModel = [HRorderModel getOrderInfo:model.data];
            OrderDetailInfoController *vc = [[OrderDetailInfoController alloc] init];
            vc.isPet = [@"2" isEqualToString: orderModel.user_type] ? YES : NO;
            vc.orderModel = orderModel;
            vc.start_city_name = orderModel.start_city_name;
            vc.to_city_name = orderModel.to_city_name;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            [HSToast hsShowBottomWithText:model.msg];
        }
    } failure:^(NSString *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [HSToast hsShowBottomWithText:error];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        if (@available(iOS 11.0, *)) {
            return 0;
        }
        return 0.01;
    }
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (@available(iOS 11.0, *)) {
        return 0;
    }
    
    return 0.01;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat sectionHeaderHeight = 5;//设置你footer高度
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
    
}


-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
