//
//  ApplyAftersaleViewController.m
//  TravelWithFavors
//
//  Created by MacBook on 2018/8/24.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "ApplyAftersaleViewController.h"
#import "ApplyAfterSalesTypeView.h"
#import "MallOrderGoodsTableViewCell.h"
#import "ApplyTextFieldTableViewCell.h"
#import "ApplyDescribeView.h"
#import "TZImagePickerController.h"


#define CCWeakSelf __weak typeof(self) weakSelf = self;

@interface ApplyAftersaleViewController ()<AppleDescribeViewDelegate, TZImagePickerControllerDelegate>

@property (nonatomic, strong) NSArray *contactArr;

@property(nonatomic,strong)NSMutableArray *photos;

@property (nonatomic, strong) ApplyDescribeView *describeView;

@end

@implementation ApplyAftersaleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"申请售后";
    self.contactArr = @[@"联系人：", @"联系电话："];
    [self.tableView registerNib:[UINib nibWithNibName:@"MallOrderGoodsTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MallOrderGoodsTableViewCell"];
    [self.tableView registerClass:[ApplyTextFieldTableViewCell class] forCellReuseIdentifier:@"ApplyTextFieldTableViewCell"];
    
}
//进入相册的方法:
- (void)describeViewGetPhoto{
    
    CCWeakSelf;
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9-weakSelf.photos.count delegate:weakSelf];
    imagePickerVc.maxImagesCount = 6;//最小照片必选张数,默认是0
    imagePickerVc.sortAscendingByModificationDate = NO;// 对照片排序，按修改时间升序，默认是YES。如果设置为NO,最新的照片会显示在最前面，内部的拍照按钮会排在第一个
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets,BOOL isSelectOriginalPhoto){
        NSLog(@"选中图片photos === %@",photos);
        [weakSelf.photos addObjectsFromArray:photos];
        [self.describeView.publishPhotosView reloadDataWithImages:weakSelf.photos];
    }];
        [weakSelf presentViewController:imagePickerVc animated:YES completion:nil];
}

- (NSMutableArray *)photos{
    if (_photos == nil) {
        _photos = [[NSMutableArray alloc]init];
    }
    return _photos;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        
        MallOrderGoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MallOrderGoodsTableViewCell"];
        cell.showNumLabel = YES;

        return cell;
    }
    ApplyTextFieldTableViewCell *tfCell = [tableView dequeueReusableCellWithIdentifier:@"ApplyTextFieldTableViewCell"];
    tfCell.leftLabel.text = self.contactArr[indexPath.row];
    tfCell.rightTf.text = @[@"携宠", @"18888888888"][indexPath.row];
    return tfCell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        ApplyAfterSalesTypeView *vc = [[ApplyAfterSalesTypeView alloc] init];
          return vc;
    }else {
        UIView *v = [[UIView alloc] init];
        v.backgroundColor = [UIColor hdTableViewBackGoundColor];
        return v;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 0) {
        self.describeView = [[ApplyDescribeView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300)];
         self.describeView.delegate = self;
        return self.describeView;
    }else {
        UIView *backV = [[UIView alloc] init];
        UILabel *v = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH - 20, 0)];
        v.backgroundColor = [UIColor hdTableViewBackGoundColor];
        v.text = @"提交售后后，售后专员可能与您电话沟通，请保持手机通畅";
        CGFloat vHeig = [UILabel getLabelHeightWithText:v.text width:SCREEN_WIDTH - 20 font:12];
        v.frame = CGRectMake(10, 10, SCREEN_WIDTH - 20, vHeig);
        v.numberOfLines = 0;
        v.textColor = [UIColor hdTipTextColor];
        v.font = [UIFont systemFontOfSize:12];
        [backV addSubview:v];
        return backV;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 100;
    }else {
        return 40;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 100;
    }
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return 300;
    }
    return 60;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return self.contactArr.count;
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
