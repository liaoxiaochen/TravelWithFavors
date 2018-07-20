//
//  UserProtocolViewController.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/9.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "UserProtocolViewController.h"
#import "UserProtocolCell.h"
static NSString *const cellID = @"UserProtocolCell";
@interface UserProtocolViewController ()
@property (nonatomic, strong) NSArray *dataLists;
@property (nonatomic, strong) NSArray *titleLists;
@end

@implementation UserProtocolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.tableView.backgroundColor = [UIColor whiteColor];
//    self.navigationItem.title = @"用户协议";
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
//    self.tableView.estimatedRowHeight = 90;
}
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return self.dataLists.count;
//}
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    NSArray *lists = self.dataLists[section];
//    return lists.count;
//}
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UserProtocolCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
//    if (!cell) {
//        cell = [[[NSBundle mainBundle] loadNibNamed:cellID owner:self options:nil] objectAtIndex:0];
//    }
//    NSArray *lists = self.dataLists[indexPath.section];
//    cell.detail = lists[indexPath.row];
//    return cell;
//}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//
//}
- (NSArray *)dataLists{
    if (!_dataLists) {
        _dataLists = @[@[@"        1.重要须知：本服务条款是用户和携宠旅行之间的协议，本服务条款是用户和携宠旅行之间的协议，本服务条款是用户和携宠旅行之间的协议。本服务条款是用户和携宠旅行之间的协议。",@"        2.重要须知：本服务条款是用户和携宠旅行之间的协议，本服务条款是用户和携宠旅行之间的协议，本服务条款是用户和携宠旅行之间的协议。本服务条款是用户和携宠旅行之间的协议。"],@[@"        1.重要须知：本服务条款是用户和携宠旅行之间的协议，本服务条款是用户和携宠旅行之间的协议，本服务条款是用户和携宠旅行之间的协议。本服务条款是用户和携宠旅行之间的协议。"]];
    }
    return _dataLists;
}
- (NSArray *)titleLists{
    if (!_titleLists) {
        _titleLists = @[@"本服务条款是用户和携宠旅行之间的协议",@"用户使用规则"];
    }
    return _titleLists;
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
