//
//  AddPersonController.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/7.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "AddPersonController.h"
#import "AddPersonCardHeaderView.h"
#import "AddPersonCN_ENHeaderView.h"
#import "AddPersonChoseTypeView.h"
#import "CertificatesInfo.h"
#import "HRAddPersonForPetCell.h"
#import "HRSelectView.h"
#import "MyPetController.h"
#import "HDDateSelctedView.h"
@interface AddPersonController ()<HRSelectViewDelegate, AddPersonCardHeaderViewDelegate, AddPersonCN_ENHeaderViewDelegate>
@property (nonatomic, assign) __block NSInteger type;
@property (nonatomic, strong) AddPersonCardHeaderView *cardHeaderView;
@property (nonatomic, strong) AddPersonCN_ENHeaderView *podeHeaderView;
@property (nonatomic, strong) UIView *cardHeaderBGView;
@property (nonatomic, strong) UIView *podeHeaderBGView;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) CertificatesInfo *info;
@property (nonatomic, strong) HRSelectView *selectView;

@property (nonatomic, copy) NSString *manType;
@property (nonatomic, assign) NSInteger manSex;
@property (nonatomic, copy) NSString *birthDayStr;

@end

@implementation AddPersonController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.isPet) {
        self.tableView.tableHeaderView = self.cardHeaderBGView;
//        self.footerView.frame = CGRectMake(0, SCREENH_HEIGHT - 110, SCREEN_WIDTH, 110);
//        [self.view addSubview:self.footerView];
    }else{
        self.tableView.tableHeaderView = self.cardHeaderView;
//        self.tableView.tableFooterView = self.footerView;
    }
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveBtnClick)];
    
    __weak typeof(self) weakSelf = self;
    self.cardHeaderView.typeBlock = ^{
        [weakSelf addPersonChoseView];
    };
    self.podeHeaderView.typeBlock = ^{
        [weakSelf addPersonChoseView];
    };
    if (self.p_id) {
        //获取证件
        self.navigationItem.title = @"修改乘机人信息";
        [self getCerdata];
    }else {
        self.navigationItem.title = @"添加乘机人";
    }
    self.manSex = 0;
    self.manType = @"ADT";
    self.cardHeaderView.sexBlock = ^(NSInteger sex) {
        weakSelf.manSex = sex;
    };
    self.cardHeaderView.mantypeBlock = ^(NSString *manType) {
        weakSelf.manType = manType;
    };
    self.cardHeaderView.birthDayBlock = ^(NSString *birthDay) {
        weakSelf.birthDayStr = birthDay;
        weakSelf.cardHeaderView.birthdayLabel.text = weakSelf.birthDayStr;
        weakSelf.cardHeaderView.birthdayLabel.textColor = [UIColor blackColor];
    };
    
    self.podeHeaderView.sexBlock = ^(NSInteger sex) {
        weakSelf.manSex = sex;
    };
    self.podeHeaderView.mantypeBlock = ^(NSString *manType) {
        weakSelf.manType = manType;
    };
    self.podeHeaderView.birthDayBlock = ^(NSString *birthDay) {
        weakSelf.birthDayStr = birthDay;
        weakSelf.cardHeaderView.birthdayLabel.text = weakSelf.birthDayStr;
        weakSelf.cardHeaderView.birthdayLabel.textColor = [UIColor blackColor];
    };
    
}
- (void)addPersonChoseView{
    AddPersonChoseTypeView *view = [[AddPersonChoseTypeView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT)];
    view.selectedIndex = self.type;
    __weak typeof(self) weakSelf = self;
    view.selectedBlock = ^(NSInteger index , NSString *type) {
        [weakSelf changeHeader:index type:type];
    };
    [view showAddPersonChoseTypeView];
}
- (void)changeHeader:(NSInteger)index type:(NSString *)string{
    __weak typeof(self) weakSelf = self;
    if (index != weakSelf.type) {
        weakSelf.type = index;
        if (index == 0) {
            //身份证
            [weakSelf.tableView beginUpdates];
            if (weakSelf.isPet) {
                weakSelf.tableView.tableHeaderView = weakSelf.cardHeaderBGView;
            }else{
                weakSelf.tableView.tableHeaderView = weakSelf.cardHeaderView;
            }
            [weakSelf.tableView endUpdates];
        }else{
            
            [weakSelf.tableView beginUpdates];
            weakSelf.podeHeaderView.typeStr = string;
            weakSelf.podeHeaderView.typeLabel.text = string;
            if (weakSelf.isPet) {
                weakSelf.tableView.tableHeaderView = weakSelf.podeHeaderBGView;
            }else{
                weakSelf.tableView.tableHeaderView = weakSelf.podeHeaderView;
            }
            [weakSelf.tableView endUpdates];
        }
    }
}
- (void)getCerdata{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *url = [HttpNetRequestTool requestUrlString:@"/user/paper/detail"];
    NSDictionary *dict = @{@"p_id":self.p_id};
    [HttpNetRequestTool netRequestWithHeader:HttpNetRequestPost urlString:url paraments:dict success:^(id Json) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        BaseModel *model = [BaseModel yy_modelWithJSON:Json];
        if (model.code == 1) {
            self.info = [CertificatesInfo yy_modelWithJSON:model.data];
            [self refreshData];
        }else{
            [HSToast hsShowBottomWithText:model.msg];
        }
    } failure:^(NSString *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [HSToast hsShowBottomWithText:error];
    }];
}
- (void)refreshData{
    if ([self.info.card_type isEqualToString:@"1"]) {
        //身份证
        self.type = 0;

        self.cardHeaderView.info = self.info;
        
        if (self.isPet) {
            self.tableView.tableHeaderView = self.cardHeaderBGView;
        }else{
            self.tableView.tableHeaderView = self.cardHeaderView;
        }
    }
    else{
        self.type = [self.info.card_type integerValue] - 1;
        
        self.podeHeaderView.info = self.info;


        NSArray *aa = @[@"身份证",@"护照",@"港澳通行证",@"台胞证"];
        if (self.type >= 0 && self.type < aa.count) {
            self.podeHeaderView.typeLabel.text = aa[self.type];
        }
        if (self.isPet) {
            self.tableView.tableHeaderView = self.podeHeaderBGView;
        }else{
            self.tableView.tableHeaderView = self.podeHeaderView;
        }
    }

}
- (void)saveBtnClick{
    if (self.isPet) {
        [self changeCerData];
        
    }else{
        if (self.p_id) {
            //修改
            [self changeCerData];
        }else{
            //新增
            [self addPerson];
        }
    }
}
- (BOOL)canAdd{
    [[IQKeyboardManager sharedManager] resignFirstResponder];
    if (self.type == 0) {
        if (self.cardHeaderView.nameTextField.text.length <= 0) {
            [HSToast hsShowBottomWithText:@"请填写身份证姓名"];
            return NO;
        }
        if (self.cardHeaderView.codeTextField.text.length <= 0) {
            [HSToast hsShowBottomWithText:@"请填写身份证号"];
            return NO;
        }
        if (![NSString CheckIsIdentityCard:self.cardHeaderView.codeTextField.text]) {
            [HSToast hsShowBottomWithText:@"请填写正确身份证号"];
            return NO;
        }
        if (self.cardHeaderView.birthdayLabel.text.length <= 0) {
            [HSToast hsShowBottomWithText:@"请填写生日"];
            return NO;
        }
//        if ([NSString stringWithFormat:@"%ld", _manSex] == 0) {
//            [HSToast hsShowBottomWithText:@"请填写性别"];
//            return NO;
//        }
//        if (self.manType <= 0) {
//            [HSToast hsShowBottomWithText:@"请填写乘客类型"];
//            return NO;
//        }
    }else{
        if (self.podeHeaderView.FirstTextField.text.length <= 0) {
            [HSToast hsShowBottomWithText:@"请填写证件姓"];
            return NO;
        }
        if (self.podeHeaderView.lastTextField.text.length <= 0) {
            [HSToast hsShowBottomWithText:@"请填写证件名"];
            return NO;
        }
        if (self.podeHeaderView.codeTextField.text.length <= 0) {
            [HSToast hsShowBottomWithText:@"请填写证件号"];
            return NO;
        }
        if (self.cardHeaderView.birthdayLabel.text.length <= 0) {
            [HSToast hsShowBottomWithText:@"请填写生日"];
            return NO;
        }
//        if (self.manSex) {
//            [HSToast hsShowBottomWithText:@"请填写性别"];
//            return NO;
//        }
//        if (self.manType.length <= 0 ) {
//            [HSToast hsShowBottomWithText:@"请填写乘客类型"];
//            return NO;
//        }
    }
    return YES;
}
- (void)addPerson{
    if ([self canAdd]) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSString *url = [HttpNetRequestTool requestUrlString:@"/user/paper/add"];
        NSDictionary *dict;
        if (self.type == 0) {
            dict = @{@"card_type":[NSString stringWithFormat:@"%ld",(long)self.type + 1],@"card_no":self.cardHeaderView.codeTextField.text,@"id_card_name":self.cardHeaderView.nameTextField.text,@"sex":[NSString stringWithFormat:@"%ld", self.manSex], @"mantype":self.manType, @"birthday":self.birthDayStr};
        }else{
            dict = @{@"card_type":[NSString stringWithFormat:@"%ld",(long)self.type + 1],@"card_no":self.podeHeaderView.codeTextField.text,@"surname":self.podeHeaderView.FirstTextField.text,@"given_name":self.podeHeaderView.lastTextField.text,@"sex":[NSString stringWithFormat:@"%ld", self.manSex], @"mantype":self.manType, @"birthday":self.birthDayStr};
        }
        [HttpNetRequestTool netRequestWithHeader:HttpNetRequestPost urlString:url paraments:dict success:^(id Json) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            BaseModel *model = [BaseModel yy_modelWithJSON:Json];
            if (model.code == 1) {
                if (self.refreshBlock) {
                    self.refreshBlock();
                }
                if (self.cerDataBlock) {
                    passengerModel *info = [passengerModel yy_modelWithJSON:model.data];
                    self.cerDataBlock(info);
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
}
- (void)changeCerData{
    if ([self canAdd]) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSString *url = [HttpNetRequestTool requestUrlString:@"/user/paper/edit"];
        NSDictionary *dict;
        if (self.type == 0) {
            dict = @{@"p_id":self.p_id,@"card_type":[NSString stringWithFormat:@"%ld",(long)self.type + 1],@"card_no":self.cardHeaderView.codeTextField.text,@"id_card_name":self.cardHeaderView.nameTextField.text, @"sex":[NSString stringWithFormat:@"%ld", self.manSex], @"mantype":self.manType, @"birthday":self.cardHeaderView.birthdayLabel.text};
        }else{
            dict = @{@"p_id":self.p_id,@"card_type":[NSString stringWithFormat:@"%ld",(long)self.type + 1],@"card_no":self.podeHeaderView.codeTextField.text,@"surname":self.podeHeaderView.FirstTextField.text,@"given_name":self.podeHeaderView.lastTextField.text, @"sex":[NSString stringWithFormat:@"%ld", self.manSex], @"mantype":self.manType, @"birthday":self.podeHeaderView.birthDayLabel.text};
        }
        [HttpNetRequestTool netRequestWithHeader:HttpNetRequestPost urlString:url paraments:dict success:^(id Json) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            BaseModel *model = [BaseModel yy_modelWithJSON:Json];
            if (model.code == 1) {
                if (self.refreshBlock) {
                    self.refreshBlock();
                }
                if (self.cerDataBlock) {
                    passengerModel *pModel = [[passengerModel alloc] init];
                    if (self.type == 0) {
                        pModel.pid = self.p_id;
                        pModel.card_type = [NSString stringWithFormat:@"%ld",(long)self.type + 1];
                        pModel.card_no = self.cardHeaderView.codeTextField.text;
                        pModel.id_card_name = self.cardHeaderView.nameTextField.text;
                        pModel.birthday = self.cardHeaderView.birthdayLabel.text;
                    }else{
                        pModel.pid = self.p_id;
                        pModel.card_type = [NSString stringWithFormat:@"%ld",(long)self.type + 1];
                        pModel.card_no = self.podeHeaderView.codeTextField.text;
                        pModel.surname = self.podeHeaderView.FirstTextField.text;
                        pModel.given_name = self.podeHeaderView.lastTextField.text;
                        pModel.birthday = self.podeHeaderView.birthDayLabel.text;

                    }
                    self.cerDataBlock(pModel);
                }
                if (self.petBlock) {
                    passengerModel *pModel = [[passengerModel alloc] init];
                    if (self.type == 0) {
                        pModel.pid = self.p_id;
                        pModel.card_type = [NSString stringWithFormat:@"%ld",(long)self.type + 1];
                        pModel.card_no = self.cardHeaderView.codeTextField.text;
                        pModel.id_card_name = self.cardHeaderView.nameTextField.text;
                        pModel.birthday = self.cardHeaderView.birthdayLabel.text;

                    }else{
                        pModel.pid = self.p_id;
                        pModel.card_type = [NSString stringWithFormat:@"%ld",(long)self.type + 1];
                        pModel.card_no = self.podeHeaderView.codeTextField.text;
                        pModel.surname = self.podeHeaderView.FirstTextField.text;
                        pModel.given_name = self.podeHeaderView.lastTextField.text;
                        pModel.birthday = self.podeHeaderView.birthDayLabel.text;

                    }
                    self.petBlock(pModel, self.selectedPet);
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
}

#pragma mark - 选择生日信息
- (void)didSelectBirthDay {
    
    HDDateSelctedView *view = [[HDDateSelctedView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT)];
    [view showHDDateSelctedView];
    __weak typeof(self) weakSelf = self;
    view.birthBlocl = ^(NSString *year, NSString *month, NSString *day) {
        
         weakSelf.birthDayStr = [NSString stringWithFormat:@"%@-%@-%@",year,month,day];
        
        weakSelf.cardHeaderView.birthdayLabel.text = weakSelf.birthDayStr;
        weakSelf.cardHeaderView.birthdayLabel.textColor = [UIColor blackColor];
    };
    return;
    
}
- (void)didSelectBirthDayAddPersonCN_ENHeaderView {
    
    HDDateSelctedView *view = [[HDDateSelctedView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT)];
    [view showHDDateSelctedView];
    __weak typeof(self) weakSelf = self;
    view.birthBlocl = ^(NSString *year, NSString *month, NSString *day) {
        
        weakSelf.birthDayStr = [NSString stringWithFormat:@"%@-%@-%@",year,month,day];
        
        weakSelf.podeHeaderView.birthDayLabel.text = weakSelf.birthDayStr;
        weakSelf.podeHeaderView.birthDayLabel.textColor = [UIColor blackColor];

    };
    return;
    
    
}

#pragma mark --load--
- (AddPersonCardHeaderView *)cardHeaderView{
    if (!_cardHeaderView) {
        _cardHeaderView = [[[NSBundle mainBundle] loadNibNamed:@"AddPersonCardHeaderView" owner:self options:nil] objectAtIndex:0];
        _cardHeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 304 + 140);

        _cardHeaderView.delegate = self;
    }
    return _cardHeaderView;
}
- (AddPersonCN_ENHeaderView *)podeHeaderView{
    if (!_podeHeaderView) {
        _podeHeaderView = [[[NSBundle mainBundle] loadNibNamed:@"AddPersonCN_ENHeaderView" owner:self options:nil] objectAtIndex:0];
        _podeHeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 365 + 145);
        _podeHeaderView.delegate = self;

    }
    return _podeHeaderView;
}
-(UIView *)cardHeaderBGView{
    if (!_cardHeaderBGView) {
        _cardHeaderBGView = [[UIView alloc] init];
        _cardHeaderBGView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 345 + 140);
        UILabel *titleLB = [[UILabel alloc] init];
        titleLB.text = @"  乘机人信息";
        titleLB.backgroundColor = [UIColor whiteColor];
        titleLB.textColor = [UIColor colorWithHexString:@"#333333"];
        titleLB.font = [UIFont systemFontOfSize:17];
        titleLB.frame = CGRectMake(0, 0, SCREEN_WIDTH, 39);
        [_cardHeaderBGView addSubview:titleLB];
        [_cardHeaderBGView addSubview:self.cardHeaderView];
        self.cardHeaderView.frame = CGRectMake(0, 40, SCREEN_WIDTH, 304 + 140);
    }
    return _cardHeaderBGView;
}
-(UIView *)podeHeaderBGView{
    if (!_podeHeaderBGView) {
        _podeHeaderBGView = [[UIView alloc] init];
        _podeHeaderBGView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 406 + 145);
        UILabel *titleLB = [[UILabel alloc] init];
        titleLB.text = @"  乘机人信息";
        titleLB.backgroundColor = [UIColor whiteColor];
        titleLB.textColor = [UIColor colorWithHexString:@"#333333"];
        titleLB.font = [UIFont systemFontOfSize:17];
        titleLB.frame = CGRectMake(0, 0, SCREEN_WIDTH, 39);
        [_podeHeaderBGView addSubview:titleLB];
        [_podeHeaderBGView addSubview:self.podeHeaderView];
        self.podeHeaderView.frame = CGRectMake(0, 40, SCREEN_WIDTH, 365 + 145);
    }
    return _podeHeaderBGView;
}


//- (UIView *)footerView{
//    if (!_footerView) {
//        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 110)];
//        UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        saveBtn.adjustsImageWhenHighlighted = NO;
//        saveBtn.frame = CGRectMake(10, 65, _footerView.bounds.size.width - 20, 40);
//        saveBtn.backgroundColor  = [UIColor hdMainColor];
//        saveBtn.layer.cornerRadius = 20;
//        [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
//        saveBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
//        [saveBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
//        [_footerView addSubview:saveBtn];
//    }
//    return _footerView;
//}

-(HRSelectView *)selectView{
    if (!_selectView) {
        _selectView = [HRSelectView initFromNib:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT)];
        _selectView.delegate = self;
        
        [[UIApplication sharedApplication].keyWindow addSubview:_selectView];
//        [UIView animateWithDuration:0.2 animations:^{
//            _selectView.centerView.frame = CGRectMake(0, SCREENH_HEIGHT - 300, SCREEN_WIDTH, 300);
//
//        }];
    }
    return _selectView;
}

#pragma mark --UITableViewDdatasouce
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.isPet) {
        return 1;
    }
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *const topCellID = @"HRAddPersonForPetCell";
    HRAddPersonForPetCell *cell = [tableView dequeueReusableCellWithIdentifier:topCellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:topCellID owner:self options:nil] objectAtIndex:0];
    }
    WeakObj(self)
    cell.selectBtnBlock = ^{
        [[IQKeyboardManager sharedManager] resignFirstResponder];
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (MyPetInfo *info in weakself.petArray) {
            [array addObject:info.pet_name];
        }
        if (weakself.selectedPet) {
            weakself.selectView.selectedRow = [weakself.petArray indexOfObject:weakself.selectedPet] + 1;
        }else{
            weakself.selectView.selectedRow = 0;
        }
        weakself.selectView.dataSource = array;
    };
    cell.addBtnBlock = ^{
        MyPetController *vc = [[MyPetController alloc] init];
        vc.petDataBlock = ^(MyPetInfo *info) {
            [weakself.petArray addObject:info];
            [weakself.petALLArray addObject:info];
            if (weakself.updatePetBlock) {
                weakself.updatePetBlock(weakself.petALLArray);
            }
        };
        [self.navigationController pushViewController:vc animated:YES];
    };
    if (self.selectedPet) {
        cell.petNameLB.text = self.selectedPet.pet_name;
    }else{
        cell.petNameLB.text = @"不携带宠物";
    }
    return cell;
}
#pragma mark --UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}
#pragma mark --HRSelectViewDelegate
-(void)didSelected:(NSInteger)index{
    self.selectView.hidden = YES;
    if (index == 0) {
        self.selectedPet = nil;
    }else{
        self.selectedPet = [self.petArray objectAtIndex:index - 1];
    }
    [self.tableView reloadData];
    
 
}
@end
