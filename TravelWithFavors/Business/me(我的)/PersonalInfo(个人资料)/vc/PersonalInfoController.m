//
//  PersonalInfoController.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/2.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "PersonalInfoController.h"
#import "PersonalInfoCell.h"
#import "HDSelectView.h"
#import <AVFoundation/AVFoundation.h> //相机
#import <Photos/Photos.h> //相册
#import "ChangeNickController.h"
#import "ChangePhoneController.h"
#import "ChangePassWordController.h"
#import "PersonalInfo.h"
#import "IconImageInfo.h"

#import "JPUSHService.h"

static NSString *const cellID = @"PersonalInfoCell";
@interface PersonalInfoController ()<HDSelectViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) NSArray *titleLists;
@property (nonatomic, strong) NSArray *detailLists;
@property (nonatomic, strong) UIImagePickerController *imagePicker;
@end

@implementation PersonalInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"个人资料";
    self.view.backgroundColor = [UIColor hdTableViewBackGoundColor];
    [self conFigView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getUserInfo) name:@"refreshUserInfo" object:nil];
}
- (void)conFigView{
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    self.tableView.tableHeaderView = header;
    
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 170)];
    UIButton *outBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    outBtn.frame = CGRectMake(10, 120, footer.bounds.size.width - 20, 40);
    outBtn.backgroundColor = [UIColor hdMainColor];
    outBtn.layer.cornerRadius = 3;
    [outBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    outBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [outBtn addTarget:self action:@selector(outClick) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:outBtn];
    self.tableView.tableFooterView = footer;
    self.tableView.rowHeight = 50;
//    [self getUserInfo];
}
#pragma mark --data
//个人信息
- (void)getUserInfo{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *url = [HttpNetRequestTool requestUrlString:@"/user"];
    [HttpNetRequestTool netRequestWithHeader:HttpNetRequestPost urlString:url paraments:nil success:^(id Json) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                BaseModel *model = [BaseModel yy_modelWithJSON:Json];
                self.userInfo = [PersonalInfo yy_modelWithJSON:model.data];
                if (model.code == 1) {
                    self.userInfo = [PersonalInfo yy_modelWithJSON:model.data];
                    [self.tableView reloadData];
                    if (self.userInfoBlock) {
                        self.userInfoBlock(self.userInfo);
                    }
                }else{
                    [HSToast hsShowBottomWithText:model.msg];
                }
    } failure:^(NSString *error) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [HSToast hsShowBottomWithText:error];
    }];
}
//修改性别
- (void)changeSex:(NSString *)sex{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *url = [HttpNetRequestTool requestUrlString:@"/user/modify/index"];
    NSDictionary *dict = @{@"field":@"sex",@"value":sex};
    [HttpNetRequestTool netRequestWithHeader:HttpNetRequestPost urlString:url paraments:dict success:^(id Json) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        BaseModel *model = [BaseModel yy_modelWithJSON:Json];
        if (model.code == 1) {
            [self getUserInfo];
        }else{
            [HSToast hsShowBottomWithText:model.msg];
        }
    } failure:^(NSString *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [HSToast hsShowBottomWithText:error];
    }];
}
- (void)uploadIcon:(UIImage *)image{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *url = [HttpNetRequestTool requestUrlString:@"/user/asset/upload"];
    [HttpNetRequestTool uploadHeaderImage:url paraments:nil imageName:@"image" image:image progress:nil success:^(id Json) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
            BaseModel *model = [BaseModel yy_modelWithJSON:Json];
            if (model.code == 1) {
                IconImageInfo *info = [IconImageInfo yy_modelWithJSON:model.data];
                //修改资料
                [self changeInfoIocn:info.save_path];
            }else{
                [HSToast hsShowBottomWithText:model.msg];
            }
    } failure:^(NSString *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [HSToast hsShowBottomWithText:error];
    }];
}
- (void)changeInfoIocn:(NSString *)savePath{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *url = [HttpNetRequestTool requestUrlString:@"/user/modify/index"];
    NSDictionary *dict = @{@"field":@"avatar",@"value":savePath};

    [HttpNetRequestTool netRequestWithHeader:HttpNetRequestPost urlString:url paraments:dict success:^(id Json) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        BaseModel *model = [BaseModel yy_modelWithJSON:Json];
        if (model.code == 1) {
            [self getUserInfo];
        }else{
            [HSToast hsShowBottomWithText:model.msg];
        }
    } failure:^(NSString *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [HSToast hsShowBottomWithText:error];
    }];
}
#pragma mark --退出登录
- (void)outClick{
    HDSelectView *view = [[HDSelectView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT)];
    view.delegate = self;
    view.tag = 1000;
    view.selectedRow = -1;
    [view showSelectView:@[@"退出登录后将不能接收航班动态的消息推送和短息提示",@"退出登录",@"取消"]];
    view.colorLists = @[[UIColor colorWithHexString:@"#333333"],[UIColor colorWithHexString:@"#FF980D"],[UIColor colorWithHexString:@"#2E8BE2"]];
}
#pragma mark --选择
- (void)selectView:(HDSelectView *)view didSelected:(NSInteger)index{
    if (view.tag == 100) {
        switch (index) {
            case 0:
                {
                    //照相
                    [view hide];
                    [self gotoCameraAction];
                }
                break;
            case 1:{
                //相册
                [view hide];
                [self gotoPhotoAction];
            }
                break;
            default:{
                [view hide];
            }
                break;
        }
        return;
    }
    if (view.tag == 1000) {
        //退出登录
        if (index == 1) {
            [view hide];
            debugLog(@"退出");
            [AppConfig setLoginState:NO];
            [AppConfig setLoginID:nil];
            [AppConfig setLoginToken:nil];
            [AppConfig setUserName:nil];
            [AppConfig setPassWord:nil];
            [AppConfig setUserIcon:nil];
            [JPUSHService cleanTags:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
                HRLog(@"iResCode==%ld:标签：%@ 会话序列号：%ld",iResCode,iTags,seq);
            } seq:0];
            
            if (self.loginOutBlock) {
                self.loginOutBlock();
            }
            [self.navigationController popViewControllerAnimated:YES];
            return;
        }
        if (index == 2) {
           [view hide];
            return;
        }
    }
    if (view.tag == 200) {
        if (index == 1) {
            //选择男
            [view hide];
//           self.detailLists = @[@"",@"张某某",@"男",@"13000000000",@""];
//            [self.tableView reloadData];
            [self changeSex:@"1"];
            return;
        }
        if (index == 2) {
//            self.detailLists = @[@"",@"张某某",@"女",@"13000000000",@""];
//            [self.tableView reloadData];
            [self changeSex:@"2"];
            [view hide];
            return;
        }
        if (index == 3) {
            [view hide];
            return;
        }
    }
}
#pragma mark --照相
- (void)gotoCameraAction{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied){
        //无权限 做一个友好的提示
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"请您设置允许APP访问您的相机拍照用以更改头像." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *set = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSString * urlString = UIApplicationOpenSettingsURLString;
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlString]]) {
                if (@available(iOS 10.0, *)) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString] options:@{} completionHandler:nil];
                    
                } else {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
                }
            }
        }];
        [alertVC addAction:set];
        UIAlertAction *cnacel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertVC addAction:cnacel];
        [self presentViewController:alertVC animated:YES completion:nil];
        return ;
    }
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"照相机不可用" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alertVC addAction:cancel];
        [self presentViewController:alertVC animated:YES completion:nil];
        return;
    }
    self.imagePicker.allowsEditing = YES;//设置可编辑
    self.imagePicker.sourceType = sourceType;
    [self presentViewController:self.imagePicker animated:YES completion:nil];//进入照相界面
}
- (void)gotoPhotoAction{
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusRestricted) { // 此应用程序没有被授权访问的照片数据。可能是家长控制权限。
        NSLog(@"因为系统原因, 无法访问相册");
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"无法访问相册" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alertVC addAction:cancel];
        [self presentViewController:alertVC animated:YES completion:nil];
        return;
    }
    if (status == PHAuthorizationStatusDenied) { // 用户拒绝访问相册
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"请您允许APP访问您的相册用以更改头像." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *set = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSString * urlString = UIApplicationOpenSettingsURLString;
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlString]]) {
                if (@available(iOS 10.0, *)) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString] options:@{} completionHandler:nil];
                } else {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
                }
            }
        }];
        [alertVC addAction:set];
        UIAlertAction *cnacel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertVC addAction:cnacel];
        [self presentViewController:alertVC animated:YES completion:nil];
        return;
    }
    if (status == PHAuthorizationStatusAuthorized) { // 用户点击了好
        // 放一些使用相册的代码
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            self.imagePicker.allowsEditing = YES;//设置可编辑
            self.imagePicker.sourceType = sourceType;
            [self presentViewController:self.imagePicker animated:YES completion:nil];//进入照相界面
        });
    }
    if (status == PHAuthorizationStatusNotDetermined){
        //未做出选择
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized) { // 用户点击了好
                // 放一些使用相册的代码
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    self.imagePicker.allowsEditing = YES;//设置可编辑
                    self.imagePicker.sourceType = sourceType;
                    [self presentViewController:self.imagePicker animated:YES completion:nil];//进入照相界面
                });
            }
        }];
    }
}
#pragma mark --UIImagePickerControllerDelegate-相册
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = info[UIImagePickerControllerEditedImage];
//    self.headerImage = image;
//    [self.tableView reloadData];
    [self uploadIcon:image];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark --UITabelViewDataSouce
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleLists.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PersonalInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:cellID owner:self options:nil] objectAtIndex:0];
    }
    if (indexPath.row == 0) {
        cell.iconImageView.hidden = NO;
        cell.rightLabel.hidden = YES;
//        if (self.headerImage) {
//            cell.iconImageView.image = self.headerImage;
//        }
        
        [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString nullString:self.userInfo.avatar dispathString:@""]]];
        
    }
    else{
        if (indexPath.row == 1) {
            cell.rightLabel.text = [NSString nullString:self.userInfo.user_nickname dispathString:@"编辑昵称"];
        }
        if (indexPath.row == 2) {
            if ([self.userInfo.sex isEqualToString:@"1"]) {
                cell.rightLabel.text = @"男";
            }
            else if ([self.userInfo.sex isEqualToString:@"2"]   ){
                cell.rightLabel.text = @"女";
            }else{
                cell.rightLabel.text = @"保密";
            }
        }
        if (indexPath.row == 3) {
            cell.rightLabel.text = [NSString nullString:self.userInfo.mobile dispathString:@""];
        }
        cell.rightLabel.hidden = NO;
        cell.iconImageView.hidden = YES;
    }
    cell.leftLabel.text = self.titleLists[indexPath.row];
    return cell;
}
#pragma mark --UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            //头像
            HDSelectView *view = [[HDSelectView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT)];
            view.isAutoDismiss = YES;
            view.delegate = self;
            view.tag = 100;
            [view showSelectView:@[@"拍照",@"相册选择",@"取消"]];
        }
            break;
        case 1:{
            //昵称
            ChangeNickController *vc = [[ChangeNickController alloc] init];
            __weak typeof(self) weakSelf = self;
            vc.nickName = self.userInfo.user_nickname;
            vc.refreshBlock = ^{
                [weakSelf getUserInfo];
            };
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:{
            //性别
            HDSelectView *view = [[HDSelectView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT)];
            view.delegate = self;
            view.tag = 200;
            if ([self.userInfo.sex isEqualToString:@"1"]) {
                view.selectedRow = 1;
            }else if ([self.userInfo.sex isEqualToString:@"2"]){
                view.selectedRow = 2;
            }else{
                view.selectedRow = -1;
            }
            [view showSelectView:@[@"选择性别",@"男",@"女",@"取消"]];
          view.colorLists = @[[UIColor colorWithHexString:@"#333333"],[UIColor colorWithHexString:@"#2E8BE2"],[UIColor colorWithHexString:@"#2E8BE2"],[UIColor colorWithHexString:@"#2E8BE2"]];
        }
            break;
        case 3:{
            ChangePhoneController *vc = [[ChangePhoneController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:{
            ChangePassWordController *vc = [[ChangePassWordController alloc] init];
            vc.userInfo = self.userInfo;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
    }
}
#pragma mark --load--
- (UIImagePickerController *)imagePicker{
    if (!_imagePicker) {
        _imagePicker = [[UIImagePickerController alloc] init];
        _imagePicker.delegate = self;
    }
    return _imagePicker;
}
- (NSArray *)titleLists{
    if (!_titleLists) {
        _titleLists = @[@"头像",@"昵称",@"性别",@"手机号",@"修改密码"];
    }
    return _titleLists;
}
- (NSArray *)detailLists{
    if (!_detailLists) {
        _detailLists = @[@"",@"张某某",@"女",@"13000000000",@""];
    }
    return _detailLists;
}
#pragma mark --other
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
