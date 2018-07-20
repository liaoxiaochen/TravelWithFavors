//
//  FlightSearchJourneyController.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/6.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "FlightSearchJourneyController.h"
#import "FlightSearchJourneyHeaderView.h"
#import "FlightSearchJourneyCell.h"
#import "FlightSearchJourneyDetailController.h"
#import "FlightSearchInfo.h"
#import "CityInfo.h"
#import "RMCalendarModel.h"
static NSString *const cellID = @"FlightSearchJourneyCell";
@interface FlightSearchJourneyController ()
@property (nonatomic, strong) FlightSearchJourneyHeaderView *headerView;
@property (nonatomic, strong) NSArray *dataLists;
@end

@implementation FlightSearchJourneyController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor hdMainColor]];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor hdMainColor];
    [self setCustomNavigationTitleView];
    [self configView];
}
- (void)setCustomNavigationTitleView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [AppConfig getNavigationBarHeight])];
    view.backgroundColor = [UIColor hdMainColor];
    
    UIView *bgview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, view.bounds.size.width, view.bounds.size.height)];
    
    UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    leftLabel.text = self.startCity.city_name;
    leftLabel.textColor = [UIColor whiteColor];
    [leftLabel sizeToFit];
    
    UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    rightLabel.text = self.endCity.city_name;
    rightLabel.textColor = [UIColor whiteColor];
    [rightLabel sizeToFit];
    
    CGFloat bgW = leftLabel.bounds.size.width + rightLabel.bounds.size.width + 18 + 14;
    bgview.frame = CGRectMake((view.bounds.size.width - bgW)/2, [AppConfig getStatusBarHeight], bgW, [AppConfig getNavigationBarHeight] - [AppConfig getStatusBarHeight]);
    [view addSubview:bgview];
    
    leftLabel.frame = CGRectMake(0, 0, leftLabel.bounds.size.width, bgview.bounds.size.height);
    [bgview addSubview:leftLabel];
    
    UIImageView *flight = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ss_wf"]];
    flight.frame = CGRectMake(CGRectGetMaxX(leftLabel.frame) + 7, (bgview.bounds.size.height - 18)/2, 18, 18);
    [bgview addSubview:flight];
    
    rightLabel.frame = CGRectMake(bgview.bounds.size.width - rightLabel.bounds.size.width, 0, rightLabel.bounds.size.width, bgview.bounds.size.height);
    [bgview addSubview:rightLabel];
    
    [self.view addSubview:view];
}
- (void)configView{
    self.tableView.rowHeight = 131;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.headerView.leftLabel.text = [NSString stringWithFormat:@"%lu月%lu日 %@",self.startTime.month,self.startTime.day,self.startTime.getWeek];
    self.headerView.rightLabel.text = [NSString stringWithFormat:@"%lu月%lu日 %@",self.endTime.month,self.endTime.day,self.endTime.getWeek];
    //计算天数
    NSString *star = [NSDate getDate:[NSString stringWithFormat:@"%lu-%lu-%lu",self.startTime.year,self.startTime.month,self.startTime.day] formart:@"yyyy-MM-dd"];
    NSString *end = [NSDate getDate:[NSString stringWithFormat:@"%lu-%lu-%lu",self.endTime.year,self.endTime.month,self.endTime.day] formart:@"yyyy-MM-dd"];
    long long spa = [end longLongValue] - [star longLongValue];
    NSInteger dy = spa/(3600 * 24);
    self.headerView.dayLabel.text = [NSString stringWithFormat:@"%ld天",dy];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getData)];
    [self.tableView.mj_header beginRefreshing];
}
- (void)getData{
    //    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *url = [HttpNetRequestTool requestUrlString:@"/ticket/flight"];
    NSString *startTime = [NSString stringWithFormat:@"%.2lu-%.2lu-%.2lu",self.startTime.year,self.startTime.month,self.startTime.day];
    NSString *endTime = [NSString stringWithFormat:@"%.2lu-%.2lu-%.2lu",self.endTime.year,self.endTime.month,self.endTime.day];
    NSString *user_type = (self.isPet ? @"2" : @"1");
    NSDictionary *dict = @{@"ride_type":@"2",@"start_city":self.startCity.city_code,@"choose_time1":startTime,@"to_city":self.endCity.city_code,@"choose_time2":endTime,@"user_type":user_type};
    [HttpNetRequestTool netRequest:HttpNetRequestPost urlString:url paraments:dict success:^(id Json) {
        [self.tableView.mj_header endRefreshing];
        BaseModel *model = [BaseModel yy_modelWithJSON:Json];
        if (model.code == 1) {
            self.dataLists = [FlightSearchInfo getFlightSearchInfoLists:model.data];
            self.tableView.tableHeaderView = self.headerView;
            [self.tableView reloadData];
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
    FlightSearchJourneyCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:cellID owner:self options:nil] objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    FlightSearchInfo *info = self.dataLists[indexPath.section];
    cell.info = info;
    return cell;
}
#pragma mark --UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 12;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FlightSearchJourneyDetailController *vc = [[FlightSearchJourneyDetailController alloc] init];
    FlightSearchInfo *info = self.dataLists[indexPath.section];
    vc.isPet = self.isPet;
    vc.startCity = self.startCity;
    vc.endCity = self.endCity;
    vc.startTime = self.startTime;
    vc.endTime = self.endTime;
    vc.aircode1 = [NSString nullString:info.sid dispathString:@""];
    vc.aircode2 = [NSString nullString:info.tid dispathString:@""];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark --laod--
- (FlightSearchJourneyHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[[NSBundle mainBundle] loadNibNamed:@"FlightSearchJourneyHeaderView" owner:self options:nil] objectAtIndex:0];
        _headerView.backgroundColor = [UIColor clearColor];
        _headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 60);
    }
    return _headerView;
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
