//
//  MyLevelController.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/8.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "MyLevelController.h"
#import "ExplainCell.h"
#import "MyLevelHeaderView.h"
static NSString *const cellID = @"ExplainCell";
@interface MyLevelController ()
@property (nonatomic, strong) MyLevelHeaderView *headerView;
@property (nonatomic, strong) NSArray *lists;
@end

@implementation MyLevelController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"会员等级";
    [self configView];
}
- (void)configView{
    self.headerView.frame = CGRectMake(0, 0, self.tableView.bounds.size.width, 116 + 121);
    self.headerView.level = self.level - 1;
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 50;
    [self.tableView registerNib:[UINib nibWithNibName:cellID bundle:nil] forCellReuseIdentifier:cellID];
    
    self.lists = @[self.content];
    //测试
//    self.headerView.level = 1;
}
#pragma mark --UITableViewDatasouce
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.lists.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ExplainCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.explain = self.lists[indexPath.row];
    return cell;
}
#pragma mark --load-
- (MyLevelHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[[NSBundle mainBundle] loadNibNamed:@"MyLevelHeaderView" owner:self options:nil] objectAtIndex:0];
    }
    return _headerView;
}
- (NSArray *)lists{
    if (!_lists) {
        _lists = @[@"携宠会员：等级说明。",@"黄金会员：等级说明。",@"白金会员：等级说明。",@"钻石会员：等级说明。"];
    }
    return _lists;
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
