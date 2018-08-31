//
//  OrderCreateController.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/6.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "OrderCreateController.h"
#import "OrderCreateTopCell.h"
#import "OrderPersonCell.h"
#import "OrderPhoneCell.h"
#import "OrderCardCell.h"
#import "OrderInsuranceCell.h"
#import "OrderPetCreateCell.h"
#import "OrderPetAddPopupView.h"
#import "OrderPayController.h"
#import "OrderChangePopupView.h"
#import "AddPersonController.h"
#import "FlightInsuranceController.h"
#import "passengerModel.h"
#import "InsuranceModel.h"
#import "MyPetController.h"

#import "HRHelpAddPetViewController.h"

@interface OrderCreateController ()<OrderCardCellDelegate>
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *tipsLabel;
@property (nonatomic, strong) UIButton *commitBtn;

@property (nonatomic, strong) NSMutableArray *passengerArray;
@property (nonatomic, strong) NSArray *insuranceArray;
@property (nonatomic, strong) NSMutableArray *seletedArray;

@property (nonatomic, strong) NSMutableArray *petArray;
@property (nonatomic, strong) NSMutableArray *petSeletedArray;

@property (nonatomic, copy) NSString *phoneNumberStr;

@property (nonatomic , assign) BOOL isNoCanRemove;

@property (nonatomic , assign) CGFloat passengerTotalPrice;//机票总价(总和)
@property (nonatomic , assign) CGFloat petTotalPrice;//宠物总价(总和)
@property (nonatomic , assign) CGFloat machineBuildTotalPrice;//基建(单人)
@property (nonatomic , assign) CGFloat fuelTotalPrice;//基建(单人)
@property (nonatomic , assign) CGFloat otherPrice;//基建+燃油(单人)
@property (nonatomic , assign) CGFloat insurancePrice;//保险费用(单人)
@property (nonatomic , assign) CGFloat totalPrice;//付款金额

@end

@implementation OrderCreateController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"订单填写";
    [self configView];
//    [AppConfig getUserName]
    self.phoneNumberStr = [NSString nullString:@"" dispathString:[AppConfig getUserName]];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor colorWithHexString:@"#999999"];
    label.text = [NSString stringWithFormat:@"  温馨提示：微信/支付宝平台支付的用户需要支付%@%%的手续费",self.flightOrderInfoModel.pay_oddsW];
    self.tableView.tableFooterView = label;
}
- (void)configView{
    self.tableView.frame = CGRectMake(0, [AppConfig getNavigationBarHeight], SCREEN_WIDTH, SCREENH_HEIGHT - [AppConfig getNavigationBarHeight] - [AppConfig getButtomHeight] - 50);
    
    UIView *buttomView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.tableView.frame), SCREEN_WIDTH, 50)];
    buttomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:buttomView];
    
    self.commitBtn.frame = CGRectMake(buttomView.bounds.size.width - 150, 0, 150, buttomView.bounds.size.height);
    [buttomView addSubview:self.commitBtn];
    
    if (self.isPet) {
        self.priceLabel.frame = CGRectMake(10, 0, CGRectGetMinX(self.commitBtn.frame) - 20, 30);
        [buttomView addSubview:self.priceLabel];
        
        self.tipsLabel.frame = CGRectMake(10, CGRectGetMaxY(self.priceLabel.frame), CGRectGetMinX(self.commitBtn.frame) - 20, 20);
        [buttomView addSubview:self.tipsLabel];
    }else{
        self.priceLabel.frame = CGRectMake(10, 0, CGRectGetMinX(self.commitBtn.frame) - 20, buttomView.bounds.size.height);
        [buttomView addSubview:self.priceLabel];
    }
    
}
- (void)commitBtnClick{
    if (!self.phoneNumberStr || self.phoneNumberStr.length <= 0) {
        [HSToast hsShowBottomWithText:@"请输入手机号"];
        return;
    }
    if (![NSString checkoutPhoneNum:self.phoneNumberStr]) {
        [HSToast hsShowBottomWithText:@"请输入正确的手机号"];
        return;
    }
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *url = [HttpNetRequestTool requestUrlString:@"/ticket/order/add"];
    NSString *user_type = (self.isPet ? @"2" : @"1");
    NSString *contact = self.phoneNumberStr ?:@"";
    NSMutableString *passenger = [[NSMutableString alloc] init];//ID字符串
    NSMutableString *passengerName = [[NSMutableString alloc] init];//名字字符串
    for (int i = 0; i<self.seletedArray.count; i++) {
        passengerModel *model = self.seletedArray[i];
        [passenger appendString:model.pid];
        if (model.pet) {
            [passenger appendFormat:@"&%@",model.pet.id];
        }
        if ([@"1" isEqualToString:model.card_type]) {
            [passengerName appendString:model.id_card_name];
        }else{
            [passengerName appendFormat:@"%@%@",model.surname,model.given_name];
        }
        if (i < self.seletedArray.count - 1) {
            [passenger appendString:@","];
            [passengerName appendString:@","];
        }
    }
    //    NSMutableString *pet = [[NSMutableString alloc] init];
    //    for (int i = 0; i<self.petSeletedArray.count; i++) {
    //        MyPetInfo *model = self.petSeletedArray[i];
    //        [pet appendString:model.id];
    //        if (i < self.petSeletedArray.count - 1) {
    //            [pet appendString:@","];
    //        }
    //    }
    NSMutableString *insurance = [[NSMutableString alloc] init];
    for (int i = 0; i<self.insuranceArray.count; i++) {
        InsuranceModel *model = self.insuranceArray[i];
        if (model.isSelected) {
            [insurance appendString:model.pid];
            if (i < self.insuranceArray.count - 1) {
                [insurance appendString:@","];
            }
        }
    }
    NSDictionary *dict = [NSDictionary dictionary];
    if (self.isJourney) {
        dict = @{@"to":self.flightOrderInfoModel.to.pid,@"to_pid":self.flightOrderInfoModel.to.position.pid,
                 @"back":self.flightOrderInfoModel.back.pid,@"back_pid":self.flightOrderInfoModel.back.position.pid,
                 @"user_type":user_type,@"contact":contact,
                 @"passenger":passenger?:@"",@"bx":insurance?:@""};
    }else{
        dict = @{@"to":self.flightOrderInfoModel.to.pid,@"to_pid":self.flightOrderInfoModel.to.position.pid,
                 @"user_type":user_type,@"contact":contact,
                 @"passenger":passenger?:@"",@"bx":insurance?:@""};
    }
    HRLog(@"params====%@",dict)
    [HttpNetRequestTool netRequest:HttpNetRequestPost urlString:url outTime:20 paraments:dict isHeader:YES success:^(id Json) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        BaseModel *model = [BaseModel yy_modelWithJSON:Json];
        if (model.code == 1) {
            HRLog(@"%@",Json)
            if (model.data[@"order_number"]) {
                OrderPayController *vc = [[OrderPayController alloc] init];
                vc.isPet = self.isPet;
                vc.order_number = model.data[@"order_number"];
                vc.over_pay_at = model.data[@"over_pay_at"];
                vc.totalPrice = self.totalPrice;
                vc.dateTime = self.flightOrderInfoModel.to.take_off_time;
                vc.phoneNumber = self.phoneNumberStr;
                vc.passengerNames = passengerName;
                vc.parPrice = self.passengerTotalPrice/self.seletedArray.count;
                vc.parCount = self.seletedArray.count;
                vc.machineBuildPrice = self.machineBuildTotalPrice;
                vc.machineBuilCount = self.seletedArray.count;
                vc.fuelPrice = self.fuelTotalPrice;
                vc.fuelCount = self.seletedArray.count;
                if (self.isJourney) {
                    vc.insurancePrice = self.insurancePrice*2;
                }else{
                    vc.insurancePrice = self.insurancePrice;
                }
                vc.insuranceCount = self.seletedArray.count;
                
                vc.petPrice = self.petTotalPrice/(self.petSeletedArray.count?:1);
                vc.petCount = self.petSeletedArray.count?:0;
                
                vc.startCity = self.startCity;
                vc.endCity = self.endCity;
                vc.isJourney = self.isJourney;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }else{
            [HSToast hsShowBottomWithText:model.msg];
        }
    } failure:^(NSString *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [HSToast hsShowBottomWithText:error];
    }];
}
- (void)addPerson{
    AddPersonController *vc = [[AddPersonController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark --UITableViewDdatasouce
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //    if (self.isPet) {
    //        return 5;
    //    }else{
    //        return 4;
    //    }
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //    if (self.isPet) {
    //        if (section == 4) {
    //            return self.insuranceArray.count;
    //        }
    //        if (section == 1) {
    //            return self.seletedArray.count + 1;
    //        }
    //        if (section == 2) {
    //            return 1;
    //        }
    //    }else{
    //        if (section == 3) {
    //            return self.insuranceArray.count;
    //        }
    //        if (section == 1) {
    //            return self.seletedArray.count + 1;
    //        }
    //    }
    if (section == 3) {
        return self.insuranceArray.count;
    }
    if (section == 1) {
        return self.seletedArray.count + 1;
    }
    if (section == 0 && self.isJourney) {
        return 2;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {//航班信息
        static NSString *const topCellID = @"OrderCreateTopCell";
        OrderCreateTopCell *cell = [tableView dequeueReusableCellWithIdentifier:topCellID];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:topCellID owner:self options:nil] objectAtIndex:0];
        }
        if (indexPath.row == 0) {
            self.flightOrderInfoModel.isJourney = false;
            cell.flightOrderInfoModel = self.flightOrderInfoModel;
        }else{
            self.flightOrderInfoModel.isJourney = true;
            cell.flightOrderInfoModel = self.flightOrderInfoModel;
        }
        __weak typeof(self) weakSelf = self;
        cell.ruleBlock = ^{
            OrderChangePopupView *view = [[OrderChangePopupView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT)];
            view.headerText = @"退票改签规则";
            if (indexPath.row == 0) {
                weakSelf.flightOrderInfoModel.isJourney = false;
                view.dataLists = @[weakSelf.flightOrderInfoModel.to.position.change_text,
                                   weakSelf.flightOrderInfoModel.to.position.refund_text,
                                   weakSelf.flightOrderInfoModel.to.position.change_date_text];
            }else{
                weakSelf.flightOrderInfoModel.isJourney = true;
                view.dataLists = @[weakSelf.flightOrderInfoModel.back.position.change_text,
                                   weakSelf.flightOrderInfoModel.back.position.refund_text,
                                   weakSelf.flightOrderInfoModel.back.position.change_date_text];
            }
            [view showPopupView];
        };
        return cell;
    }
    if (indexPath.section == 1) {//乘机人
        if (indexPath.row == 0) {
            static NSString *const personCellID = @"OrderPersonCell";
            OrderPersonCell *cell = [tableView dequeueReusableCellWithIdentifier:personCellID];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:personCellID owner:self options:nil] objectAtIndex:0];
            }
            cell.seletedLists = self.seletedArray;
            cell.dataLists = self.passengerArray;
            if (self.isPet) {
                cell.helpBtnConstHeight.constant = 27;
                cell.helpBtn.hidden = NO;
            }else{
                cell.helpBtnConstHeight.constant = 0;
                cell.helpBtn.hidden = YES;
            }
            cell.personTitleLB.text = [NSString stringWithFormat:@"乘机人（最多选择%@名乘机人）",self.flightOrderInfoModel.max_passenger_num];
            __weak typeof(self) weakSelf = self;
            cell.addBlock = ^{
                debugLog(@"新增人员");
                //                [weakSelf addPerson];
                AddPersonController *vc = [[AddPersonController alloc] init];
                vc.cerDataBlock = ^(passengerModel *info) {
                    [weakSelf.passengerArray addObject:info];
                    [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
                };
                [weakSelf.navigationController pushViewController:vc animated:YES];
            };
            
            cell.helpBlock = ^{
                HRHelpAddPetViewController *vc = [HRHelpAddPetViewController new];
                [weakSelf.navigationController pushViewController:vc animated:YES];
            };
            cell.selectedBlock = ^(passengerModel *seletedModel) {
                if (!seletedModel.isSelected) {
                    if (weakSelf.seletedArray.count >= [weakSelf.flightOrderInfoModel.max_passenger_num integerValue]){
                        [HSToast hsShowBottomWithText:[NSString stringWithFormat:@"最多选择%@名乘机人",weakSelf.flightOrderInfoModel.max_passenger_num]];
                    }else{
                        seletedModel.isSelected = true;
                        [weakSelf.seletedArray addObject:seletedModel];
                    }
                }else{
                    if (weakSelf.seletedArray.count <= 1) {
                        [HSToast hsShowBottomWithText:@"至少选择1位乘机人"];
                    }else{
                        seletedModel.isSelected = false;
                        [weakSelf.seletedArray removeObject:seletedModel];
                    }
                }
                [weakSelf.petSeletedArray removeObject:seletedModel.pet];
                seletedModel.isHavePet = NO;
                seletedModel.pet = nil;
                
                [weakSelf updatePrice];
                //                NSIndexPath *indexPath=[NSIndexPath indexPathForRow:3 inSection:0];
                //                [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationFade];
                
                [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
            };
            return cell;
        }
        if (indexPath.row >= 1) {
            static NSString *const cardCellID = @"OrderCardCell";
            OrderCardCell *cell = [tableView dequeueReusableCellWithIdentifier:cardCellID];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:cardCellID owner:self options:nil] objectAtIndex:0];
            }
            cell.orderCardCellDelegate = self;
            cell.isPet = self.isPet;
            cell.passengerModel = self.seletedArray[indexPath.row - 1];
            return cell;
        }
    }
    //    if (self.isPet) {
    //        if (indexPath.section == 2) {
    //            //宠物
    //            static NSString *const petCellID = @"OrderPetCreateCell";
    //            OrderPetCreateCell *cell = [tableView dequeueReusableCellWithIdentifier:petCellID];
    //            if (!cell) {
    //                cell = [[[NSBundle mainBundle] loadNibNamed:petCellID owner:self options:nil] objectAtIndex:0];
    //            }
    //            cell.seletedLists = self.petSeletedArray;
    //            cell.dataLists = self.petArray;
    //            cell.petTitleLB.text = [NSString stringWithFormat:@"携带宠物（最多选择%@只宠物）",self.flightOrderInfoModel.max_pet_num];
    //            __weak typeof(self) weakSelf = self;
    //            cell.addPetBlock = ^{
    //                //添加宠物
    ////                OrderPetAddPopupView *vc = [[[NSBundle mainBundle] loadNibNamed:@"OrderPetAddPopupView" owner:weakSelf options:nil] objectAtIndex:0];
    ////                vc.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT);
    ////                [vc showOrderPetAddPopupView];
    //                MyPetController *vc = [[MyPetController alloc] init];
    //                vc.petDataBlock = ^(MyPetInfo *info) {
    //                    [weakSelf.petArray addObject:info];
    //                    [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationFade];
    //                };
    //                [self.navigationController pushViewController:vc animated:YES];
    //            };
    //            cell.selectedBlock = ^(MyPetInfo *seletedModel) {
    //                if (!seletedModel.isSelected) {
    //                    if (weakSelf.petSeletedArray.count >= [self.flightOrderInfoModel.max_pet_num integerValue]){
    //                        [HSToast hsShowBottomWithText:[NSString stringWithFormat:@"最多选择%@只宠物",self.flightOrderInfoModel.max_pet_num]];
    //                    }else{
    //                        seletedModel.isSelected = true;
    //                        [weakSelf.petSeletedArray addObject:seletedModel];
    //                    }
    //                }else{
    //                    if (weakSelf.petSeletedArray.count <= 1) {
    //                        [HSToast hsShowBottomWithText:@"至少选择1只宠物"];
    //                    }else{
    //                        seletedModel.isSelected = false;
    //                        [weakSelf.petSeletedArray removeObject:seletedModel];
    //                    }
    //                }
    //
    //                [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationFade];
    //            };
    //            return cell;
    //        }
    //    }
    if (indexPath.section == 2) {//indexPath.section == (self.isPet ? 3:2)
        static NSString *const phoneCellID = @"OrderPhoneCell";
        OrderPhoneCell *cell = [tableView dequeueReusableCellWithIdentifier:phoneCellID];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:phoneCellID owner:self options:nil] objectAtIndex:0];
        }
        cell.phoneTextField.text = self.phoneNumberStr;
        __weak typeof(self) weakSelf = self;
        cell.inputBlock = ^(UITextField *tf) {
            weakSelf.phoneNumberStr = tf.text;
        };
        return cell;
    }
    static NSString *const cellID = @"OrderInsuranceCell";
    OrderInsuranceCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:cellID owner:self options:nil] objectAtIndex:0];
    }
    InsuranceModel *model = self.insuranceArray[indexPath.row];
    cell.insuranceModel = model;
    __weak typeof(self) weakSelf = self;
    cell.selectBlock = ^(InsuranceModel *model) {
        model.isSelected = !model.isSelected;
        CGFloat totalPrice = 0;
        for (InsuranceModel *model in weakSelf.insuranceArray) {
            if (model.isSelected) {
                totalPrice += [model.i_price doubleValue];
            }
        }
        weakSelf.insurancePrice = totalPrice;
        [weakSelf updatePrice];
        [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:3] withRowAnimation:UITableViewRowAnimationFade];
        //        [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:(self.isPet ? 4:3)] withRowAnimation:UITableViewRowAnimationFade];
        
    };
    return cell;
}
#pragma mark --UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 80;
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            if (self.isPet) {
                return 110;//修改
            }else{
                return 90;
            }
        }
        if (indexPath.row >= 1) {
            //            passengerModel *pModel = self.seletedArray[indexPath.row - 1];
            if (self.isPet) {
                return 90;
            }
            return 70;
        }
        return 50;
    }
    //    if (self.isPet) {
    //        if (indexPath.section == 2) {
    //            return 90;
    //        }
    //        if (indexPath.section == 3) {
    //            return 50;
    //        }
    //    }else{
    //        if (indexPath.section == 2) {
    //            return 50;
    //        }
    //    }
    if (indexPath.section == 2) {
        return 50;
    }
    return 60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WeakObj(self)
    if (indexPath.section == 3) {//indexPath.section == (self.isPet ? 4:3)
        FlightInsuranceController *vc = [[FlightInsuranceController alloc] init];
        vc.insuranceModel = [self.insuranceArray objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.section == 1){
        if (indexPath.row >= 1) {//乘机人修改
            passengerModel *pModel = self.seletedArray[indexPath.row - 1];
            AddPersonController *vc = [[AddPersonController alloc] init];
            vc.p_id = pModel.pid;
            vc.isPet = self.isPet;
            vc.petALLArray = [NSMutableArray arrayWithArray:self.petArray];
            vc.petArray = [NSMutableArray arrayWithArray:self.petArray];
            NSMutableArray *array = [NSMutableArray arrayWithArray:self.petSeletedArray];
            [array removeObject:pModel.pet];
            [vc.petArray removeObjectsInArray:array];
            vc.selectedPet = pModel.pet;
            if (self.isPet) {
                vc.petBlock = ^(passengerModel *info, MyPetInfo *pet) {
                    info.isHavePet = pet?YES:NO;
                    pModel.pet.isSelected = NO;
                    [weakself.petSeletedArray removeObject:pModel.pet];
                    if (pet) {
                        pet.isSelected = YES;
                        [weakself.petSeletedArray addObject:pet];
                    }
                    info.pet = pet;
                    info.isSelected = pModel.isSelected;
                    [weakself.seletedArray replaceObjectAtIndex:indexPath.row - 1 withObject:info];
                    NSInteger index = [weakself.passengerArray indexOfObject: pModel];
                    [weakself.passengerArray replaceObjectAtIndex:index withObject:info];
                    
                    [weakself updatePrice];
                    
                    [weakself.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
                };
                vc.updatePetBlock = ^(NSArray *petArray) {
                    weakself.petArray = [NSMutableArray arrayWithArray:petArray];
                };
            }else{
                vc.cerDataBlock = ^(passengerModel *info) {
                    info.isSelected = pModel.isSelected;
                    [weakself.seletedArray replaceObjectAtIndex:indexPath.row - 1 withObject:info];
                    NSInteger index = [weakself.passengerArray indexOfObject: pModel];
                    [weakself.passengerArray replaceObjectAtIndex:index withObject:info];
                    [weakself.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
                };
            }
            
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}
#pragma mark --load--
- (UIButton *)commitBtn{
    if (!_commitBtn) {
        _commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _commitBtn.adjustsImageWhenHighlighted = YES;
        _commitBtn.backgroundColor = [UIColor hdMainColor];
        [_commitBtn setTitle:@"提交订单" forState:UIControlStateNormal];
        _commitBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
        [_commitBtn addTarget:self action:@selector(commitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commitBtn;
}
- (UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.textColor = [UIColor hdMainColor];
        _priceLabel.text = @"￥0";
        _priceLabel.font = [UIFont systemFontOfSize:16.0f];
    }
    return _priceLabel;
}
- (UILabel *)tipsLabel{
    if (!_tipsLabel) {
        _tipsLabel = [[UILabel alloc] init];
        _tipsLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _tipsLabel.text = [NSString stringWithFormat:@"预定有氧舱费用为每只%0.0lf元",[self.flightOrderInfoModel.pet_price doubleValue]];
        _tipsLabel.font = [UIFont systemFontOfSize:12.0f];
    }
    return _tipsLabel;
}
-(NSMutableArray *)passengerArray{
    if (!_passengerArray) {
        _passengerArray = [[NSMutableArray alloc] init];
    }
    return _passengerArray;
}

-(NSArray *)insuranceArray{
    if (!_insuranceArray) {
        _insuranceArray = [[NSArray alloc] init];
    }
    return _insuranceArray;
}

-(NSMutableArray *)seletedArray{
    if (!_seletedArray) {
        _seletedArray = [[NSMutableArray alloc] init];
    }
    return _seletedArray;
}
-(NSMutableArray *)petSeletedArray{
    if (!_petSeletedArray) {
        _petSeletedArray = [[NSMutableArray alloc] init];
    }
    return _petSeletedArray;
}
-(NSMutableArray *)petArray{
    if (!_petArray) {
        _petArray = [[NSMutableArray alloc] init];
    }
    return _petArray;
}
-(void)setFlightOrderInfoModel:(FlightOrderInfoModel *)flightOrderInfoModel{
    _flightOrderInfoModel = flightOrderInfoModel;
    
    NSInteger passengerCount = flightOrderInfoModel.passenger.count;
    for (int i=0; i<passengerCount; i++) {
        passengerModel *model = [passengerModel yy_modelWithJSON:[flightOrderInfoModel.passenger objectAtIndex:i]];
        [self.passengerArray addObject:model];
        if (i==0) {
            model.isSelected = true;
            [self.seletedArray addObject:model];
        }
    }
    
    NSInteger petCount = flightOrderInfoModel.pet.count;
    for (int i=0; i<petCount; i++) {
        MyPetInfo *model = [MyPetInfo yy_modelWithJSON:[flightOrderInfoModel.pet objectAtIndex:i]];
        [self.petArray addObject:model];
        //        if (i==0) {
        //            model.isSelected = true;
        //            [self.petSeletedArray addObject:model];
        //        }
    }
    
    self.insuranceArray = [NSArray yy_modelArrayWithClass:[InsuranceModel class] json:flightOrderInfoModel.insurance];
    [self updatePrice];
    
}
-(void)updatePrice{
    if (self.isJourney) {
        self.passengerTotalPrice = ([self.flightOrderInfoModel.to.position.par_price doubleValue] + [self.flightOrderInfoModel.back.position.par_price doubleValue]) * self.seletedArray.count;
        
        self.machineBuildTotalPrice = [self.flightOrderInfoModel.to.machine_build doubleValue] + [self.flightOrderInfoModel.back.machine_build doubleValue];
        
        self.fuelTotalPrice = [self.flightOrderInfoModel.to.fuel doubleValue] + [self.flightOrderInfoModel.back.fuel doubleValue];
        
        self.otherPrice =  self.machineBuildTotalPrice + self.fuelTotalPrice;
        
        self.petTotalPrice = [self.flightOrderInfoModel.pet_price doubleValue] *self.petSeletedArray.count*2;
        
        self.totalPrice = (self.passengerTotalPrice + self.insurancePrice*self.seletedArray.count*2 + self.otherPrice*self.seletedArray.count + self.petTotalPrice)*(1+[self.flightOrderInfoModel.pay_oddsW doubleValue]/100);
    }else{
        self.passengerTotalPrice = [self.flightOrderInfoModel.to.position.par_price doubleValue] * self.seletedArray.count;
        
        self.machineBuildTotalPrice = [self.flightOrderInfoModel.to.machine_build doubleValue];
        
        self.fuelTotalPrice = [self.flightOrderInfoModel.to.fuel doubleValue];
        
        self.otherPrice =  self.machineBuildTotalPrice + self.fuelTotalPrice;
        
        self.petTotalPrice = [self.flightOrderInfoModel.pet_price doubleValue] *self.petSeletedArray.count;
        
        self.totalPrice = (self.passengerTotalPrice + self.insurancePrice*self.seletedArray.count + self.otherPrice*self.seletedArray.count + self.petTotalPrice)*(1+[self.flightOrderInfoModel.pay_oddsW doubleValue]/100);
    }
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",[NSString stringConversionWithNumber:self.totalPrice afterPoint:2]];
    //    NSString *doubleString = [NSString stringWithFormat:@"%lf",self.totalPrice];
    //    NSDecimalNumber *totalPrice = [NSDecimalNumber decimalNumberWithString:doubleString];
    //    self.priceLabel.text = [NSString stringWithFormat:@"￥%0.2lf",(floorf([totalPrice doubleValue]*100 + 0.5))/100];
}

#pragma mark - OrderCardCellDelegate
-(void)orderCardRemoveCellWithCell:(OrderCardCell *)cell{
    if (self.seletedArray.count <= 1) {
        [HSToast hsShowBottomWithText:@"至少选择一个乘机人"];
        return;
    }
    if (self.isNoCanRemove == NO) {
        self.isNoCanRemove = YES;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        HRLog(@"删除的cell = %@",cell)
        HRLog(@"删除的row = %ld",(long)indexPath.row)
        HRLog(@"数据源条数 = %lu",(unsigned long)self.seletedArray.count)
        passengerModel *model = [self.seletedArray objectAtIndex:indexPath.row - 1];
        [self.petSeletedArray removeObject:model.pet];
        model.isSelected = false;
        model.isHavePet = NO;
        model.pet = nil;
        NSIndexPath *orderPersonIndexPath = [NSIndexPath indexPathForRow:0 inSection:1];
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:orderPersonIndexPath,nil] withRowAnimation:UITableViewRowAnimationFade];
        
        [self.seletedArray removeObjectAtIndex:indexPath.row - 1];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath]
                              withRowAnimation:UITableViewRowAnimationNone];
        [self performSelector:@selector(didRemoveRow) withObject:nil afterDelay:0.5];
        [self updatePrice];
    }
}
-(void)didRemoveRow{
    self.isNoCanRemove = NO;
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
