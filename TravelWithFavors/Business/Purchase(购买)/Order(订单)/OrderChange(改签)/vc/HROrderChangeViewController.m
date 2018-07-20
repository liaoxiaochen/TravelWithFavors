//
//  HROrderChangeViewController.m
//  TravelWithFavors
//
//  Created by cushiro on 2018/4/13.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "HROrderChangeViewController.h"
#import "OrderDetailFlightInfoCell.h"

#import "OrderDetailInfoController.h"
#import "OrderChangeController.h"
#import "OrderDetailInfoController.h"

static NSString *const cellID = @"OrderDetailFlightInfoCell";
@interface HROrderChangeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic , strong) NSMutableDictionary * dict;
@end

@implementation HROrderChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"确认改签信息";
    
    [self initTableView];
}
#pragma mark - lazy load & setUp View
- (NSMutableDictionary *)dict
{
    if (!_dict) {
        _dict = [NSMutableDictionary dictionary];
    }
    return _dict;
}
-(void)initTableView{
    self.tableView.backgroundColor = [UIColor hdTableViewBackGoundColor];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 210;
    self.tableView.estimatedRowHeight = 210;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([OrderDetailFlightInfoCell class]) bundle:nil] forCellReuseIdentifier:cellID];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderDetailFlightInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.orderModel = self.orderModel;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (@available(iOS 11.0, *)) {
        return 0;
    }
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (@available(iOS 11.0, *)) {
        return 0;
    }
    return 0.01;
}
#pragma mark - 点击事件
- (IBAction)confirmBtnClick:(UIButton *)sender {
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"确认申请改签？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSString *url = [HttpNetRequestTool requestUrlString:@"/user/order/changeTicket"];
        NSDictionary *dict = @{@"orderno":self.orderno?:@"",@"flight_id":self.aircode1,@"position_id":self.positionId};
        HRLog(@"%@",dict)
        [HttpNetRequestTool netRequest:HttpNetRequestPost urlString:url outTime:20 paraments:dict isHeader:YES success:^(id Json) {
            HRLog(@"%@",Json)
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            BaseModel *model = [BaseModel yy_modelWithJSON:Json];
            if (model.code == 1) {
                HRorderChangeModel *orderChangeModel = [HRorderChangeModel getOrderChangeInfo:model.data];
                OrderChangeController *vc = [[OrderChangeController alloc] init];
                vc.orderChangeModel = orderChangeModel;
                for (UIViewController *vc1 in self.navigationController.viewControllers) {
                    if ([vc1 isKindOfClass:[OrderDetailInfoController class]]) {
                        [self.navigationController popToViewController:vc1 animated:YES];
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"orderDetailPage" object:nil];
                        [vc1.navigationController pushViewController:vc animated:YES];
                        break;
                    }
                }
            }else{
                [HSToast hsShowBottomWithText:model.msg];
            }
        } failure:^(NSString *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [HSToast hsShowBottomWithText:error];
        }];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVC addAction:action1];
    [alertVC addAction:cancelAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}

@end
