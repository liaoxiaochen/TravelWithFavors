//
//  MeSetController.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/3.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "MeSetController.h"
#import "PersonalSetCell.h"
#import "NotifiSetController.h"
#import "AboutUsController.h"
static NSString *const cellID = @"PersonalSetCell";
@interface MeSetController ()
@property (nonatomic, strong) NSArray *titleLists;
@property (nonatomic, strong) NSArray *detailLists;
@end

@implementation MeSetController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"设置";
    self.tableView.rowHeight = 50;
}
#pragma mark --UITableViewDataSouce
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.titleLists.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *lists = self.titleLists[section];
    return lists.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PersonalSetCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:cellID owner:self options:nil] objectAtIndex:0];
    }
    NSArray *left = self.titleLists[indexPath.section];
    NSArray *right = self.detailLists[indexPath.section];
    if (indexPath.row == 0 && indexPath.section == 0) {
//        [[UIApplication sharedApplication] isRegisteredForRemoteNotifications];
         UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
        if (UIUserNotificationTypeNone == setting.types) {
            cell.rightLabel.text = @"已关闭";
        }else{
            cell.rightLabel.text = @"已经开启";
        }
    }else{
        cell.rightLabel.text = right[indexPath.row];
    }
    cell.leftLabel.text = left[indexPath.row];
    return cell;
}

#pragma mark --UITbaleViewDlegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            //开启通知
            NotifiSetController *vc = [[NotifiSetController alloc] init];
            vc.updateBlock = ^{
                [self.tableView reloadData];
            };
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            //清除缓存
            [self clearFile];
        }
    }else{
        //关于我们
        AboutUsController *vc = [[AboutUsController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
//MARK:清理缓存
- (NSString *)getHuanCunData{
    CGFloat size = [self folderSizeAtPath:[NSSearchPathForDirectoriesInDomains (NSCachesDirectory , NSUserDomainMask , YES) firstObject]];
    //fileSize是封装在Category中的。
    
    size += [SDImageCache sharedImageCache].getSize;   //CustomFile + SDWebImage 缓存
    
    //设置文件大小格式
    NSString *sizeText = nil;
    if (size >= pow(10, 9)) {
        sizeText = [NSString stringWithFormat:@"%.2fGB", size / pow(10, 9)];
    }else if (size >= pow(10, 6)) {
        sizeText = [NSString stringWithFormat:@"%.2fMB", size / pow(10, 6)];
    }else if (size >= pow(10, 3)) {
        sizeText = [NSString stringWithFormat:@"%.2fKB", size / pow(10, 3)];
    }else {
        sizeText = [NSString stringWithFormat:@"%zdB", size];
    }
    return nil;
}
//1. 获取缓存文件的大小
-(float)readCacheSize
{
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains (NSCachesDirectory , NSUserDomainMask , YES) firstObject];
    CGFloat size = [ self folderSizeAtPath :cachePath];
    size += [SDImageCache sharedImageCache].getSize / 1000.0 / 1000.0;
    return size;
}
//2. 清除缓存
- (void)clearFile
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"清除缓存中...";
    //读取缓存大小
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            NSString * cachePath = [NSSearchPathForDirectoriesInDomains (NSCachesDirectory , NSUserDomainMask , YES ) firstObject];
            NSArray * files = [[NSFileManager defaultManager ] subpathsAtPath :cachePath];
            //NSLog ( @"cachpath = %@" , cachePath);
            for ( NSString * p in files) {
                NSError * error = nil ;
                //获取文件全路径
                NSString * fileAbsolutePath = [cachePath stringByAppendingPathComponent :p];
                if ([[NSFileManager defaultManager ] fileExistsAtPath :fileAbsolutePath]) {
                    [[NSFileManager defaultManager ] removeItemAtPath :fileAbsolutePath error :&error];
                }
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [hud hideAnimated:YES];
                // 设置文字
                self.detailLists = @[@[@"已经开启",[NSString stringWithFormat:@"%.1fMB",[self readCacheSize]]],@[@""]];
                [self.tableView reloadData];
            });
        });
        
    }];
}
//由于缓存文件存在沙箱中，我们可以通过NSFileManager API来实现对缓存文件大小的计算。
// 遍历文件夹获得文件夹大小，返回多少 M
- (float)folderSizeAtPath:( NSString *) folderPath{
    
    NSFileManager * manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath :folderPath]) return 0 ;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath :folderPath] objectEnumerator];
    NSString * fileName;
    long long folderSize = 0 ;
    while ((fileName = [childFilesEnumerator nextObject]) != nil ){
        //获取文件全路径
        NSString * fileAbsolutePath = [folderPath stringByAppendingPathComponent :fileName];
        folderSize += [ self fileSizeAtPath :fileAbsolutePath];
    }
    
    return folderSize/( 1024.0 * 1024.0);
    
}
// 计算 单个文件的大小
- (long long) fileSizeAtPath:( NSString *) filePath{
    NSFileManager * manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath :filePath]){
        return [[manager attributesOfItemAtPath :filePath error : nil] fileSize];
    }
    return 0;
}
#pragma mark --laod--
- (NSArray *)titleLists{
    if (!_titleLists) {
        _titleLists = @[@[@"通知提醒",@"清除缓存"],@[@"关于我们"]];
    }
    return _titleLists;
}
- (NSArray *)detailLists{
    if (!_detailLists) {
        _detailLists = @[@[@"已经开启",[NSString stringWithFormat:@"%.1fMB",[self readCacheSize]]],@[@""]];
    }
    return _detailLists;
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
