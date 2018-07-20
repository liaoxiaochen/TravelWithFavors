//
//  CityChoseViewController.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/15.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "CityChoseViewController.h"
#import "CityChoseCell.h"
#import "CityInfo.h"
#import "MJNIndexView.h"
static NSString *const yycacheKey = @"CityChinese";
static NSString *const yycacheName = @"CityChineseCache";
static NSString *const yycacheKey2 = @"CityInternationl";
static NSString *const yycacheName2 = @"CityInternationlCache";
@interface CityChoseViewController ()<MJNIndexViewDataSource>
@property (nonatomic, strong) UITextField *searchTextField;
@property (nonatomic, strong) UIButton *chinesBtn;
@property (nonatomic, strong) UIButton *internationalBtn;
@property (nonatomic, assign) BOOL isInternationl;
@property (nonatomic, strong) UITableView *otherTableView;
@property (nonatomic, strong) NSArray *dataLists;
@property (nonatomic, strong) NSArray *otherLists;
@property (nonatomic, strong) NSArray *allKeysLists;
@property (nonatomic, strong) UITableView *searchTableView;
@property (nonatomic, strong) NSArray *searchDataLists;
@property (nonatomic, strong) UILabel *searchLabel;
@property (nonatomic, strong) NSMutableArray *allDataLists;
@property (nonatomic, strong) MJNIndexView *selectedView;

/** 是否支持国际/港澳台搜索 */
@property (nonatomic, assign) BOOL isSupport;

@end

@implementation CityChoseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _isSupport = false;
    [self setUpSearchBar];
    [self setUpHeaderView];
    [self configView];
    [self firstAttributesForMJNIndexView];
    [self getChinsesData];
    [self getInternatonlData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(searchTextFieldTextDidChanged) name:UITextFieldTextDidChangeNotification object:nil];
}
- (void)firstAttributesForMJNIndexView
{
    self.selectedView.frame = self.tableView.frame;
    [self.view addSubview:self.selectedView];
    self.selectedView.getSelectedItemsAfterPanGestureIsFinished = NO;
    self.selectedView.font = [UIFont fontWithName:@"HelveticaNeue" size:13.0];
    self.selectedView.selectedItemFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:40.0];
    self.selectedView.backgroundColor = [UIColor clearColor];
    self.selectedView.curtainColor = [UIColor colorWithHexString:@"#333333"];
    self.selectedView.curtainFade = 0.0;
    self.selectedView.curtainStays = NO;
    self.selectedView.curtainMoves = YES;
    self.selectedView.curtainMargins = NO;
    self.selectedView.ergonomicHeight = NO;
    self.selectedView.upperMargin = 30.0;
    self.selectedView.lowerMargin = 124.0;
    self.selectedView.rightMargin = 10.0;
    self.selectedView.itemsAligment = NSTextAlignmentCenter;
    self.selectedView.maxItemDeflection = 80.0;
    self.selectedView.rangeOfDeflection = 3;
    self.selectedView.fontColor = [UIColor colorWithHexString:@"#333333"];
    self.selectedView.selectedItemFontColor = [UIColor colorWithHexString:@"#333333"];
    self.selectedView.darkening = NO;
    self.selectedView.fading = YES;
    
}
- (void)setUpSearchBar{
    self.searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, [AppConfig getStatusBarHeight] + ([AppConfig getNavigationBarHeight] - [AppConfig getStatusBarHeight] - 30)/2, SCREEN_WIDTH, 30)];
    self.searchTextField.backgroundColor = [UIColor whiteColor];
    
    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:14.0f]};//NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#333333"]
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:@"字母/中文/三字码" attributes:dict];
    self.searchTextField.attributedPlaceholder = att;
    self.searchTextField.layer.cornerRadius = 3;
    self.searchTextField.layer.masksToBounds = YES;
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, self.searchTextField.bounds.size.height)];
//    view.backgroundColor = [UIColor greenColor];
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@""];
    self.searchTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 6, 50)];
    self.searchTextField.leftViewMode = UITextFieldViewModeAlways;
    self.searchTextField.returnKeyType = UIReturnKeySearch;
    self.searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.navigationItem.titleView = self.searchTextField;
}

- (void)setUpHeaderView{
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, [AppConfig getNavigationBarHeight], SCREEN_WIDTH, 40)];
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(16, 5, header.bounds.size.width - 32, header.bounds.size.height - 10)];
    bgView.layer.cornerRadius = 3;
    bgView.layer.masksToBounds = YES;
    bgView.layer.borderWidth = 1;
    bgView.layer.borderColor = [UIColor whiteColor].CGColor;
    [header addSubview:bgView];
    self.chinesBtn.frame = CGRectMake(0, 0, bgView.bounds.size.width/2, bgView.bounds.size.height);
    [bgView addSubview:self.chinesBtn];
    
    self.internationalBtn.frame = CGRectMake(bgView.bounds.size.width/2, 0, bgView.bounds.size.width/2, bgView.bounds.size.height);
    [bgView addSubview:self.internationalBtn];
    [self.view addSubview:header];
}
- (void)configView{
    self.view.backgroundColor = [UIColor hdMainColor];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.frame = CGRectMake(0, [AppConfig getNavigationBarHeight] + 40, SCREEN_WIDTH, SCREENH_HEIGHT - [AppConfig getNavigationBarHeight] - 40 - [AppConfig getButtomHeight]);
    self.otherTableView.frame = self.tableView.frame;
    [self.view addSubview:self.otherTableView];
    self.otherTableView.hidden = YES;
    self.searchTableView.frame = CGRectMake(0, [AppConfig getNavigationBarHeight], SCREEN_WIDTH, SCREENH_HEIGHT - [AppConfig getNavigationBarHeight] - [AppConfig getButtomHeight]);
    self.searchTableView.tableHeaderView = self.searchLabel;
    [self.view addSubview:self.searchTableView];
    self.searchTableView.hidden = YES;
}
#pragma mark --data
- (void)getChinsesData{
//    [self getData:@"1"];
    [self cheakCacheData:@"1"];
}
- (void)getInternatonlData{
//    [self getData:@"2"];
    if (_isSupport){
        [self cheakCacheData:@"2"];
    }
}
- (void)cheakCacheData:(NSString *)type{
    //异步方式
    NSString *key = [type isEqualToString:@"1"] ? yycacheKey : yycacheKey2;
    NSString *name = [type isEqualToString:@"1"] ? yycacheName : yycacheName2;
    YYCache *yyCache=[YYCache cacheWithName:name];
    //根据key读取数据
    [yyCache objectForKey:key withBlock:^(NSString * _Nonnull key, id<NSCoding>  _Nonnull object) {
        HRLog(@"%@",object)
        if (object) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self refreshData:object type:type];
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self getData:type];
            });
        }
    }];
}
- (void)getData:(NSString *)type{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *url = [HttpNetRequestTool requestUrlString:@"/ticket/city"];
    NSDictionary *dict = @{@"type":type};
    [HttpNetRequestTool netRequest:HttpNetRequestPost urlString:url paraments:dict success:^(id Json) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        BaseModel *model = [BaseModel yy_modelWithJSON:Json];
        HRLog(@"%@",Json)
        if (model.code == 1) {
            [self saveCacheData:model.data type:type];
            
        }else{
            [HSToast hsShowBottomWithText:model.msg];
        }
    } failure:^(NSString *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [HSToast hsShowBottomWithText:error];
    }];
}
- (void)saveCacheData:(id)data type:(NSString *)type{
    //异步方式
//    NSString *key=@"CityChinese";
    NSString *key = [type isEqualToString:@"1"] ? yycacheKey : yycacheKey2;
    NSString *name = [type isEqualToString:@"1"] ? yycacheName : yycacheName2;
    YYCache *yyCache=[YYCache cacheWithName:name];
//    //根据key写入缓存value
    [yyCache setObject:data forKey:key withBlock:^{
        NSLog(@"setObject sucess");
    }];
    [self refreshData:data type:type];
}
- (void)refreshData:(id)data type:(NSString *)type{
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSArray *lists = [CityInfo getCityInfoLists:data];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    for (CityInfo *info in lists) {
        NSArray *keys = [dict allKeys];
        NSString *chinese = [info.city_name substringWithRange:NSMakeRange(0, 1)];
        NSMutableString *pinyin = [chinese mutableCopy];
        //将汉字转换为拼音(带音标)
        CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
        //去掉拼音的音标
        CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
        NSMutableString *daxie = [[NSMutableString alloc] initWithString:pinyin];
        NSString *c = [daxie.uppercaseString substringWithRange:NSMakeRange(0, 1)];
        if ([keys containsObject:c]) {
            NSMutableArray *citys = [dict objectForKey:c];
            [citys addObject:info];
            [dict setObject:citys forKey:c];
        }
        else{
            NSMutableArray *oth = [[NSMutableArray alloc] init];
            [oth addObject:info];
            [dict setObject:oth forKey:c];
        }
        if (![self.allDataLists containsObject:info]) {
            [self.allDataLists addObject:info];
        }
    }
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < self.allKeysLists.count; i ++) {
        NSString *keyVale = self.allKeysLists[i];
        NSArray *values = dict[keyVale];
        if (values) {
            [arr addObject:values];
        }else{
            [arr addObject:@[]];
        }
    }
    if ([type isEqualToString:@"1"]) {
        self.dataLists = arr;
        [self.tableView reloadData];
    }else{
        self.otherLists = arr;
        [self.otherTableView reloadData];
    }
//    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
#pragma mark --action
- (void)chinesBtnClick{
    if (self.isInternationl) {
        self.isInternationl = NO;
        self.otherTableView.hidden = YES;
        self.tableView.hidden = NO;
        [self.chinesBtn setTitleColor:[UIColor hdMainColor] forState:UIControlStateNormal];
        self.chinesBtn.backgroundColor = [UIColor whiteColor];
        [self.internationalBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.internationalBtn.backgroundColor = [UIColor hdMainColor];
        if (!(self.dataLists.count > 0)) {
            [self getChinsesData];
        }
    }
}
- (void)internationalBtnClick{
    if (!self.isInternationl) {
        self.isInternationl = YES;
        self.otherTableView.hidden = NO;
        self.tableView.hidden = YES;
        [self.internationalBtn setTitleColor:[UIColor hdMainColor] forState:UIControlStateNormal];
        self.internationalBtn.backgroundColor = [UIColor whiteColor];
        [self.chinesBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.chinesBtn.backgroundColor = [UIColor hdMainColor];
        if (_isSupport) {
            if (!(self.otherLists.count > 0)) {
                [self getInternatonlData];
            }
        }else{
            [HSToast hsShowTopWithText:@"暂不支持"];
        }
    }
}
- (void)searchTextFieldTextDidChanged{
    if (self.searchTextField.text.length > 0) {
        self.searchTableView.hidden = NO;
        self.selectedView.hidden = YES;
    }else{
        self.searchTableView.hidden = YES;
        self.selectedView.hidden = NO;
    }
    [self searchData];
}
- (void)searchData{
    NSMutableArray *lists = [[NSMutableArray alloc] init];
    for (CityInfo *info in self.allDataLists) {
        if ([info.city_name containsString:self.searchTextField.text] || [info.city_code containsString:self.searchTextField.text] || [info.city_py_name containsString:self.searchTextField.text]) {
            [lists addObject:info];
        }
    }
    self.searchDataLists = lists;
    if (self.searchDataLists.count > 0) {
        self.searchLabel.text = nil;
    }else{
        self.searchLabel.text = @"无搜索结果";
    }
    [self.searchTableView reloadData];
}
#pragma mark --UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.searchTableView == tableView) {
        return 1;
    }
    return self.isInternationl ? self.otherLists.count : self.dataLists.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.searchTableView == tableView) {
        return self.searchDataLists.count;
    }
    NSArray *lists = self.isInternationl ? self.otherLists[section] : self.dataLists[section];
    return lists.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static  NSString *const cellID = @"CityChoseCell";
    CityChoseCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:cellID owner:self options:nil] objectAtIndex:0];
    }
    if (self.searchTableView == tableView) {
        cell.info = self.searchDataLists[indexPath.row];
        cell.lineView.hidden = indexPath.row == self.searchDataLists.count - 1;
        cell.selectedImageView.hidden = YES;
    }else{
        NSArray *lists = self.isInternationl ? self.otherLists[indexPath.section] : self.dataLists[indexPath.section];
        CityInfo *info = lists[indexPath.row];
        cell.info = info;
        cell.lineView.hidden = indexPath.row == lists.count - 1;
        if (self.selectedCity && [self.selectedCity.id isEqualToString:info.id]) {
            cell.selectedImageView.hidden = NO;
        }else{
            cell.selectedImageView.hidden = YES;
        }
    }
    return cell;
}
#pragma mark --UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView == self.searchTableView) {
        return [[UIView alloc] init];
    }
    NSArray *lists = self.isInternationl ? self.otherLists[section] : self.dataLists[section];
    if (lists.count > 0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
        view.backgroundColor = [UIColor lightGrayColor];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, view.bounds.size.width - 32, view.bounds.size.height)];
        label.textColor = [UIColor whiteColor];
        label.text = self.allKeysLists[section];
        [view addSubview:label];
        return view;
    }
    return [[UIView alloc] init];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.searchTableView == tableView) {
        return 0;
    }
    NSArray *lists = self.isInternationl ? self.otherLists[section] : self.dataLists[section];
    return lists.count > 0? 30 : 0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.searchTableView == tableView) {
        CityInfo *info = self.searchDataLists[indexPath.row];
        if (self.cityChose) {
            self.cityChose(info);
        }
    }else{
        NSArray *lists = self.isInternationl ? self.otherLists[indexPath.section] : self.dataLists[indexPath.section];
        CityInfo *info = lists[indexPath.row];
        if (self.cityChose) {
            self.cityChose(info);
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark --MJNIndexViewDataSource
- (NSArray *)sectionIndexTitlesForMJNIndexView:(MJNIndexView *)indexView
{
   
    return self.allKeysLists;
}


- (void)sectionForSectionMJNIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    if (self.isInternationl) {
        if (self.otherLists.count > 0) {
            NSArray *lists = self.otherLists[index];
            if (lists.count > 0) {
                [self.otherTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index] atScrollPosition: UITableViewScrollPositionTop animated:YES];
            }
        }
    }else{
        if (self.dataLists.count > 0) {
            NSArray *lists = self.dataLists[index];
            if (lists.count > 0) {
                [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index] atScrollPosition: UITableViewScrollPositionTop animated:YES];
            }
        }
    }
    
}
#pragma mark --load--
- (UIButton *)chinesBtn{
    if (!_chinesBtn) {
        _chinesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _chinesBtn.layer.cornerRadius = 2;
        _chinesBtn.adjustsImageWhenHighlighted = NO;
        [_chinesBtn setTitle:@"国内" forState:UIControlStateNormal];
        [_chinesBtn setTitleColor:[UIColor hdMainColor] forState:UIControlStateNormal];
        _chinesBtn.backgroundColor = [UIColor whiteColor];
        _chinesBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [_chinesBtn addTarget:self action:@selector(chinesBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chinesBtn;
}
- (UIButton *)internationalBtn{
    if (!_internationalBtn) {
        _internationalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _internationalBtn.layer.cornerRadius = 2;
        [_internationalBtn setTitle:@"国际/港澳台" forState:UIControlStateNormal];
        [_internationalBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _internationalBtn.backgroundColor = [UIColor hdMainColor];
        _internationalBtn.adjustsImageWhenHighlighted = NO;
        _internationalBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [_internationalBtn addTarget:self action:@selector(internationalBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _internationalBtn;
}
- (UITableView *)otherTableView{
    if (!_otherTableView) {
        _otherTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _otherTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _otherTableView.backgroundColor = [UIColor whiteColor];
        _otherTableView.showsVerticalScrollIndicator = NO;
        _otherTableView.delegate = self;
        _otherTableView.dataSource = self;
    }
    return _otherTableView;
}
- (UITableView *)searchTableView{
    if (!_searchTableView) {
        _searchTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _searchTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _searchTableView.backgroundColor = [UIColor whiteColor];
        _searchTableView.showsVerticalScrollIndicator = NO;
        _searchTableView.delegate = self;
        _searchTableView.dataSource = self;
    }
    return _searchTableView;
}
- (UILabel *)searchLabel{
    if (!_searchLabel) {
        _searchLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
        _searchLabel.textColor = [UIColor whiteColor];
        _searchLabel.font = [UIFont systemFontOfSize:14.0f];
        _searchLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _searchLabel;
}
- (MJNIndexView *)selectedView{
    if (!_selectedView) {
        _selectedView = [[MJNIndexView alloc] init];
        _selectedView.dataSource = self;
    }
    return _selectedView;
}
- (NSArray *)allKeysLists{
    if (!_allKeysLists) {
        _allKeysLists = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
    }
    return _allKeysLists;
}
- (NSArray *)dataLists{
    if (!_dataLists) {
        _dataLists = [[NSArray alloc] init];
    }
    return _dataLists;
}
- (NSArray *)otherLists{
    if (!_otherLists) {
        _otherLists = [[NSArray alloc] init];
    }
    return _otherLists;
}
- (NSArray *)searchDataLists{
    if (!_searchDataLists) {
        _searchDataLists = [[NSArray alloc] init];
    }
    return _searchDataLists;
}
- (NSMutableArray *)allDataLists{
    if (!_allDataLists) {
        _allDataLists = [[NSMutableArray alloc] init];
    }
    return _allDataLists;
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
