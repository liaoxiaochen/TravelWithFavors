//
//  PurchaseController.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/2.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "PurchaseController.h"
#import "FlightInfoSearchController.h"
#import "FlightSearchJourneyController.h"
#import "RMCalendarController.h"
#import "CityChoseController.h"
#import "CityInfo.h"
#import "CityChoseViewController.h"
#import "NSDate+RMCalendarLogic.h"
#import <MapKit/MapKit.h>
#import <SDCycleScrollView/SDCycleScrollView.h>
#import "UIView+LSCore.h"
#import "NSString+Extension.h"
#import "PurchaseFooterView.h"
#import "RangePickerViewController.h"

@interface PurchaseController ()<CLLocationManagerDelegate, SDCycleScrollViewDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong) UIButton *normalBtn;
@property (nonatomic, strong) UIButton *petBtn;
@property (nonatomic, assign) BOOL isPetType;
@property (nonatomic, strong) UIView *centerView;
@property (nonatomic, strong) UIView *centerBackView;

@property (nonatomic, strong) UIButton *oneWayBtn;//单程
@property (nonatomic, strong) UIButton *journeyBtn;//返程
@property (nonatomic, strong) UIButton *exchangeBtn;//返程
@property (nonatomic, assign) BOOL isJourney;
@property (nonatomic, strong) UIButton *leftLabel;
@property (nonatomic, strong) UIButton *rightLabel;
@property (nonatomic, strong) UIButton *timeLeftLabel;
@property (nonatomic, strong) UIButton *timeRightLabel;
@property (nonatomic, strong) CityInfo *startCity;
@property (nonatomic, strong) CityInfo *endCity;
@property (nonatomic, strong) RMCalendarModel *startTime;
@property (nonatomic, strong) RMCalendarModel *endTime;

@property (nonatomic, strong) UIButton *addPetBtn;
@property (nonatomic, strong) UIButton *addBabyBtn;
@property (nonatomic, strong) UIView *babySelectView;
@property (nonatomic, strong) UIImageView *backImg;

@property (nonatomic, assign) int haveBaby; // 0无  1婴儿 2孩子 3都有
@property (nonatomic, strong) UILabel *babyLabel;
@property (nonatomic, strong) UILabel *childLabel;

@property (nonatomic, strong) CLLocationManager *locationManager;


@property (nonatomic,strong) SDCycleScrollView *scrollView;


@end

@implementation PurchaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor hdBackColor];
    self.navigationController.delegate = self;
    self.isJourney = NO;
    self.isPetType = NO;
    //默认普通用户
    self.isPetType = NO;
    self.haveBaby = 0;
    
    [self configView];
    [self setCenterUI];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHideSelectBaby)];
    [self.view addGestureRecognizer:tap];
}

- (void)configView{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    _scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200) imageNamesGroup:@[@"http://pic1.win4000.com/wallpaper/2017-12-29/5a46108f19717.jpg", @"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1694074041,1248343633&fm=27&gp=0.jpg"]];
    _scrollView.showPageControl = NO;
    [self.view addSubview:_scrollView];
    
}

- (void)setCenterUI {
    
    // 透明色背景
    self.centerView.frame = CGRectMake(0, 150, SCREEN_WIDTH, 300);
    [self.view addSubview:self.centerView];
    
    UIView *alapView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    alapView.backgroundColor = [UIColor colorWithHue:0 saturation:0 brightness:0 alpha:0.2];
    alapView.userInteractionEnabled = YES;
    [self setButtonCorner:alapView];
    [self.centerView addSubview:alapView];
    
    // 白色背景
    self.centerBackView.frame = CGRectMake(0, 50, SCREEN_WIDTH, 250);
    [self.centerView addSubview:self.centerBackView];
    
    
    self.oneWayBtn.frame = CGRectMake(0, 0, self.centerView.bounds.size.width / 2, 50);
    [self setButtonCorner:self.oneWayBtn];
    [self.centerView addSubview:self.oneWayBtn];
    
    self.journeyBtn.frame = CGRectMake(self.centerView.bounds.size.width / 2, 0, self.centerView.bounds.size.width / 2, 50);
    [self setButtonCorner:self.journeyBtn];
    [self.centerView addSubview:self.journeyBtn];
    
    self.exchangeBtn.frame = CGRectMake((self.centerView.bounds.size.width - 23)/2, CGRectGetMaxY(self.journeyBtn.frame) + 27, 23, 17);
    [self.centerView addSubview:self.exchangeBtn];
    
    //
    CGFloat leftSpace = 35;
    
    CGFloat lineW = (self.centerView.bounds.size.width - leftSpace * 2 - 55)/2;
    UIView *leftLine = [[UIView alloc] initWithFrame:CGRectMake(leftSpace, CGRectGetMaxY(self.exchangeBtn.frame) + 26, lineW, 1)];
    leftLine.backgroundColor = [UIColor colorWithHexString:@"#DDDDDD"];
    [self.centerView addSubview:leftLine];
    
    UIView *rightLine = [[UIView alloc] initWithFrame:CGRectMake(self.centerView.bounds.size.width - leftSpace - lineW, CGRectGetMaxY(self.exchangeBtn.frame) + 26, lineW, 1)];
    rightLine.backgroundColor = [UIColor colorWithHexString:@"#DDDDDD"];
    [self.centerView addSubview:rightLine];
    
    self.leftLabel.frame = CGRectMake(leftSpace, 50, lineW, CGRectGetMinY(leftLine.frame) - 50);
    [self.centerView addSubview:self.leftLabel];
    
    self.rightLabel.frame = CGRectMake(rightLine.frame.origin.x, 50, lineW, CGRectGetMinY(leftLine.frame) - 50);
    [self.centerView addSubview:self.rightLabel];
    
    UIView *buttomLine = [[UIView alloc] initWithFrame:CGRectMake(leftSpace, CGRectGetMaxY(leftLine.frame) + 49, self.centerView.bounds.size.width - leftSpace * 2, 1)];
    buttomLine.backgroundColor = [UIColor colorWithHexString:@"#DDDDDD"];
    [self.centerView addSubview:buttomLine];
    
    self.timeLeftLabel.frame = CGRectMake(leftSpace, CGRectGetMaxY(leftLine.frame), lineW, CGRectGetMinY(buttomLine.frame) - CGRectGetMaxY(leftLine.frame));
    [self.centerView addSubview:self.timeLeftLabel];
    
    self.timeRightLabel.frame = CGRectMake(rightLine.frame.origin.x, CGRectGetMaxY(rightLine.frame), lineW, CGRectGetMinY(buttomLine.frame) - CGRectGetMaxY(rightLine.frame));
    self.timeRightLabel.hidden = YES;
    [self.centerView addSubview:self.timeRightLabel];
    
    // 带宠物
    self.addPetBtn.frame = CGRectMake(self.view.frame.size.width - 115, CGRectGetMaxY(buttomLine.frame) + 20, 80, 30);
    [self.centerView addSubview:self.addPetBtn];
    self.addBabyBtn.frame = CGRectMake(CGRectGetMidX(self.addPetBtn.frame) - 155, CGRectGetMaxY(buttomLine.frame) + 20, 100, 30);
    [self.centerView addSubview:self.addBabyBtn];
    
    
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.adjustsImageWhenHighlighted = NO;
    searchBtn.backgroundColor = [UIColor colorWithHexString:@"#FF980D"];
    searchBtn.frame = CGRectMake(leftSpace, CGRectGetHeight(self.centerView.frame) - 60, self.centerView.bounds.size.width - leftSpace * 2, 40);
    searchBtn.layer.cornerRadius = 20;
    [searchBtn setTitle:@"查询" forState:UIControlStateNormal];
    searchBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [searchBtn addTarget:self action:@selector(searchBarCancel) forControlEvents:UIControlEventTouchUpInside];
    [self.centerView addSubview:searchBtn];
    
    //上部分
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMinY(self.centerView.frame) - 60, SCREEN_WIDTH - 20, 40)];
    bgView.layer.cornerRadius = 5;
    bgView.layer.masksToBounds = YES;
    [self.view addSubview:bgView];
    
    
    NSDateComponents *component = [[NSDate date] YMDComponents];
    RMCalendarModel *model = [RMCalendarModel calendarWithYear:component.year month:component.month day:component.day];
    NSString *time = [NSString stringWithFormat:@"%lu-%lu-%lu %@",(unsigned long)model.year,(unsigned long)model.month,(unsigned long)model.day,[model getWeek]];
    self.startTime = model;
    [self.timeLeftLabel setTitle:time forState:UIControlStateNormal];
    
    {
        //普通用户
        self.normalBtn.frame = CGRectMake(0, 0, bgView.bounds.size.width/2, bgView.bounds.size.height);
        //    [bgView addSubview:self.normalBtn];
        //携宠用户
        self.petBtn.frame = CGRectMake(bgView.bounds.size.width/2, 0, bgView.bounds.size.width/2, bgView.bounds.size.height);
        //    [bgView addSubview:self.petBtn];
    }
    
    
    PurchaseFooterView *foorView = [[PurchaseFooterView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.centerView.frame), SCREEN_WIDTH, 70)];
    [self.view addSubview:foorView];
    
    
}



#pragma mark -- ZXCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
}

#pragma mark --action
- (void)normalBtnClick{
    if (self.isPetType) {
        self.isPetType = NO;
        self.petBtn.backgroundColor = [UIColor colorWithHexString:@"#404A68"];
        [self.petBtn setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        self.normalBtn.backgroundColor = [UIColor whiteColor];
        [self.normalBtn setTitleColor:[UIColor colorWithHexString:@"#FF980D"] forState:UIControlStateNormal];
    }
}
- (void)petBtnClick{
    if (!self.isPetType) {
        self.isPetType = YES;
        self.normalBtn.backgroundColor = [UIColor colorWithHexString:@"#404A68"];
        [self.normalBtn setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        self.petBtn.backgroundColor = [UIColor whiteColor];
        [self.petBtn setTitleColor:[UIColor colorWithHexString:@"#FF980D"] forState:UIControlStateNormal];
    }
}
- (void)oneWayBtnClick{
    if (self.isJourney) {
        self.isJourney = NO;
        self.timeRightLabel.hidden = YES;
        
        [self setBtnState:_oneWayBtn isSelect:YES];
        [self setBtnState:_journeyBtn isSelect:NO];
        
        
    }
}
- (void)journeyBtnClick{
    if (!self.isJourney) {
        self.isJourney = YES;
        self.timeRightLabel.hidden = NO;
        
        [self setBtnState:_oneWayBtn isSelect:NO];
        [self setBtnState:_journeyBtn isSelect:YES];
        
        
    }
}

- (void)exchangeBtnClick{
    if (self.startCity && self.endCity) {
        CityInfo *tmp = self.startCity;
        self.startCity = self.endCity;
        self.endCity = tmp;
        
        [self.leftLabel setTitle:self.startCity.city_name forState:UIControlStateNormal];
        [self.rightLabel setTitle:self.endCity.city_name forState:UIControlStateNormal];
    }
}

- (BOOL)canSearch{
    if (self.isJourney) {
        //返程
        if (!self.startCity) {
            [HSToast hsShowBottomWithText:@"请选择出发地"];
            return NO;
        }
        if (!self.endCity) {
            [HSToast hsShowBottomWithText:@"请选择目的地"];
            return NO;
        }
        if (!self.startTime) {
            [HSToast hsShowBottomWithText:@"请选择出发时间"];
            return NO;
        }
        if (!self.endTime) {
            [HSToast hsShowBottomWithText:@"请选择返程时间"];
            return NO;
        }
    }else{
        if (!self.startCity) {
            [HSToast hsShowBottomWithText:@"请选择出发地"];
            return NO;
        }
        if (!self.endCity) {
            [HSToast hsShowBottomWithText:@"请选择目的地"];
            return NO;
        }
        if (!self.startTime) {
            [HSToast hsShowBottomWithText:@"请选择出发时间"];
            return NO;
        }
    }
    return YES;
}
#pragma mark 查询机票
- (void)searchBarCancel{
    if ([self canSearch]) {
        if (self.isJourney) {
            NSDate *startDate = [self.startTime date];
            NSDate *endDate = [self.endTime date];
            NSComparisonResult result = [startDate compare:endDate];
            if (result == NSOrderedDescending) {
                [HSToast hsShowBottomWithText:@"出发时间不能晚于返程时间"];
                return;
            }
            
            FlightInfoSearchController *vc = [[FlightInfoSearchController alloc] init];
            vc.isPet = self.isPetType;
            vc.startTime = self.startTime;
            vc.endCity = self.endCity;
            vc.startCity = self.startCity;
            vc.endTime = self.endTime;
            vc.ride_type = @"2";
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            FlightInfoSearchController *vc = [[FlightInfoSearchController alloc] init];
            vc.isPet = self.isPetType;
            vc.startTime = self.startTime;
            vc.endCity = self.endCity;
            vc.startCity = self.startCity;
            vc.ride_type = @"1";
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}
- (void)leftClick{
    
    CityChoseViewController *vc = [[CityChoseViewController alloc] init];
    __weak typeof(self) weakSelf = self;
    vc.cityChose = ^(CityInfo *info) {
        weakSelf.startCity = info;
        [weakSelf.leftLabel setTitle:info.city_name forState:UIControlStateNormal];
    };
    vc.hidesBottomBarWhenPushed = YES;
    vc.selectedCity = self.startCity;
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)rightClick{
    
    CityChoseViewController *vc = [[CityChoseViewController alloc] init];
    __weak typeof(self) weakSelf = self;
    vc.cityChose = ^(CityInfo *info) {
        weakSelf.endCity = info;
        [weakSelf.rightLabel setTitle:info.city_name forState:UIControlStateNormal];
    };
    vc.hidesBottomBarWhenPushed = YES;
    vc.selectedCity = self.endCity;
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)timeLeftClick{
    
    RangePickerViewController *vc = [[RangePickerViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    
    vc.isBackTracking = self.isJourney;
    vc.nowSelectComeDateModel = self.startTime;
    vc.nowSelectBackDateModel = self.endTime;
    
    __weak typeof(self) weakSelf = self;
    vc.calendarRangeBlock = ^(NSMutableDictionary *dic) {
        
        RMCalendarModel *comModel = dic[@"comeDate"];
        if (comModel) {
            NSString *time = [NSString stringWithFormat:@"%lu-%lu-%lu %@",(unsigned long)comModel.year,(unsigned long)comModel.month,(unsigned long)comModel.day,[comModel getWeek]];
            weakSelf.startTime = comModel;
            [weakSelf.timeLeftLabel setTitle:time forState:UIControlStateNormal];
        }
        
        RMCalendarModel *backModel = dic[@"backDate"];
        if (backModel) {
            NSString *backTime = [NSString stringWithFormat:@"%lu-%lu-%lu %@",(unsigned long)backModel.year,(unsigned long)backModel.month,(unsigned long)backModel.day,[backModel getWeek]];
            weakSelf.endTime = backModel;
            [weakSelf.timeRightLabel setTitle:backTime forState:UIControlStateNormal];
        }
        [self.navigationController popViewControllerAnimated:YES];
    };
    [self.navigationController pushViewController:vc animated:YES];
    
    //
    //    RMCalendarController *c = [RMCalendarController calendarWithDays:365 showType:CalendarShowTypeMultiple];
    //    c.isEnable = YES;
    //    c.hidesBottomBarWhenPushed = YES;
    //    c.title = @"日历";
    //
    //    __weak typeof(self) weakSelf = self;
    //    c.calendarBlock = ^(RMCalendarModel *model) {
    //        NSString *time = [NSString stringWithFormat:@"%lu-%lu-%lu %@",(unsigned long)model.year,(unsigned long)model.month,(unsigned long)model.day,[model getWeek]];
    //        weakSelf.startTime = model;
    //        [weakSelf.timeLeftLabel setTitle:time forState:UIControlStateNormal];
    //
    //        [self.navigationController popViewControllerAnimated:YES];
    //    };
    //    [self.navigationController pushViewController:c animated:YES];
    
}
- (void)timeRightClick{
    RangePickerViewController *vc = [[RangePickerViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    
    vc.isBackTracking = self.isJourney;
    vc.nowSelectComeDateModel = self.startTime;
    vc.nowSelectBackDateModel = self.endTime;
    
    __weak typeof(self) weakSelf = self;
    vc.calendarRangeBlock = ^(NSMutableDictionary *dic) {
        
        RMCalendarModel *comModel = dic[@"comeDate"];
        if (comModel) {
            NSString *time = [NSString stringWithFormat:@"%lu-%lu-%lu %@",(unsigned long)comModel.year,(unsigned long)comModel.month,(unsigned long)comModel.day,[comModel getWeek]];
            weakSelf.startTime = comModel;
            [weakSelf.timeLeftLabel setTitle:time forState:UIControlStateNormal];
        }
        
        RMCalendarModel *backModel = dic[@"backDate"];
        if (backModel) {
            NSString *backTime = [NSString stringWithFormat:@"%lu-%lu-%lu %@",(unsigned long)backModel.year,(unsigned long)backModel.month,(unsigned long)backModel.day,[backModel getWeek]];
            weakSelf.endTime = backModel;
            [weakSelf.timeRightLabel setTitle:backTime forState:UIControlStateNormal];
        }
        [self.navigationController popViewControllerAnimated:YES];
    };
    [self.navigationController pushViewController:vc animated:YES];
    
    //    RMCalendarController *c = [RMCalendarController calendarWithDays:365 showType:CalendarShowTypeMultiple];
    //    c.isEnable = YES;
    //    c.hidesBottomBarWhenPushed = YES;
    //    c.title = @"日历";
    //
    //    __weak typeof(self) weakSelf = self;
    //    c.calendarBlock = ^(RMCalendarModel *model) {
    //        if (model.ticketModel) {
    //            NSLog(@"%lu-%lu-%lu-票价%.1f",(unsigned long)model.year,(unsigned long)model.month,(unsigned long)model.day, model.ticketModel.ticketPrice);
    //        } else {
    //            NSString *time = [NSString stringWithFormat:@"%lu-%lu-%lu %@",(unsigned long)model.year,(unsigned long)model.month,(unsigned long)model.day,[model getWeek]];
    //            weakSelf.endTime = model;
    //            [weakSelf.timeRightLabel setTitle:time forState:UIControlStateNormal];
    //
    //        }
    //        [self.navigationController popViewControllerAnimated:YES];
    //    };
    //    [self.navigationController pushViewController:c animated:YES];
}


#pragma mark - 携带宠物 儿童
- (void)addPetBtnAction:(UIButton *)sender {
    
    self.isPetType = !self.isPetType;
    if (self.isPetType) {
        // 选中
        
        //        sender.backgroundColor = [UIColor lightGrayColor];
        sender.layer.borderColor = [UIColor hdOrganColor].CGColor;
        [sender setTitleColor:[UIColor hdOrganColor] forState:(UIControlStateNormal)];
    }else {
        //        sender.backgroundColor = [UIColor whiteColor];
        sender.layer.borderColor = [UIColor colorWithHexString:@"#CDCDCD"].CGColor;
        [sender setTitleColor:[UIColor colorWithHexString:@"#CDCDCD"] forState:(UIControlStateNormal)];
        
    }
    
}

- (void)tapHideSelectBaby {
    
    [self hideBabySelectView];
    _addBabyBtn.selected = NO;
    
}

- (void)addBabyAction:(UIButton *)sender {
    
    if (!sender.selected) {
        
        [self initBabySelectView];
    }else {
        
        [self hideBabySelectView];
    }
    sender.selected = !sender.selected;
    
}

- (void)hideBabySelectView {
    
    [UIView animateWithDuration:0.2 animations:^{
        
        self.babySelectView.frame = CGRectMake(self.view.frame.size.width - 220, CGRectGetMaxY(self.addBabyBtn.frame), 80, 0);
        self.backImg.frame = CGRectMake(0, 0, 80, 0);
        self.babyLabel.hidden = YES;
        self.childLabel.hidden = YES;
        
    } completion:^(BOOL finished) {
        if (self.haveBaby!=0) {
            [_addBabyBtn setImage:[UIImage imageNamed:@"purchase_arrow_topyellow"] forState:UIControlStateNormal];
        }else {
            [_addBabyBtn setImage:[UIImage imageNamed:@"purchase_arrow_top"] forState:UIControlStateNormal];
        }
        [self.babySelectView removeFromSuperview];
    }];
    
}

- (void)initBabySelectView {
    
    [self.centerView addSubview:self.babySelectView];
    [UIView animateWithDuration:0.2 animations:^{
        
        self.babySelectView.frame = CGRectMake(self.view.frame.size.width - 220, CGRectGetMaxY(self.addBabyBtn.frame), 80, 80);
        self.backImg.frame = CGRectMake(0, 0, 80, 80);
        
        if (self.haveBaby!=0) {
            [_addBabyBtn setImage:[UIImage imageNamed:@"purchase_arrow_down"] forState:UIControlStateNormal];
        }else {
            [_addBabyBtn setImage:[UIImage imageNamed:@"purchase_arrow_downyellow"] forState:UIControlStateNormal];
        }
        
    } completion:^(BOOL finished) {
        
        self.babyLabel.hidden = NO;
        self.childLabel.hidden = NO;
    }];
}

- (void)selectAction:(UIGestureRecognizer *)sender {
    
    UILabel *label = (UILabel *)sender.view;
    if (self.haveBaby == 0) {
        if (label.tag == 1000) {
            self.haveBaby = 1;
        }else {
            self.haveBaby = 2;
        }
        
    }else if (self.haveBaby == 1) {
        if (label.tag == 1000) {
            self.haveBaby = 0;
        }else {
            self.haveBaby = 3;
        }
        
    }else if (self.haveBaby == 2) {
        if (label.tag == 1000) {
            self.haveBaby = 3;
        }else {
            self.haveBaby = 0;
        }
        
    }else if (self.haveBaby == 3) {
        if (label.tag == 1000) {
            self.haveBaby = 2;
        }else {
            self.haveBaby = 1;
        }
        
    }
    
    [self changeSelectColor:label statue:self.haveBaby];
    [self changeBabyBtnStyle:self.haveBaby];
}

-(void)changeBabyBtnStyle:(NSInteger)haveBaby {
    if (haveBaby == 0) {
        [_addBabyBtn setTitleColor:[UIColor colorWithHexString:@"#CDCDCD"] forState:UIControlStateNormal];
        _addBabyBtn.layer.borderColor = [UIColor colorWithHexString:@"#CDCDCD"].CGColor;
        [_addBabyBtn setImage:[UIImage imageNamed:@"purchase_arrow_downyellow"] forState:UIControlStateNormal];
        
    }else {
        [_addBabyBtn setTitleColor:[UIColor hdOrganColor] forState:UIControlStateNormal];
        _addBabyBtn.layer.borderColor = [UIColor hdOrganColor].CGColor;
        [_addBabyBtn setImage:[UIImage imageNamed:@"purchase_arrow_down"] forState:UIControlStateNormal];
        
    }
}

- (void)changeSelectColor:(UILabel *)label statue:(int)statue  {
    
    UILabel *babyLabel = [label.superview.superview viewWithTag:1000];
    UILabel *childLabel = [label.superview.superview viewWithTag:1001];
    
    if (statue == 0) {
        babyLabel.textColor = [UIColor colorWithHexString:@"#CDCDCD"];
        childLabel.textColor = [UIColor colorWithHexString:@"#CDCDCD"];
        
        _backImg.image = [UIImage imageNamed:@"purchase_nothing"];
    }else if (statue == 1) {
        
        babyLabel.textColor = [UIColor whiteColor];
        childLabel.textColor = [UIColor colorWithHexString:@"#CDCDCD"];
        
        _backImg.image = [UIImage imageNamed:@"purchase_down"];
        
    }else if (statue == 2) {
        babyLabel.textColor = [UIColor colorWithHexString:@"#CDCDCD"];
        childLabel.textColor = [UIColor whiteColor];
        
        _backImg.image = [UIImage imageNamed:@"purchase_downcolor"];
        
    }else {
        babyLabel.textColor = [UIColor whiteColor];
        childLabel.textColor = [UIColor whiteColor];
        
        _backImg.image = [UIImage imageNamed:@"purchase_whole"];
        
    }
}

#pragma mark - UI
- (UIView *)babySelectView {
    if (!_babySelectView) {
        _babySelectView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 220, CGRectGetMaxY(self.addBabyBtn.frame), 80, 80)];
        
        self.backImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
        self.backImg.image = [UIImage imageNamed:@"purchase_nothing"];
        [_babySelectView addSubview:self.backImg];
        
        [_babySelectView addSubview:self.babyLabel];
        [_babySelectView addSubview:self.childLabel];
        
    }
    return _babySelectView;
}


- (UILabel *)babyLabel {
    if (!_babyLabel) {
        _babyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
        _babyLabel.tag = 1000;
        NSString *tipString = @"婴儿14天-2岁";
        _babyLabel.attributedText =  [NSString changeLabelWithMaxString:tipString diffrenIndex:2 maxFont:12 littleFont:8];
        _babyLabel.userInteractionEnabled = YES;
        _babyLabel.textColor = [UIColor colorWithHexString:@"#CDCDCD"];
        _babyLabel.textAlignment = NSTextAlignmentCenter;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectAction:)];
        [_babyLabel addGestureRecognizer:tap];
    }
    return _babyLabel;
}

- (UILabel *)childLabel {
    if (!_childLabel) {
        _childLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, 80, 30)];
        _childLabel.tag = 1001;
        NSString *tipString = @"儿童2岁-12岁";
        _childLabel.attributedText =  [NSString changeLabelWithMaxString:tipString diffrenIndex:2 maxFont:12 littleFont:8];
        _childLabel.userInteractionEnabled = YES;
        _childLabel.textColor = [UIColor colorWithHexString:@"#CDCDCD"];
        _childLabel.textAlignment = NSTextAlignmentCenter;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectAction:)];
        [_childLabel addGestureRecognizer:tap];
    }
    return _childLabel;
}

#pragma mark --load--
- (UIButton *)normalBtn{
    if (!_normalBtn) {
        _normalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _normalBtn.adjustsImageWhenHighlighted = NO;
        _normalBtn.backgroundColor = [UIColor whiteColor];
        [_normalBtn setTitle:@"普通用户" forState:UIControlStateNormal];
        [_normalBtn setTitleColor:[UIColor colorWithHexString:@"#FF980D"] forState:UIControlStateNormal];
        _normalBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [_normalBtn addTarget:self action:@selector(normalBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _normalBtn;
}
- (UIButton *)petBtn{
    if (!_petBtn) {
        _petBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _petBtn.adjustsImageWhenHighlighted = NO;
        _petBtn.backgroundColor = [UIColor colorWithHexString:@"#404A68"];
        [_petBtn setTitle:@"携宠用户" forState:UIControlStateNormal];
        [_petBtn setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        _petBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [_petBtn addTarget:self action:@selector(petBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _petBtn;
}

- (UIButton *)exchangeBtn{
    if (!_exchangeBtn) {
        _exchangeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _exchangeBtn.adjustsImageWhenHighlighted = NO;
        [_exchangeBtn setImage:[UIImage imageNamed:@"purchase_exchange"] forState:UIControlStateNormal];
        [_exchangeBtn addTarget:self action:@selector(exchangeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _exchangeBtn;
}

- (UIView *)centerView{
    if (!_centerView) {
        
        _centerView = [[UIView alloc] init];
        _centerView.backgroundColor = [UIColor clearColor];
        _centerView.layer.cornerRadius = 10;
        _centerView.layer.masksToBounds = YES;
        
    }
    return _centerView;
}
- (UIView *)centerBackView{
    if (!_centerBackView) {
        _centerBackView = [[UIView alloc] init];
        _centerBackView.backgroundColor = [UIColor whiteColor];
        _centerBackView.layer.masksToBounds = YES;
        
        [_centerBackView addRoundedCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight  withRadii:CGSizeMake(5.0, 5.0) viewRect:CGRectMake(0, 0, SCREEN_WIDTH, 250)];
        
    }
    return _centerBackView;
}

- (UIButton *)oneWayBtn{
    if (!_oneWayBtn) {
        _oneWayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_oneWayBtn setTitle:@"单程" forState:UIControlStateNormal];
        [_oneWayBtn setTitleColor:[UIColor colorWithHexString:@"#383838"] forState:UIControlStateNormal];
        _oneWayBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
        [_oneWayBtn addTarget:self action:@selector(oneWayBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self setBtnState:_oneWayBtn isSelect:YES];
    }
    return _oneWayBtn;
}
- (UIButton *)journeyBtn{
    if (!_journeyBtn) {
        _journeyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_journeyBtn setTitle:@"往返" forState:UIControlStateNormal];
        [_journeyBtn setTitleColor:[UIColor colorWithHexString:@"#383838"] forState:UIControlStateNormal];
        _journeyBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
        [_journeyBtn addTarget:self action:@selector(journeyBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self setBtnState:_journeyBtn isSelect:NO];
        
    }
    return _journeyBtn;
}
- (UIButton *)leftLabel{
    if (!_leftLabel) {
        _leftLabel = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftLabel setTitle:@"出发地" forState:UIControlStateNormal];
        [_leftLabel setTitleColor:[UIColor colorWithHexString:@"#1c1c1c"] forState:UIControlStateNormal];
        _leftLabel.titleLabel.font = [UIFont boldSystemFontOfSize:24.0f];
        _leftLabel.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_leftLabel addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftLabel;
}
- (UIButton *)rightLabel{
    if (!_rightLabel) {
        _rightLabel = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightLabel setTitle:@"目的地" forState:UIControlStateNormal];
        [_rightLabel setTitleColor:[UIColor colorWithHexString:@"#1c1c1c"] forState:UIControlStateNormal];
        _rightLabel.titleLabel.font = [UIFont boldSystemFontOfSize:24.0f];
        _rightLabel.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_rightLabel addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightLabel;
}
- (UIButton *)timeLeftLabel{
    if (!_timeLeftLabel) {
        _timeLeftLabel = [UIButton buttonWithType:UIButtonTypeCustom];
        [_timeLeftLabel setTitle:@"出发时间" forState:UIControlStateNormal];
        [_timeLeftLabel setTitleColor:[UIColor colorWithHexString:@"#383838"] forState:UIControlStateNormal];
        _timeLeftLabel.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _timeLeftLabel.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        [_timeLeftLabel addTarget:self action:@selector(timeLeftClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _timeLeftLabel;
}
- (UIButton *)timeRightLabel{
    if (!_timeRightLabel) {
        _timeRightLabel = [UIButton buttonWithType:UIButtonTypeCustom];
        [_timeRightLabel setTitle:@"返程时间" forState:UIControlStateNormal];
        [_timeRightLabel setTitleColor:[UIColor colorWithHexString:@"#383838"] forState:UIControlStateNormal];
        _timeRightLabel.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        _timeRightLabel.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        [_timeRightLabel addTarget:self action:@selector(timeRightClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _timeRightLabel;
}
- (UIButton *)addPetBtn{
    if (!_addPetBtn) {
        _addPetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addPetBtn setTitle:@"携带宠物" forState:UIControlStateNormal];
        _addPetBtn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        [_addPetBtn addTarget:self action:@selector(addPetBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_addPetBtn setTitleColor:[UIColor colorWithHexString:@"#CDCDCD"] forState:UIControlStateNormal];
        _addPetBtn.layer.cornerRadius = 15;
        _addPetBtn.layer.borderWidth = 1;
        _addPetBtn.layer.borderColor = [UIColor colorWithHexString:@"#CDCDCD"].CGColor;
        
    }
    return _addPetBtn;
}
- (UIButton *)addBabyBtn{
    if (!_addBabyBtn) {
        
        _addBabyBtn = [self createButtonWithTitle:@"携带儿童"];
        [_addBabyBtn addTarget:self action:@selector(addBabyAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBabyBtn;
}
- (UIButton *)createButtonWithTitle:(NSString *)title{
    // 创建标题按钮
    UIButton * button = [[UIButton alloc] init];
    button.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [button setImage:[UIImage imageNamed:@"purchase_arrow_downyellow"] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithHexString:@"#CDCDCD"] forState:UIControlStateNormal];
    button.layer.cornerRadius = 15;
    button.layer.borderWidth = 1;
    button.layer.borderColor = [UIColor colorWithHexString:@"#CDCDCD"].CGColor;
    button.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    
    [button sizeToFit];
    button.titleEdgeInsets = UIEdgeInsetsMake(0, -button.imageView.frame.size.width - button.frame.size.width + button.titleLabel.frame.size.width, 0, 0);
    button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -button.titleLabel.frame.size.width - button.frame.size.width + button.imageView.frame.size.width);
    
    return button;
}
#pragma mark === 定位 ===
-(void)startLocation{
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = 100.0f;
    if ([[[UIDevice currentDevice] systemVersion] doubleValue] >8.0){
        [self.locationManager requestWhenInUseAuthorization];
    }
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        if (@available(iOS 9.0, *)) {
            //_locationManager.allowsBackgroundLocationUpdates = YES;
        } else {
            // Fallback on earlier versions
        }
    }
    [self.locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            if([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
                [self.locationManager requestWhenInUseAuthorization];
            }
            break;
        default:
            break;
    }
}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *newLocation = locations[0];
    CLLocationCoordinate2D oldCoordinate = newLocation.coordinate;
    NSLog(@"旧的经度：%f,旧的纬度：%f",oldCoordinate.longitude,oldCoordinate.latitude);
    [manager stopUpdatingLocation];
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray<CLPlacemark *> *_Nullable placemarks, NSError * _Nullable error) {
        for (CLPlacemark *place in placemarks) {
            NSLog(@"name,%@",place.name);                      // 位置名
            NSLog(@"thoroughfare,%@",place.thoroughfare);      // 街道
            NSLog(@"subThoroughfare,%@",place.subThoroughfare);// 子街道
            NSLog(@"locality,%@",place.locality);              // 市
            NSLog(@"subLocality,%@",place.subLocality);        // 区
            NSLog(@"country,%@",place.country);                // 国家
        }
    }];
}

- (void)setButtonCorner:(UIView *)button {
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:button.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = button.bounds;
    maskLayer.path = maskPath.CGPath;
    button.layer.mask  = maskLayer;
}

// 设置button状态
- (void)setBtnState:(UIButton *)button isSelect:(BOOL)isSelect {
    
    if (isSelect) {
        
        [button setBackgroundColor:[UIColor whiteColor]];
        [button setTitleColor:[UIColor colorWithHexString:@"#FF980D"] forState:UIControlStateNormal];
    }else {
        
        [button setBackgroundColor:[UIColor clearColor]];
        
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
    }
    
    
}

#pragma mark - UINavigationControllerDelegate
// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}


@end
