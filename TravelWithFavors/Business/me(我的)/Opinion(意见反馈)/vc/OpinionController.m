//
//  OpinionController.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/3.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "OpinionController.h"
#import "PictureViewCell.h"
#import <Photos/Photos.h> //相册
#import "IconImageInfo.h"
static NSString *const cellID = @"PictureViewCell";
@interface OpinionController ()<UITextViewDelegate,PictureViewCellDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) UITextView *opinionTextView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) NSMutableArray *imageLists;
@property (nonatomic, strong) UIImagePickerController *imagePicker;
@end

@implementation OpinionController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"意见反馈";
    [self.opinionTextView addSubview:self.titleLabel];
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 100.0/375.0 * self.tableView.bounds.size.width)];
    header.backgroundColor = [UIColor whiteColor];
    self.opinionTextView.frame = CGRectMake(10, 0, header.bounds.size.width - 20, header.bounds.size.height);
    [header addSubview:self.opinionTextView];
    self.tableView.tableHeaderView = header;
    [self setTableViewFooterView];
}

- (void)setTableViewFooterView{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, footerView.bounds.size.width - 20, 40)];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.cornerRadius = 3;
    bgView.layer.masksToBounds = YES;
    [footerView addSubview:bgView];
    
    UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, bgView.bounds.size.width - 20, bgView.bounds.size.height)];
    phoneLabel.text = [NSString stringWithFormat:@"手机号：%@",self.phone];
    phoneLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    phoneLabel.font = [UIFont systemFontOfSize:14.0f];
    [bgView addSubview:phoneLabel];
    
    UIButton *commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    commitBtn.frame = CGRectMake(10, CGRectGetMaxY(bgView.frame) + 10, footerView.bounds.size.width - 20, 40);
    commitBtn.backgroundColor = [UIColor hdMainColor];
    commitBtn.layer.cornerRadius = 20;
    [commitBtn setTitle:@"提交" forState:UIControlStateNormal];
    commitBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [commitBtn addTarget:self action:@selector(commitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:commitBtn];
    
    self.tableView.tableFooterView = footerView;
}
- (BOOL)canCommit{
    if (self.opinionTextView.text.length <= 0) {
        [HSToast hsShowTopWithText:@"请输入您的意见"];
        [self.opinionTextView becomeFirstResponder];
        return NO;
    }
    return YES;
}
- (void)commitBtnClick{
    if ([self canCommit]) {
        if (self.imageLists.count > 0) {
            //提交图片
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            NSString *imageUrl = [HttpNetRequestTool requestUrlString:@"/user/asset/upload"];
            dispatch_group_t group = dispatch_group_create();
            __block NSMutableArray *imgLists = [[NSMutableArray alloc] init];
            for (NSInteger i = 0; i < self.imageLists.count; i ++) {
               dispatch_group_enter(group); dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0),^{
                    
                    UIImage *imagePic = self.imageLists[i];
                   [HttpNetRequestTool uploadHeaderImage:imageUrl paraments:@{@"type":@"memberMessage"} imageName:@"image" image:imagePic progress:nil success:^(id Json) {
                        BaseModel *model = [BaseModel yy_modelWithJSON:Json];
                        if (model.code == 1) {
                            IconImageInfo *info = [IconImageInfo yy_modelWithJSON:model.data];
                            [imgLists addObject:info];
                        }                        dispatch_group_leave(group);
                    } failure:^(NSString *error) {
                        dispatch_group_leave(group);
                    }];
                });
            } dispatch_group_notify(group,dispatch_get_main_queue(),^{
                //执行最终的特定操作
                if (imgLists.count > 0) {
                    NSString *s = @"";
                    for (NSInteger i = 0; i < imgLists.count; i ++) {
                        IconImageInfo *info = imgLists[i];
                        s = [NSString stringWithFormat:@"%@,%@",s,info.save_path];
                    }
                    s = [s substringFromIndex:1];
                    [self addSuggetionWithPicture:s];
                }else{
                    [self addSugeetion];
                }
            });
            
        }else{
            [self addSugeetion];
        }
    }
}
- (void)addSuggetionWithPicture:(NSString *)picture{
    NSString *url = [HttpNetRequestTool requestUrlString:@"/user/opinion"];
    NSDictionary *dic = @{@"content":self.opinionTextView.text,@"telphone":self.phone,@"imglist":picture};
    [HttpNetRequestTool netRequestWithHeader:HttpNetRequestPost urlString:url paraments:dic success:^(id Json) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        BaseModel *model = [BaseModel yy_modelWithJSON:Json];
        [HSToast hsShowBottomWithText:model.msg];
        if (model.code == 1) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSString *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [HSToast hsShowBottomWithText:error];
    }];
}
- (void)addSugeetion{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *url = [HttpNetRequestTool requestUrlString:@"/user/opinion"];
    NSDictionary *dict = @{@"content":self.opinionTextView.text,@"telphone":self.phone};
    [HttpNetRequestTool netRequestWithHeader:HttpNetRequestPost urlString:url paraments:dict success:^(id Json) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        BaseModel *model = [BaseModel yy_modelWithJSON:Json];
        [HSToast hsShowBottomWithText:model.msg];
        if (model.code == 1) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSString *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [HSToast hsShowBottomWithText:error];
    }];
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
#pragma mark --PictureViewCellDelegate删除
- (void)deleteImageAtIndex:(NSInteger)index{
    if (index == self.imageLists.count) {
        //添加
        [self gotoPhotoAction];
    }else{
        //删除
        [self.imageLists removeObjectAtIndex:index];
        [self.tableView reloadData];
    }
}
#pragma mark --UIImagePickerControllerDelegate-相册
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = info[UIImagePickerControllerEditedImage];
    if (image) {
        [self.imageLists addObject:image];
    }
    [self.tableView reloadData];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark --UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView{
    self.titleLabel.hidden = textView.text.length > 0;
}
#pragma mark --UITableViewDataSouce
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PictureViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[PictureViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.imageLists = self.imageLists;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [PictureViewCell cellHeight:self.imageLists];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0f;
}
#pragma mark --load--
- (UIImagePickerController *)imagePicker{
    if (!_imagePicker) {
        _imagePicker = [[UIImagePickerController alloc] init];
        _imagePicker.delegate = self;
    }
    return _imagePicker;
}
- (UITextView *)opinionTextView{
    if (!_opinionTextView) {
        _opinionTextView = [[UITextView alloc] init];
        _opinionTextView.delegate = self;
        _opinionTextView.font = [UIFont systemFontOfSize:14.0f];
    }
    return _opinionTextView;
}
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(6, 7, 100, 16)];
        _titleLabel.text = @"输入您的建议...";
        _titleLabel.font = [UIFont systemFontOfSize:14.0f];
        _titleLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    }
    return _titleLabel;
}
- (NSMutableArray *)imageLists{
    if (!_imageLists) {
        _imageLists = [[NSMutableArray alloc] init];
    }
    return _imageLists;
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
