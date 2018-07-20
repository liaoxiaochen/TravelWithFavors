//
//  FlightInsuranceController.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/8.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "FlightInsuranceController.h"
#import "InsuranceCell.h"
@interface FlightInsuranceController ()
@property (nonatomic, strong) NSArray *dataLists;
@property (nonatomic, strong) UILabel *titleLB;


@end

@implementation FlightInsuranceController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"产品说明";
    [self configView];
}
- (void)configView{
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 70;
    UIView *header = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 56)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, header.bounds.size.width - 20, header.bounds.size.height)];
    label.text = @"航意险";
    label.textColor = [UIColor colorWithHexString:@"#333333"];
    label.font = [UIFont boldSystemFontOfSize:16.0f];
    self.titleLB = label;
    [header addSubview:label];
    self.tableView.tableHeaderView = header;
}
#pragma mark --UITableViewDatasouce
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *const cellID = @"InsuranceCell";
    InsuranceCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:cellID owner:self options:nil] objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
//    NSDictionary *dict = self.dataLists[indexPath.row];
//    cell.titleLabel.text = dict[@"title"];
//    cell.detail = dict[@"detail"];
    cell.titleLabel.text = @"";
    cell.detail = self.insuranceModel.i_remark;
    self.titleLB.text = self.insuranceModel.i_name;
    return cell;
}
#pragma mark --load--
- (NSArray *)dataLists{
    if (!_dataLists) {
        _dataLists = @[@{@"title":@"保险责任及保额",@"detail":@"保额最高320万元，被保险人实际搭乘合同的航班，自离港通 过安全检查时始，被保险人抵达述航班目的地，保险人依照保险合同约定给付保险金；"},@{@"title":@"保险费用",@"detail":@"30元每人，被保险人实际搭乘合同的航班，自离港通 过安全检查时始。"},@{@"title":@"合作机构",@"detail":@"合作机构合作机构合作机构合作机构"}];
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
