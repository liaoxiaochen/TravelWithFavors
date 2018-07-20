//
//  FlightInfoSearchController.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/6.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "FlightInfoSearchController.h"
#import "FlightSearchCell.h"
#import "FlightSearchHeaderView.h"
#import "FlightSearchDetailController.h"
#import "FlightSearchJourneyDetailController.h"
#import "RMCalendarController.h"
#import "CityInfo.h"
#import "HRfunctionButton.h"
#import "NSDate+RMCalendarLogic.h"
static NSString *const cellID = @"FlightSearchCell";
@interface FlightInfoSearchController ()
@property (nonatomic, strong) FlightSearchHeaderView *headerView;
@property (nonatomic, strong) NSArray *dataLists;

@property (nonatomic, strong) HRfunctionButton *timeBtn;
@property (nonatomic, strong) HRfunctionButton *feeBtn;

@property (nonatomic, assign) BOOL isTimeDesc;//降序
@property (nonatomic, assign) BOOL isFeeDesc;//降序

@property (nonatomic, strong) NSString *price;//往/返最低价
/** NSURLSessionDataTask */
@property (nonatomic, strong) NSURLSessionDataTask *task;

@end

@implementation FlightInfoSearchController
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
    [self setUpBottomToolBar];
    __weak typeof(self) weakSelf = self;
    self.headerView.selectedBlock = ^(NSInteger index,RMCalendarModel *model) {
        debugLog(@"头视图选择了%ld",index + 1);
//        [weakSelf.task cancel];
        if ([@"3" isEqualToString:weakSelf.ride_type]) {
            weakSelf.endTime = model;
        }else{
            weakSelf.startTime = model;
        }
        weakSelf.dataLists = nil;
        [weakSelf.tableView reloadData];
//        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC));
//        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
//            [weakSelf.tableView.mj_header beginRefreshing];
//        });
        [weakSelf.tableView.mj_header beginRefreshing];
    };
    self.headerView.calendarBlock = ^{
        debugLog(@"点击了日历");
        RMCalendarController *c = [RMCalendarController calendarWithDays:365 showType:CalendarShowTypeMultiple];
        c.isEnable = YES;
        c.hidesBottomBarWhenPushed = YES;
        c.title = @"日历";
        c.calendarBlock = ^(RMCalendarModel *model) {
            
//            NSString *time = [NSString stringWithFormat:@"%lu-%lu-%lu %@",(unsigned long)model.year,(unsigned long)model.month,(unsigned long)model.day,[model getWeek]];
            if ([@"3" isEqualToString:weakSelf.ride_type]) {
                weakSelf.endTime = model;
                weakSelf.headerView.dateTime = model;
            }else{
                weakSelf.startTime = model;
                weakSelf.headerView.dateTime = model;
            }
            [weakSelf.navigationController popViewControllerAnimated:YES];
            [weakSelf.tableView.mj_header beginRefreshing];
        };
        [weakSelf.navigationController pushViewController:c animated:YES];
    };
}
- (void)setCustomNavigationTitleView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [AppConfig getNavigationBarHeight])];
    view.backgroundColor = [UIColor hdMainColor];
    
    UIView *bgview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, view.bounds.size.width, view.bounds.size.height)];
    
    UILabel *toBackLabel = nil;
    if (![@"1" isEqualToString:self.ride_type]) {
        toBackLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        toBackLabel.text = [@"2" isEqualToString:self.ride_type] ? @"选去程:":@"选返程:";
        toBackLabel.textColor = [UIColor whiteColor];
        [toBackLabel sizeToFit];
    }
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
    if (![@"1" isEqualToString:self.ride_type]) {
        flight.image = [UIImage imageNamed:@"ss_wf2"];
    }
    flight.frame = CGRectMake(CGRectGetMaxX(leftLabel.frame) + 7, (bgview.bounds.size.height - 18)/2, 18, 18);
    [bgview addSubview:flight];
    
    rightLabel.frame = CGRectMake(bgview.bounds.size.width - rightLabel.bounds.size.width, 0, rightLabel.bounds.size.width, bgview.bounds.size.height);
    [bgview addSubview:rightLabel];
    
    if (![@"1" isEqualToString:self.ride_type]) {
        toBackLabel.frame = CGRectMake(bgview.x - toBackLabel.width - 7, [AppConfig getStatusBarHeight] - 0.5, toBackLabel.width, [AppConfig getNavigationBarHeight] - [AppConfig getStatusBarHeight]);
        [view addSubview:toBackLabel];
    }
    
    [self.view addSubview:view];
}
-(void)setUpBottomToolBar{
    CGFloat toolBarH = 50;
    self.tableView.frame = CGRectMake(0, [AppConfig getNavigationBarHeight], SCREEN_WIDTH, SCREENH_HEIGHT - [AppConfig getNavigationBarHeight] - [AppConfig getButtomHeight] - toolBarH);
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.tableView.frame), SCREEN_WIDTH, toolBarH)];
    view.backgroundColor = [UIColor colorWithHexString:@"#272D45"];
    [self.view addSubview:view];
    
    HRfunctionButton *timeBtn = [[HRfunctionButton alloc] init];
    timeBtn.tag = 101;
    timeBtn.center = CGPointMake(SCREEN_WIDTH/4, toolBarH/2);
    timeBtn.bounds = CGRectMake(0, 0, SCREEN_WIDTH/2, toolBarH);
    timeBtn.selected = YES;
    [timeBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [timeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [timeBtn setTitleColor:[UIColor colorWithHexString:@"#5A6FA6"] forState:UIControlStateSelected];
    [timeBtn setImage:[UIImage imageNamed:@"ic_sx_time"] forState:UIControlStateNormal];
    [timeBtn setImage:[UIImage imageNamed:@"ic_sx_xtime"] forState:UIControlStateSelected];
    [timeBtn setTitle:@"时间" forState:UIControlStateNormal];
    [timeBtn setTitle:@"出发早⇀晚" forState:UIControlStateSelected];
    [timeBtn addTarget:self action:@selector(sorting:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:timeBtn];
    self.timeBtn = timeBtn;
    
    HRfunctionButton *feeBtn = [[HRfunctionButton alloc] init];
    feeBtn.tag = 102;
    feeBtn.center = CGPointMake(SCREEN_WIDTH*0.75, toolBarH/2);
    feeBtn.bounds = CGRectMake(0, 0, SCREEN_WIDTH/2, toolBarH);
    [feeBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [feeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [feeBtn setTitleColor:[UIColor colorWithHexString:@"#5A6FA6"] forState:UIControlStateSelected];
    [feeBtn setImage:[UIImage imageNamed:@"ic_sx_jg"] forState:UIControlStateNormal];
    [feeBtn setImage:[UIImage imageNamed:@"ic_s_xjg"] forState:UIControlStateSelected];
    [feeBtn setTitle:@"价格" forState:UIControlStateNormal];
    [feeBtn setTitle:@"价格低⇀高" forState:UIControlStateSelected];
    [feeBtn addTarget:self action:@selector(sorting:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:feeBtn];
    self.feeBtn = feeBtn;
}

- (void)configView{
    self.tableView.rowHeight = 71;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = self.headerView;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getData)];
    [self.tableView.mj_header beginRefreshing];
}
- (void)getData{
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.headerView.userInteractionEnabled = false;
    NSString *url = [HttpNetRequestTool requestUrlString:@"/ticket/flight"];
    NSString *to_time = [NSString stringWithFormat:@"%.2lu-%.2lu-%.2lu",self.startTime.year,self.startTime.month,self.startTime.day];
    NSString *back_time = @"";
    if (self.endTime) {
        back_time = [NSString stringWithFormat:@"%.2lu-%.2lu-%.2lu",self.endTime.year,self.endTime.month,self.endTime.day];
    }
    NSString *user_type = (self.isPet ? @"2" : @"1");
    NSString *order_type = self.timeBtn.selected ? @"1" : @"2";
    NSString *order_value = @"asc";
    if (self.timeBtn.selected) {
        order_value = self.isTimeDesc ? @"desc" : @"asc";
    }else{
        order_value = self.isFeeDesc ? @"desc" : @"asc";
    }
    NSDictionary *dict = @{@"ride_type":self.ride_type,@"user_type":user_type,
                           @"start_city":self.startCity.city_code,@"to_city":self.endCity.city_code,
                           @"choose_time":to_time,@"choose_time_back":back_time,
                           @"order_type":order_type,@"order_value":order_value};
    if ([@"3" isEqualToString:self.ride_type]) {
        dict = @{@"ride_type":self.ride_type,@"user_type":user_type,
                @"start_city":self.startCity.city_code,@"to_city":self.endCity.city_code,
                 @"choose_time":back_time,@"end_time":self.journeyEndTime?:@"",
                @"order_type":order_type,@"order_value":order_value};
    }
    HRLog(@"dict = %@",dict)
    [HttpNetRequestTool netRequest:HttpNetRequestPost urlString:url paraments:dict success:^(id Json) {
        [self.tableView.mj_header endRefreshing];
        self.headerView.userInteractionEnabled = true;
        BaseModel *model = [BaseModel yy_modelWithJSON:Json];
        HRLog(@"%@",Json)
        if (model.code == 1) {
            self.dataLists = [FlightInfo getFlightInfoLists:model.data];
            if ([@"2" isEqualToString:self.ride_type]) {//往返去程获取返程最低价
                self.price = model.price;
            }
            [self.tableView reloadData];
        }else{
            [HSToast hsShowBottomWithText:model.msg];
        }
    } failure:^(NSString *error) {
        [self.tableView.mj_header endRefreshing];
        self.headerView.userInteractionEnabled = true;
        [HSToast hsShowBottomWithText:error];
    }];
}
-(void)sorting:(UIButton *)btn{
    if (btn.tag == 101) {
        if (btn.selected) {
            if (self.isTimeDesc) {
                self.isTimeDesc = false;
                [btn setTitle:@"出发早⇀晚" forState:UIControlStateSelected];
            }else{
                self.isTimeDesc = true;
                [btn setTitle:@"出发晚⇀早" forState:UIControlStateSelected];
            }
        }else{
            btn.selected = true;
            self.isTimeDesc = false;
            [btn setTitle:@"出发早⇀晚" forState:UIControlStateSelected];
        }
        self.isFeeDesc = false;
        self.feeBtn.selected = false;
    }else if (btn.tag == 102){
        if (btn.selected) {
            if (self.isFeeDesc) {
                self.isFeeDesc = false;
                [btn setTitle:@"价格低⇀高" forState:UIControlStateSelected];
            }else{
                self.isFeeDesc = true;
                [btn setTitle:@"价格高⇀低" forState:UIControlStateSelected];
            }
        }else{
            btn.selected = true;
            self.isFeeDesc = false;
            [btn setTitle:@"价格低⇀高" forState:UIControlStateSelected];
        }
        self.isTimeDesc = false;
        self.timeBtn.selected = false;
    }
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark --UITableViewDatasouce
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataLists.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FlightSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:cellID owner:self options:nil] objectAtIndex:0];
        //cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIView *cellBlack = [[UIView alloc] initWithFrame:cell.frame];
        cellBlack.backgroundColor = [UIColor clearColor];
        cell.selectedBackgroundView = cellBlack;
    }
    cell.ride_type = self.ride_type;
    cell.price = self.price;
    cell.info = self.dataLists[indexPath.section];
    return cell;
}
#pragma mark --UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 12;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([@"3" isEqualToString:self.ride_type]) {//跳转往返详情界面
        FlightSearchJourneyDetailController *vc = [[FlightSearchJourneyDetailController alloc] init];
        FlightInfo *info = self.dataLists[indexPath.section];
        vc.isPet = self.isPet;
        vc.startCity = self.endCity;//城市往返再次交换
        vc.endCity = self.startCity;
        vc.startTime = self.startTime;
        vc.endTime = self.endTime;
        vc.aircode1 = [NSString nullString:self.to_flightInfo.pid dispathString:@""];
        vc.aircode2 = [NSString nullString:info.pid dispathString:@""];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([@"2" isEqualToString:self.ride_type]){//点击跳转返程选择界面
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"确定该票为去程票，并前往选择返程票？" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            FlightInfoSearchController *vc = [[FlightInfoSearchController alloc] init];
            FlightInfo *info = self.dataLists[indexPath.section];
            vc.journeyEndTime = info.arrive_time;// 跳返程需要传的参数 判断返程能买的最早的机票
            vc.isPet = self.isPet;
            vc.startCity = self.endCity;//城市往返交换
            vc.endCity = self.startCity;
            vc.startTime = self.startTime;
            NSDate *startDate = [self.startTime date];
            NSDate *endDate = [self.endTime date];
            NSComparisonResult result = [startDate compare:endDate];
            if (result == NSOrderedDescending) {//如果出发时间晚于返程时间则将返程时间设置为出发时间
                vc.endTime = self.startTime;
            }else{
                vc.endTime = self.endTime;
            }
            vc.ride_type = @"3";
            vc.price = info.par_price;
            vc.to_flightInfo = self.dataLists[indexPath.section];
//            dispatch_async(dispatch_get_main_queue(), ^{
               [self.navigationController pushViewController:vc animated:YES];
//            });
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alertVC addAction:action];
        [alertVC addAction:cancelAction];
        [self presentViewController:alertVC animated:YES completion:nil];
        
    }else{//单程
        FlightSearchDetailController *vc = [[FlightSearchDetailController alloc] init];
        FlightInfo *info = self.dataLists[indexPath.section];
        vc.isPet = self.isPet;
        vc.startCity = self.startCity;
        vc.endCity = self.endCity;
        vc.startTime = self.startTime;
        vc.isChange = self.isChange;
        vc.orderno = self.orderno;
        vc.aircode1 = [NSString nullString:info.pid dispathString:@""];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
#pragma mark --load--
- (FlightSearchHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[FlightSearchHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 70)];
        if ([@"3" isEqualToString:self.ride_type]) {
            _headerView.dateTime = self.endTime;
        }else{
            _headerView.dateTime = self.startTime;
        }
    }
    return _headerView;
}
- (NSArray *)dataLists{
    if (!_dataLists){
        _dataLists = [[NSArray alloc] init];
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
