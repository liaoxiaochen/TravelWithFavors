//
//  NotifiSetController.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/3.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "NotifiSetController.h"
#import "NotifiSetCell.h"
#import <UserNotifications/UserNotifications.h>//判断推送
static NSString *const cellID = @"NotifiSetCell";
@interface NotifiSetController ()
@property (nonatomic, strong) NSArray *titleLists;
@end

@implementation NotifiSetController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"通知提醒";
    self.view.backgroundColor = [UIColor hdTableViewBackGoundColor];
    self.tableView.rowHeight = 50;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(application) name:@"applicationWillEnterForeground" object:nil];
}
- (void)application{
    [self.tableView reloadData];//刷新表
}
#pragma mark --UITableViewDataSouce
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.titleLists.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *lis = self.titleLists[section];
    return lis.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NotifiSetCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:cellID owner:self options:nil] objectAtIndex:0];
    }
    NSArray *lis = self.titleLists[indexPath.section];
    cell.titleLabel.text = lis[indexPath.row];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {//推送
            UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
            cell.typeSwitch.on = !(UIUserNotificationTypeNone == setting.types);
        }else{//声音
            UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
            cell.typeSwitch.on = (UIUserNotificationTypeSound & setting.types);
        }
    }else{//震动
        cell.typeSwitch.on = [AppConfig getVibrate];
    }
    cell.teudb = ^(BOOL switchIsOpen){
        NSLog(@"点击的行数---%ld",indexPath.row);
        [self opentype:indexPath isOn:switchIsOpen];
    };
    return cell;
}
- (void)openNotifiCenter{
    NSString * urlString = UIApplicationOpenSettingsURLString;
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlString]]) {
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString] options:@{} completionHandler:nil];
        } else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
        }
        if (self.updateBlock) {
            self.updateBlock();
        }
    }
}
#pragma mark --UITableviewDelegate

#pragma mark -- NotifiSetCellDelegate
- (void)opentype:(NSIndexPath *)path isOn:(BOOL)open{
    if (path.section == 0) {
        if (path.row == 0) {//推送
            if (open) {
                debugLog(@"打开");
                [self openNotifiCenter];
            }else{
                debugLog(@"关闭");
                UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"是否要关闭通知，关闭后将不能接受到通知信息" message:nil preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    [self.tableView reloadData];
                }];
                UIAlertAction *close = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self openNotifiCenter];
                }];
                [alertVC addAction:cancel];
                [alertVC addAction:close];
                [self presentViewController:alertVC animated:YES completion:nil];
            }
        }else{//声音
            [self openNotifiCenter];
        }
    }else{//震动
        [AppConfig setVibrate:open];
    }
}
#pragma mark --load--
- (NSArray *)titleLists{
    if (!_titleLists) {
        _titleLists = @[@[@"接收航班信息通知",@"声音"],@[@"震动"]];
    }
    return _titleLists;
}
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
