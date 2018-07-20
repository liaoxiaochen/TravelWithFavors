//
//  MyIntegralController.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/8.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "MyIntegralController.h"
#import "ExplainCell.h"
#import "MyIntegralHeaderView.h"
static NSString *const cellID = @"ExplainCell";
@interface MyIntegralController ()
@property (nonatomic, strong) MyIntegralHeaderView *headerView;
@property (nonatomic, strong) NSArray *lists;
@end

@implementation MyIntegralController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"飞行积分";
    [self configView];
}
- (void)configView{
    self.headerView.frame = CGRectMake(0, 0, self.tableView.bounds.size.width, 106);
    self.headerView.scoreLabel.text = self.score;
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 50;
    [self.tableView registerNib:[UINib nibWithNibName:cellID bundle:nil] forCellReuseIdentifier:cellID];
    self.lists = @[self.content];
    //测试
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
- (MyIntegralHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[[NSBundle mainBundle] loadNibNamed:@"MyIntegralHeaderView" owner:self options:nil] objectAtIndex:0];
    }
    return _headerView;
}
- (NSArray *)lists{
    if (!_lists) {
        _lists = @[@"积分说明。",@"积分说明。",@"积分说明。"];
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
