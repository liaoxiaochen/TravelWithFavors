//
//  InternationalCityController.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/14.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "InternationalCityController.h"
#import "CityChoseCell.h"
#import "CityInfo.h"
@interface InternationalCityController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataLists;
@property (nonatomic, strong) NSArray *allKeysLists;

@end

@implementation InternationalCityController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor hdMainColor];
    [self.view addSubview:self.tableView];
    [self getCityData];
}
- (void)getCityData{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *url = [HttpNetRequestTool requestUrlString:@"/ticket/city"];
    NSDictionary *dict = @{@"type":@"2"};
    [HttpNetRequestTool netRequest:HttpNetRequestPost urlString:url paraments:dict success:^(id Json) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        BaseModel *model = [BaseModel yy_modelWithJSON:Json];
        if (model.code == 1) {
            NSArray *lists = [CityInfo getCityInfoLists:model.data];
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            for (CityInfo *info in lists) {
                NSArray *keys = [dict allKeys];
                NSString *chinese = [info.city_name substringWithRange:NSMakeRange(0, 1)];
                NSMutableString *pinyin = [chinese mutableCopy];
                //                //将汉字转换为拼音(带音标)
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
            self.dataLists = arr;
            [self.tableView reloadData];
        }else{
            [HSToast hsShowBottomWithText:model.msg];
        }
    } failure:^(NSString *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [HSToast hsShowBottomWithText:error];
    }];
    
}

#pragma mark --UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataLists.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *lists = self.dataLists[section];
    return lists.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static  NSString *const cellID = @"CityChoseCell";
    CityChoseCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:cellID owner:self options:nil] objectAtIndex:0];
    }
    NSArray *lists = self.dataLists[indexPath.section];
    cell.info = lists[indexPath.row];
    return cell;
}
#pragma mark --UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSArray *lists = self.dataLists[section];
    if (lists.count > 0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 50)];
        view.backgroundColor = [UIColor lightGrayColor];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, view.bounds.size.width - 20, view.bounds.size.height)];
        label.textColor = [UIColor whiteColor];
        label.text = self.allKeysLists[section];
        [view addSubview:label];
        return view;
    }
    return [[UIView alloc] init];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    NSArray *lists = self.dataLists[section];
    return lists.count > 0? 50 : 0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *lists = self.dataLists[indexPath.row];
    NSArray *sec = lists[indexPath.section];
    CityInfo *info = sec[indexPath.row];
    if (self.cityChose) {
        self.cityChose(info);
    }
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark --load--
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT - [AppConfig getNavigationBarHeight] - [AppConfig getButtomHeight] - 40) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor hdMainColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 50;
    }
    return _tableView;
}
- (NSArray *)dataLists{
    if (!_dataLists) {
        _dataLists = [[NSArray alloc] init];
    }
    return _dataLists;
}
- (NSArray *)allKeysLists{
    if (!_allKeysLists) {
        _allKeysLists = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
    }
    return _allKeysLists;
}
- (void)dealloc{
    debugLog(@"移除了了");
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
