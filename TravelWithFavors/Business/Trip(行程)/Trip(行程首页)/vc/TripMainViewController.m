//
//  TripMainViewController.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/6.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "TripMainViewController.h"
#import "TripTableViewBgview.h"
#import "TripMainCell.h"
#import "TripInfoController.h"
#import "HRorderModel.h"
#import "OrderDetailInfoController.h"
static NSString *const cellID = @"TripMainCell";
@interface TripMainViewController ()

@property (nonatomic,strong) NSMutableArray* dataSource;
@property (nonatomic , strong) NSMutableDictionary * dict;
@property (nonatomic , assign) NSInteger pageNumber;
@end

@implementation TripMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的行程";
    [self confiView];
    
    self.tableView.frame = CGRectMake(0, [AppConfig getNavigationBarHeight], SCREEN_WIDTH, SCREENH_HEIGHT - [AppConfig getNavigationBarHeight]);
    
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
    
}
- (void)confiView{
//    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT)];
//    bgImageView.image = [UIImage imageNamed:@"bj"];
//    bgImageView.contentMode = UIViewContentModeScaleAspectFill;
//    bgImageView.userInteractionEnabled = NO;
//    [self.view addSubview:bgImageView];
    self.tableView.backgroundColor = [UIColor hdTableViewBackGoundColor];
    [self.view bringSubviewToFront:self.tableView];
    self.tableView.enablePlaceHolderView = YES;
    TripTableViewBgview *bgView = [[TripTableViewBgview alloc] initWithFrame:self.tableView.bounds];
    __block typeof(self) weakSelf = self;
    bgView.shopBlock = ^{
        weakSelf.tabBarController.selectedIndex = 0;
    };
    self.tableView.rowHeight = 250;
    self.tableView.yh_PlaceHolderView = bgView;
    [self.tableView registerNib:[UINib nibWithNibName:@"TripMainCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellID];
}
#pragma mark - UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TripMainCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.dataSource.count > 0) {
        cell.orderModel = [self.dataSource objectAtIndex:indexPath.section];
    }
    return cell;
}
#pragma mark --UITableViewDelegate
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    NSString *url = [HttpNetRequestTool requestUrlString:@"/user/order/detail"];
//    HRorderModel *model = self.dataSource[indexPath.section];
//    NSDictionary *dict = @{@"order_id":model.pid};
//    [HttpNetRequestTool netRequest:HttpNetRequestPost urlString:url outTime:20 paraments:dict isHeader:YES success:^(id Json) {
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
//        BaseModel *model = [BaseModel yy_modelWithJSON:Json];
//        if (model.code == 1) {
//            HRorderModel *orderModel = [HRorderModel yy_modelWithJSON:model.data];
//            TripInfoController *vc = [[TripInfoController alloc] init];
//            vc.isPet = [@"2" isEqualToString: orderModel.user_type] ? YES : NO;
//            vc.orderModel = orderModel;
//            vc.title = orderModel.flight_number;
//            vc.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:vc animated:YES];
//        }else{
//            [HSToast hsShowBottomWithText:model.msg];
//        }
//    } failure:^(NSString *error) {
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
//        [HSToast hsShowBottomWithText:error];
//    }];
//}
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
@end
