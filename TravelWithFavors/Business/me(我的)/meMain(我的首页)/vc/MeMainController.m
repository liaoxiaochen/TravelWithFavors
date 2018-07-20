//
//  MeMainController.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/2.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "MeMainController.h"
#import "MeMainCell.h"
#import "MeMainHeaderView.h"
#import "PersonalInfoController.h"//个人信息
#import "MeSetController.h"
#import "OpinionController.h"//意见反馈
#import "MyPetListsController.h"//我的宠物
#import "MyCertificatesController.h"//我的证件
#import "MyLevelController.h"//我的等级
#import "MyIntegralController.h"//我的积分
#import "LoginNavigationController.h"
#import "LoginController.h"
#import "PersonalInfo.h"

#import "HRmyOrderListViewController.h"

static NSString *const cellID = @"MeMainCell";
@interface MeMainController ()
@property (nonatomic, strong) MeMainHeaderView *headerView;
@property (nonatomic, strong) NSArray *dataLists;
@property (nonatomic, strong) PersonalInfo *userInfo;
@end

@implementation MeMainController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (![AppConfig getLoginState]) {
        self.headerView.loginBtn.hidden = NO;
        self.headerView.iconImageView.hidden = YES;
    }else{
        self.headerView.loginBtn.hidden = YES;
        self.headerView.iconImageView.hidden = NO;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.frame = CGRectMake(0, [AppConfig getNavigationBarHeight], SCREEN_WIDTH, SCREENH_HEIGHT - [AppConfig getTabBarHeight] - [AppConfig getNavigationBarHeight]);
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.rowHeight = 44;
    self.tableView.tableHeaderView = self.headerView;

    if ([AppConfig getUserIcon]) {
        UIImage *image = [[[SDWebImageManager sharedManager] imageCache] imageFromDiskCacheForKey:[NSURL URLWithString:[AppConfig getUserIcon]].absoluteString];
        if (image) {
            _headerView.iconImageView.image = image;
        }
    }
    
    __block typeof(self) weakSelf = self;
    self.headerView.jifenBlock = ^{
        //积分
        [weakSelf myIntegralVC];
    };
    self.headerView.levelBlock = ^{
      //等级
        [weakSelf myLevelVC];
    };
    if ([AppConfig getLoginState]) {
        [self getInfo];
    }
    //登录成功
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSeccess) name:@"loginSeccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logout) name:@"logout" object:nil];
}
- (void)myLevelVC{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *url = [HttpNetRequestTool requestUrlString:@"/user/index/grade"];
    NSDictionary *dict = [NSDictionary dictionary];
    [HttpNetRequestTool netRequest:HttpNetRequestPost urlString:url outTime:20 paraments:dict isHeader:YES success:^(id Json) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        BaseModel *model = [BaseModel yy_modelWithJSON:Json];
        if (model.code == 1) {
            
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            NSString *url = [HttpNetRequestTool requestUrlString:@"/user/index/text"];
            NSDictionary *dict2 = @{@"type":@"1"};
            [HttpNetRequestTool netRequest:HttpNetRequestPost urlString:url outTime:20 paraments:dict2 isHeader:YES success:^(id Json) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                BaseModel *model2 = [BaseModel yy_modelWithJSON:Json];
                if (model2.code == 1) {
                    MyLevelController *vc = [[MyLevelController alloc] init];
                    vc.level = [self.userInfo.grade integerValue];
                    vc.content = model2.data?:@"";
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }else{
                    [HSToast hsShowBottomWithText:model2.msg];
                }
            } failure:^(NSString *error) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [HSToast hsShowBottomWithText:error];
            }];
  
//            MyLevelController *vc = [[MyLevelController alloc] init];
//            vc.level = [self.userInfo.grade integerValue];
//            vc.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:vc animated:YES];
        }else{
            [HSToast hsShowBottomWithText:model.msg];
        }
    } failure:^(NSString *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [HSToast hsShowBottomWithText:error];
    }];

}
- (void)myIntegralVC{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *url = [HttpNetRequestTool requestUrlString:@"/user/index/score"];
    NSDictionary *dict = [NSDictionary dictionary];
    [HttpNetRequestTool netRequest:HttpNetRequestPost urlString:url outTime:20 paraments:dict isHeader:YES success:^(id Json) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        BaseModel *model = [BaseModel yy_modelWithJSON:Json];
        if (model.code == 1) {
            
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            NSString *url2 = [HttpNetRequestTool requestUrlString:@"/user/index/text"];
            NSDictionary *dict2 = @{@"type":@"2"};
            [HttpNetRequestTool netRequest:HttpNetRequestPost urlString:url2 outTime:20 paraments:dict2 isHeader:YES success:^(id Json) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                BaseModel *model2 = [BaseModel yy_modelWithJSON:Json];
                if (model2.code == 1) {
                    MyIntegralController *vc = [[MyIntegralController alloc] init];
                    vc.score = [NSString nullString:self.userInfo.score dispathString:@""];
                    vc.content = model2.data?:@"";
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }else{
                    [HSToast hsShowBottomWithText:model.msg];
                }
            } failure:^(NSString *error) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [HSToast hsShowBottomWithText:error];
            }];
          
//            MyIntegralController *vc = [[MyIntegralController alloc] init];
//            vc.score = [NSString nullString:self.userInfo.score dispathString:@""];
//            vc.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:vc animated:YES];
        }else{
            [HSToast hsShowBottomWithText:model.msg];
        }
    } failure:^(NSString *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [HSToast hsShowBottomWithText:error];
    }];
}
#pragma mark --data
- (void)logout{
    self.userInfo = nil;
    self.headerView.info = self.userInfo;
}
- (void)loginSeccess{
    [self getInfo];
}
- (void)getInfo{
    //我的信息
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *url = [HttpNetRequestTool requestUrlString:@"/user"];
    [HttpNetRequestTool netRequestWithHeader:HttpNetRequestPost urlString:url paraments:nil success:^(id Json) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        BaseModel *model = [BaseModel yy_modelWithJSON:Json];
        self.userInfo = [PersonalInfo yy_modelWithJSON:model.data];
        if (model.code == 1) {
            self.userInfo = [PersonalInfo yy_modelWithJSON:model.data];
            self.headerView.info = self.userInfo;
        }else{
            [HSToast hsShowBottomWithText:model.msg];
        }
    } failure:^(NSString *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [HSToast hsShowBottomWithText:error];
    }];
}
//积分
- (void)getIntegralData{
    
}
//等级
- (void)getLevelData{
    
}
#pragma mark --UITableViewDataSouce
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataLists.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MeMainCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:cellID owner:self options:nil] objectAtIndex:0];
    }
    NSDictionary *dict = self.dataLists[indexPath.row];
    cell.dict = dict;
    return cell;
}
#pragma mark --UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([AppConfig getLoginState]) {
        switch (indexPath.row) {
            case 0:
            {
                //个人资料
                PersonalInfoController *vc = [[PersonalInfoController alloc] init];
                __weak typeof(self) weakSelf = self;
                vc.loginOutBlock = ^{
                  //退出登录
                    LoginController *vc = [[LoginController alloc] init];
                    LoginNavigationController *nav = [[LoginNavigationController alloc] initWithRootViewController:vc];
                    [weakSelf.navigationController presentViewController:nav animated:YES completion:nil];
                    weakSelf.userInfo = nil;
                    weakSelf.headerView.info = weakSelf.userInfo;
                };
                vc.userInfoBlock = ^(PersonalInfo *info) {
                    weakSelf.userInfo = info;
                    weakSelf.headerView.info = info;
                };
                vc.userInfo = self.userInfo;
                //vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 1:{
                //我的订单
                HRmyOrderListViewController *vc = [[HRmyOrderListViewController alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 2:{
                //我的宠物
                MyPetListsController *vc = [[MyPetListsController alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 3:{
                //我的证件
                MyCertificatesController *vc = [[MyCertificatesController alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 4:{
                MeSetController *vc = [[MeSetController alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            default:{
                //意见反馈
                OpinionController *vc = [[OpinionController alloc] init];
                vc.phone = [NSString nullString:self.userInfo.mobile dispathString:[AppConfig getUserName]];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
        }
    }else{
        //登录
        LoginController *vc = [[LoginController alloc] init];
        LoginNavigationController *nav = [[LoginNavigationController alloc] initWithRootViewController:vc];
        [self.navigationController presentViewController:nav animated:YES completion:nil];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y <= 0) {
        scrollView.contentOffset = CGPointZero;
    }
}
#pragma mark --load--
- (MeMainHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[[NSBundle mainBundle] loadNibNamed:@"MeMainHeaderView" owner:self options:nil] objectAtIndex:0];
        _headerView.backgroundColor = [UIColor whiteColor];
        _headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 156);
    }
    return _headerView;
}
- (NSArray *)dataLists{
    if (!_dataLists) {
        _dataLists = @[@{@"title":@"个人资料",@"image":@"me_grzl"},@{@"title":@"我的订单",@"image":@"me_dingdan"},@{@"title":@"我的宠物",@"image":@"me_chongwu"},@{@"title":@"我的证件",@"image":@"me_zj"},@{@"title":@"设置",@"image":@"me_sz"},@{@"title":@"意见反馈",@"image":@"me_yjfk"}];
    }
    return _dataLists;
}
#pragma mark --other
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
