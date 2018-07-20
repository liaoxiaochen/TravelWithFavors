//
//  MyPetController.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/4.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "MyPetController.h"
#import "NotifiSetCell.h"
#import "MyPetNormalCell.h"
#import "HRPetTipsCell.h"
#import "HDDateSelctedView.h"
#import "PetNickNameController.h"
#import <AVFoundation/AVFoundation.h> //相机
#import <Photos/Photos.h> //相册
#import "HDSelectView.h"
#import "PetBoxView.h"
#import "PetWeightController.h"
#import "MyPetChoseCell.h"
#import "MyPetInfo.h"
#import "IconImageInfo.h"
static NSString *const swithCellID = @"NotifiSetCell";
static NSString *const cellID = @"MyPetNormalCell";
static NSString *const choseCellID = @"MyPetChoseCell";
static NSString *const petTipsCellID = @"HRPetTipsCell";
@interface MyPetController ()<HDSelectViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) NSArray *titleLists;
@property (nonatomic, strong) NSArray *detailLists;
@property (nonatomic, strong) UIImagePickerController *imagePicker;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *box_long;
@property (nonatomic, copy) NSString *box_hight;
@property (nonatomic, copy) NSString *box_width;
@property (nonatomic, copy) NSString *isShort;//是否是长鼻
@property (nonatomic, copy) NSString *weight;
@property (nonatomic, strong) UIImage *iconImage;
@end

@implementation MyPetController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的宠物";
    self.tableView.rowHeight = 50;
    if (!self.petInfo) {
        self.isShort = @"2";
        self.type = @"1";
    }
    [self setTableViewHeader];
    [self setRightItem];
    if (self.petInfo) {
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.petInfo.avatar]] placeholderImage:self.iconImage];
    }
}
- (void)setTableViewHeader{
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 140)];
    header.backgroundColor = [UIColor hdMainColor];
    
    self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake((header.bounds.size.width - 90)/2, 8, 90, 90)];
    self.iconImageView.layer.cornerRadius = self.iconImageView.bounds.size.width/2;
    self.iconImageView.layer.masksToBounds = YES;
    self.iconImageView.image = self.iconImage;
    self.iconImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(petIconTap)];
    [self.iconImageView addGestureRecognizer:tap];
    [header addSubview:self.iconImageView];
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.iconImageView.frame) + 10, header.bounds.size.width - 20, 16)];
    self.nameLabel.text = self.name;
    self.nameLabel.textColor = [UIColor whiteColor];
    self.nameLabel.font = [UIFont systemFontOfSize:14.0f];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    [header addSubview:self.nameLabel];
    
    self.tableView.tableHeaderView = header;
}
- (void)setRightItem{
    if (!self.petInfo) {
        //没有宠物
        //创建一个 UIBarButtonItem
        UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(rightBtnClick)];
        //设置 BarButtonItem 富文本信息
        [right setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0f],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#ffffff"]} forState:UIControlStateNormal];
        [right setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0f],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#ffffff"]} forState:UIControlStateHighlighted];
        //设置 偏移
        [right setTitlePositionAdjustment:UIOffsetMake(6, 0) forBarMetrics:UIBarMetricsDefault];
        self.navigationItem.rightBarButtonItem = right;
    }
}
#pragma mark --新增宠物
- (BOOL)canAdd{
    if (!self.iconImage) {
        [HSToast hsShowBottomWithText:@"请选择宠物头像"];
        return NO;
    }
    if (!self.name) {
        [HSToast hsShowBottomWithText:@"请填写宠物昵称"];
        return NO;
    }
    if (!self.date) {
        [HSToast hsShowBottomWithText:@"请填写宠物生日"];
        return NO;
    }
    if (!self.weight) {
        [HSToast hsShowBottomWithText:@"请填写宠物体重"];
        return NO;
    }
    if (!self.box_long || !self.box_hight || !self.box_width) {
        [HSToast hsShowBottomWithText:@"请填写航空箱大小"];
        return NO;
    }
    return YES;
}
//上传头像
- (void)rightBtnClick{
    if ([self canAdd]) {
        [self uploadIocn];
    }
}
- (void)uploadIocn{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *url = [HttpNetRequestTool requestUrlString:@"/user/asset/upload"];
    [HttpNetRequestTool uploadHeaderImage:url paraments:nil imageName:@"image" image:self.iconImage progress:^(float progress) {
        
    } success:^(id Json) {
        BaseModel *model = [BaseModel yy_modelWithJSON:Json];
        if (model.code == 1) {
            IconImageInfo *info = [IconImageInfo yy_modelWithJSON:model.data];
            [self addAction:info.save_path];
        }else{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [HSToast hsShowBottomWithText:model.msg];
        }
    } failure:^(NSString *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [HSToast hsShowBottomWithText:error];
    }];
}
//添加
- (void)addAction:(NSString *)savePath{
    NSString *url = [HttpNetRequestTool requestUrlString:@"/user/pet/add"];
    NSDictionary *dict = @{@"pet_name":self.name,@"avatar":savePath,@"birthday":[NSDate getDate:self.date formart:@"yyyy-MM-dd"],@"weight":self.weight,@"box_length":self.box_long,@"box_height":self.box_hight,@"box_width":self.box_width,@"pet_type":self.type,@"is_short":self.isShort};
    [HttpNetRequestTool netRequestWithHeader:HttpNetRequestPost urlString:url paraments:dict success:^(id Json) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        BaseModel *model = [BaseModel yy_modelWithJSON:Json];
        if (model.code == 1) {
            if (self.refreshPet) {
                self.refreshPet();
            }
            if (self.petDataBlock) {
                MyPetInfo *info = [MyPetInfo yy_modelWithJSON:model.data];
                self.petDataBlock(info);
            }
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [HSToast hsShowBottomWithText:model.msg];
        }
    } failure:^(NSString *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [HSToast hsShowBottomWithText:error];
    }];
}
//修改
- (void)changeIocn{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *url = [HttpNetRequestTool requestUrlString:@"/user/asset/upload"];
    [HttpNetRequestTool uploadHeaderImage:url paraments:nil imageName:@"image" image:self.iconImage progress:^(float progress) {
        
    } success:^(id Json) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        BaseModel *model = [BaseModel yy_modelWithJSON:Json];
        if (model.code == 1) {
            IconImageInfo *info = [IconImageInfo yy_modelWithJSON:model.data];
            [self changeInfo:@"avatar" value:info.save_path];
        }else{
            [HSToast hsShowBottomWithText:model.msg];
        }
    } failure:^(NSString *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [HSToast hsShowBottomWithText:error];
    }];
}
- (void)changeInfo:(NSString *)field value:(NSString *)value{
    __weak typeof(self) weakSelf = self;
    [MBProgressHUD showHUDAddedTo:weakSelf.view animated:YES];
    NSString *url = [HttpNetRequestTool requestUrlString:@"/user/pet/edit"];
    NSDictionary *dict = @{@"pet_id":self.petInfo.id,@"field":field,@"value":value};
    [HttpNetRequestTool netRequestWithHeader:HttpNetRequestPost urlString:url paraments:dict success:^(id Json) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        BaseModel *model = [BaseModel yy_modelWithJSON:Json];
        if (model.code == 1) {
            if (weakSelf.refreshPet) {
                weakSelf.refreshPet();
            }
            if ([field isEqualToString:@"avatar"]) {
                weakSelf.iconImageView.image = weakSelf.iconImage;
            }else{
               [weakSelf.tableView reloadData];
            }
            if ([@"pet_name" isEqualToString:field]) {
                weakSelf.name = value;
                weakSelf.nameLabel.text = value;
                [weakSelf.tableView reloadData];
            }
        }else{
            [HSToast hsShowBottomWithText:model.msg];
        }
    } failure:^(NSString *error) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [HSToast hsShowBottomWithText:error];
    }];
}
//修改照片
- (void)petIconTap{
    HDSelectView *view = [[HDSelectView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT)];
//    view.isAutoDismiss = YES;
    view.delegate = self;
    [view showSelectView:@[@"拍摄照片",@"选择照片",@"取消"]];
}
#pragma mark --选择
- (void)selectView:(HDSelectView *)view didSelected:(NSInteger)index{
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
    self.iconImage = image;
    if (self.petInfo) {
        //修改
        [self changeIocn];
    }else{
       self.iconImageView.image = image;
//    [self.tableView reloadData];
    }
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark --setter
- (void)setPetInfo:(MyPetInfo *)petInfo{
    _petInfo = petInfo;
    self.date = [NSDate getDateTime:petInfo.birthday formart:@"yyyy-MM-dd"];
    self.name = [NSString nullString:petInfo.pet_name dispathString:@""];
    self.box_long = petInfo.box_length;
    self.box_width = petInfo.box_width;
    self.box_hight = petInfo.box_height;
    self.weight = petInfo.weight;
    self.type = petInfo.pet_type;
    //是否为短鼻猫狗 1-是 2-不是
    self.isShort = petInfo.is_short;
}
#pragma mark --UITableViewDataSouce
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.titleLists.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == self.titleLists.count - 1) {
        return 2;
    }
    NSArray *lists = self.titleLists[section];
    return lists.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *lists = self.titleLists[indexPath.section];
    if (indexPath.section == 0) {
        if (indexPath.row == 3) {
            MyPetChoseCell *cell = [tableView dequeueReusableCellWithIdentifier:choseCellID];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:choseCellID owner:self options:nil] objectAtIndex:0];
            }
            __weak typeof(self) weakSelf = self;
            cell.choseBlock = ^(NSString *type) {
                weakSelf.type = type;
                if (weakSelf.petInfo) {
                    [weakSelf changeInfo:@"pet_type" value:weakSelf.type];
                }else{
                    [weakSelf.tableView reloadData];
                }
            };
            cell.petType = self.type;
            return cell;
        }
    }
    if (indexPath.section == self.titleLists.count - 1) {
        if (indexPath.row == 1) {
            HRPetTipsCell *cell = [tableView dequeueReusableCellWithIdentifier:petTipsCellID];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:petTipsCellID owner:self options:nil] objectAtIndex:0];
            }
            return cell;
        }
        NotifiSetCell *cell = [tableView dequeueReusableCellWithIdentifier:swithCellID];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:swithCellID owner:self options:nil] objectAtIndex:0];
        }
        
        cell.titleLabel.text = lists[indexPath.row];
        cell.typeSwitch.enabled = NO;
        __weak typeof(self) weakSelf = self;
        cell.teudb = ^(BOOL switchIsOpen) {
            weakSelf.isShort = switchIsOpen ? @"2" : @"1";
            if (weakSelf.petInfo) {
                [weakSelf changeInfo:@"is_short" value:weakSelf.isShort];
            }
        };
        cell.typeSwitch.on = [self.isShort isEqualToString:@"2"];
        return cell;
    }
    MyPetNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:cellID owner:self options:nil] objectAtIndex:0];
    }
    cell.titleLabel.text = lists[indexPath.row];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.detailLabel.text = self.name;
            cell.rightImageView.hidden = self.name.length > 0;
        }
        if (indexPath.row == 1) {
            
            cell.detailLabel.text = self.date;
            cell.rightImageView.hidden = self.date.length > 0;
        }
        if (indexPath.row == 2) {
            if (self.weight) {
                cell.detailLabel.text = [NSString stringWithFormat:@"%@kg",self.weight];
                cell.rightImageView.hidden = YES;
            }else{
                cell.rightImageView.hidden = NO;
            }
        }
    }else{
        if (self.box_long && self.box_width && self.box_hight) {
            cell.detailLabel.text = [NSString stringWithFormat:@"%@cm,%@cm,%@cm",self.box_long,self.box_width,self.box_hight];
            cell.rightImageView.hidden = YES;
        }else{
            cell.rightImageView.hidden = NO;
        }
        
    }
    return cell;
}
#pragma mark --UITableViewDelegate-
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == self.titleLists.count - 1 && indexPath.row == 1) {
        return 70;
    }
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y < 0) {
        scrollView.contentOffset = CGPointMake(0, 0);
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            //名字
            PetNickNameController *vc = [[PetNickNameController alloc] init];
            __weak typeof(self) weakSelf = self;
            vc.nickBlock = ^(NSString *nickName) {
                if (weakSelf.petInfo) {
                    [weakSelf changeInfo:@"pet_name" value:nickName];
                }else{
                    weakSelf.name = nickName;
                    weakSelf.nameLabel.text = nickName;
                    [weakSelf.tableView reloadData];
                }
            };
            vc.nickName = self.nameLabel.text;
            [self.navigationController pushViewController:vc animated:YES];
            return;
        }
        if (indexPath.row == 1) {
            HDDateSelctedView *view = [[HDDateSelctedView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT)];
            [view showHDDateSelctedView];
            __weak typeof(self) weakSelf = self;
            view.birthBlocl = ^(NSString *year, NSString *month, NSString *day) {
                weakSelf.date = [NSString stringWithFormat:@"%@-%@-%@",year,month,day];
                if (weakSelf.petInfo) {
                    [weakSelf changeInfo:@"birthday" value:[NSDate getDate:weakSelf.date formart:@"yyyy-MM-dd"]];
                }else{
                    [weakSelf.tableView reloadData];
                }
            };
            return;
        }
        if (indexPath.row == 2) {
            //体重
            PetWeightController *vc = [[PetWeightController alloc] init];
            __weak typeof(self) weakSelf = self;
            vc.weightBlock = ^(NSString *weight) {
                weakSelf.weight = weight;
                if (weakSelf.petInfo) {
                    [weakSelf changeInfo:@"weight" value:weakSelf.weight];
                }else{
                    [weakSelf.tableView reloadData];
                }
            };
            vc.weight = weakSelf.weight;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    if (indexPath.section == 1) {
        //箱子
        PetBoxView *view = [[[NSBundle mainBundle] loadNibNamed:@"PetBoxView" owner:self options:nil] objectAtIndex:0];
        view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT);
        view.changTextField.text = self.box_long;
        view.kuanTextField.text = self.box_width;
        view.gaoTextField.text = self.box_hight;
        [view showPetBoxView];
        __weak typeof(self) weakSelf = self;
        view.boxBlock = ^(NSString *chang, NSString *kuan, NSString *gao) {
            weakSelf.box_long = chang;
            weakSelf.box_width = kuan;
            weakSelf.box_hight = gao;
            if (weakSelf.petInfo) {
                NSString *mutStr = [NSString stringWithFormat:@"box_length=%@|box_height=%@|box_width=%@",chang,gao,kuan];
               
                [weakSelf changeInfo:@"hkx" value:mutStr];
            }else{
                [weakSelf.tableView reloadData];
            }
            
        };
        return;
    }

}
#pragma mark --laod--
- (UIImagePickerController *)imagePicker{
    if (!_imagePicker) {
        _imagePicker = [[UIImagePickerController alloc] init];
        _imagePicker.delegate = self;
    }
    return _imagePicker;
}
- (NSArray *)titleLists{
    if (!_titleLists) {
        _titleLists = @[@[@"宠物名字",@"宠物生日",@"宠物体重",@"宠物品种"],@[@"航空箱大小"],@[@"非短鼻猫短鼻狗"]];
    }
    return _titleLists;
}
- (NSArray *)detailLists{
    if (!_detailLists) {
        _detailLists = @[@[@"",@"",@"",@""],@[@""],@[@""]];
    }
    return _detailLists;
}
- (UIImage *)iconImage{
    if (!_iconImage) {
        _iconImage = [UIImage imageNamed:@"cw_tx"];
    }
    return _iconImage;
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
