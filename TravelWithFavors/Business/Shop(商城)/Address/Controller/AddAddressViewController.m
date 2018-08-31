//
//  AddAddressViewController.m
//  TravelWithFavors
//
//  Created by MacBook on 2018/8/21.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "AddAddressViewController.h"
#import "CZHAddressPickerView.h"
#import "AddressPickerHeader.h"
#import "EditAddressTableViewCell.h"
#import "SwitchTableViewCell.h"
#import "AddressInfoModel.h"

@interface AddAddressViewController ()<UITextFieldDelegate>


@property (nonatomic, strong) NSDictionary *provinceDic;
@property (nonatomic, strong) NSDictionary *cityDic;
@property (nonatomic, strong) NSDictionary *areaDic;

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *is_default;

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSArray *placeholdArray;
@property (nonatomic, strong) NSMutableArray *contentArray;

@end

@implementation AddAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataArray = @[@"收货人",@"联系方式",@"所在地区",@"详细地址",@"邮编"];
    self.placeholdArray = @[@"姓名",@"电话号码",@"",@"详细地址需要填写楼栋楼层等信息",@"邮编"];
    self.contentArray =  [@[@"",@"",@"",@"",@""] mutableCopy];
    self.is_default = @"0";
    
    if (self.infoModel) {
        self.title = @"编辑收货地址";
        self.is_default = self.infoModel.is_default;
        
        self.provinceDic = @{@"province_id":self.infoModel.province_id, @"province":self.infoModel.province};
        self.cityDic = @{@"city_id":self.infoModel.city_id, @"city":self.infoModel.city};
        self.areaDic = @{@"area_id":self.infoModel.area_id, @"area":self.infoModel.area};
        
        NSString *str = [NSString stringWithFormat:@"%@%@%@", self.provinceDic[@"province"], self.cityDic[@"city"], self.areaDic[@"area"]];
 
        self.contentArray =  [@[[self valiudeString:self.infoModel.name],[self valiudeString:self.infoModel.mobile], str,[self valiudeString:self.infoModel.address],[self valiudeString:self.infoModel.code]] mutableCopy];

    }else {
        self.title = @"添加收货地址";
        
    }
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    saveBtn.frame = CGRectMake(0, 0, 40, 30);
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    saveBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [saveBtn addTarget:self action:@selector(saveAddree) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:saveBtn];
 
    [self.tableView registerClass:[EditAddressTableViewCell class] forCellReuseIdentifier:@"EditAddressTableViewCell"];
    [self.tableView registerClass:[SwitchTableViewCell class] forCellReuseIdentifier:@"SwitchTableViewCell"];

 
}

- (NSString *)valiudeString:(NSString *)valiudeStr {
    if (!valiudeStr) {
        return @"";
    }
    return valiudeStr;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.dataArray.count;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        
        EditAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EditAddressTableViewCell"];
        cell.tipLabel.text = self.dataArray[indexPath.row];
        cell.contentTf.placeholder = self.placeholdArray[indexPath.row];
        cell.contentTf.delegate = self;
        
        
        if (indexPath.row == 2) {
            cell.seletAreaBtn.hidden = NO;
            [cell.seletAreaBtn addTarget:self action:@selector(seletAreaBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            cell.contentTf.hidden = YES;
            
            if (self.infoModel) {
                NSString *str = [NSString stringWithFormat:@"%@%@%@", self.provinceDic[@"province"], self.cityDic[@"city"], self.areaDic[@"area"]];
                [cell.seletAreaBtn setTitle:[NSString stringWithFormat:@"%@", str] forState:UIControlStateNormal];
            }
            
        }else {
            cell.seletAreaBtn.hidden = YES;
            cell.contentTf.hidden = NO;
            
            NSString *content = self.contentArray[indexPath.row];
            if (content.length > 0) {
                cell.contentTf.text = self.contentArray[indexPath.row];
            }
            
            if (indexPath.row == 1 || indexPath.row == 4) {
                cell.contentTf.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            }else {
                cell.contentTf.keyboardType = UIKeyboardTypeDefault;
            }
        }
        
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    SwitchTableViewCell *switchCell = [tableView dequeueReusableCellWithIdentifier:@"SwitchTableViewCell"];
    switchCell.tipLabel.text = @"设为默认";
    switchCell.SwitchBlock = ^(NSString *is_default) {
        self.is_default = is_default;
    };
    if ([self.is_default isEqualToString:@"0"]) {
        switchCell.switchBtn.on = NO;
    }else {
        switchCell.switchBtn.on = YES;
    }
    switchCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return switchCell;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    UITableViewCell *cell = (UITableViewCell *)[[textField superview] superview];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    [self.contentArray replaceObjectAtIndex:indexPath.row withObject:textField.text];
}

- (void)seletAreaBtnAction:(UIButton *)sender {
    
    [self.view endEditing:YES];
    
    CZHWeakSelf(self);
 
    
    [CZHAddressPickerView areaPickerViewWithProvinceDic:self.provinceDic cityDic:self.cityDic areaDic:self.areaDic areaDicBlock:^(NSDictionary *provinceDic, NSDictionary *cityDic, NSDictionary *areaDic) {
       
        weakself.provinceDic = provinceDic;
        weakself.cityDic = cityDic;
        weakself.areaDic = areaDic;
        
        if (!weakself.cityDic) {
            weakself.cityDic = @{@"city":@"", @"city_id":@""};
        }
        if (!weakself.areaDic) {
            weakself.areaDic = @{@"area":@"", @"area_id":@""};
        }
        NSString *str = [NSString stringWithFormat:@"%@%@%@", weakself.provinceDic[@"province"], weakself.cityDic[@"city"], weakself.areaDic[@"area"]];
        [sender setTitle:[NSString stringWithFormat:@"%@", str] forState:UIControlStateNormal];
        [weakself.contentArray replaceObjectAtIndex:2 withObject:str];
        
    }];
    
}

- (void)saveAddree {
    [self.view endEditing:YES];
    for (NSInteger i = 0; i < self.contentArray.count; i++) {
        NSString *content = self.contentArray[i];
        if (content.length <= 0) {
            NSString *tipStr = [NSString stringWithFormat:@"%@不能为空", self.dataArray[i]];
            [HSToast hsShowBottomWithText:tipStr];
            return;
        }
    }
    NSMutableDictionary *mutableDic = [NSMutableDictionary dictionary];
    NSArray *tip = @[@"name", @"mobile", @"province_id", @"city_id", @"area_id", @"address", @"code", @"is_default"];
    if (self.contentArray.count < 5) {
        return;
    }
    NSArray *resultArr = @[self.contentArray[0], self.contentArray[1], self.provinceDic[@"province_id"], self.cityDic[@"city_id"], self.areaDic[@"area_id"], self.contentArray[3], self.contentArray[4], self.is_default];

    for (NSInteger i = 0; i < tip.count; i++) {
        [mutableDic setValue:resultArr[i] forKey:tip[i]];
    }
    
    
    NSString *url = @"";
    if (self.infoModel) {
        // 编辑
        url = [HttpNetRequestTool requestUrlString:@"/business/member/address/update"];
        [mutableDic setValue:self.infoModel.address_id forKey:@"id"];
    }else {
        // 新增
        url = [HttpNetRequestTool requestUrlString:@"/business/member/address/add"];
    }
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [HttpNetRequestTool netRequestWithHeader:HttpNetRequestPost urlString:url paraments:mutableDic success:^(id Json) {
        
        BaseModel *model = [BaseModel yy_modelWithJSON:Json];
         if (model.code == 1) {
             if (self.refreshBlock) {
                 self.refreshBlock();
             }
             [self.navigationController popViewControllerAnimated:YES];
        }else{
            [HSToast hsShowBottomWithText:model.msg];
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];

    } failure:^(NSString *error) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [HSToast hsShowBottomWithText:error];

    }];
    
    
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
