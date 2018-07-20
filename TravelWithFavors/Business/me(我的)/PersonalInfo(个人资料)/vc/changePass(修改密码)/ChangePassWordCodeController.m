//
//  ChangePassWordCodeController.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/9.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "ChangePassWordCodeController.h"
#import "ChangePWPassController.h"
#import "CaptchaInfo.h"
@interface ChangePassWordCodeController (){
    dispatch_source_t _timer;
}
@property (nonatomic, strong) UITextField *codeTF;
@property (nonatomic, strong) UIButton *codeBtn;
@end

@implementation ChangePassWordCodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"修改密码";
    [self configView];
}
- (void)configView{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT - [AppConfig getButtomHeight])];
    bgView.backgroundColor = [UIColor hdTableViewBackGoundColor];
    [self.view addSubview:bgView];
    
    UIView *phoneView = [[UIView alloc] initWithFrame:CGRectMake(0, [AppConfig getNavigationBarHeight] + 10, SCREEN_WIDTH, 40)];
    phoneView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:phoneView];
    
    UILabel *phoneTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 60, 20)];
    phoneTitleLabel.text = @"手机号码";
    phoneTitleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    phoneTitleLabel.font = [UIFont systemFontOfSize:14.0f];
    [phoneView addSubview:phoneTitleLabel];
    
    UITextField *phoneTF = [[UITextField alloc] initWithFrame:CGRectMake(80, 6, SCREEN_WIDTH - 80, 30)];
    phoneTF.text = self.userInfo.mobile;
    phoneTF.textColor = [UIColor colorWithHexString:@"#999999"];
    phoneTF.userInteractionEnabled = false;
    [phoneView addSubview:phoneTF];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, [AppConfig getNavigationBarHeight] + 60, SCREEN_WIDTH, 40)];
    topView.backgroundColor = [UIColor whiteColor];
    
    UILabel *topLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 60, 20)];
    topLabel.text = @"验证码";
    topLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    topLabel.font = [UIFont systemFontOfSize:14.0f];
    [topView addSubview:topLabel];
    
    self.codeBtn.frame = CGRectMake(topView.bounds.size.width - 100 - 10, (topView.bounds.size.height - 25)/2, 100, 25);
   
    [topView addSubview:self.codeBtn];
    
    self.codeTF = [[UITextField alloc] initWithFrame:CGRectMake(80, 5, CGRectGetMinX(self.codeBtn.frame) - 110, 30)];

    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.alignment = NSTextAlignmentLeft;
    NSAttributedString *attri = [[NSAttributedString alloc] initWithString:@"请输入验证码" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#999999"],NSFontAttributeName:[UIFont systemFontOfSize:12.0f], NSParagraphStyleAttributeName:style}];
    self.codeTF.attributedPlaceholder = attri;
    [topView addSubview:self.codeTF];
    [self.view addSubview:topView];
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.adjustsImageWhenHighlighted = NO;
    sureBtn.frame = CGRectMake(10, CGRectGetMaxY(topView.frame) + 84, SCREEN_WIDTH - 20, 40);
    sureBtn.layer.cornerRadius = 3;
    sureBtn.backgroundColor = [UIColor hdMainColor];
    [sureBtn setTitle:@"下一步" forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [sureBtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sureBtn];
}
- (void)nextBtnClick{
    [self.codeTF resignFirstResponder];
    if (self.codeTF.text.length > 0) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSString *url = [HttpNetRequestTool requestUrlString:@"/user/modify/verifyUpdMsg"];
        NSDictionary *dict = @{@"username":self.userInfo.mobile,@"captcha":self.codeTF.text};
        [HttpNetRequestTool netRequestWithHeader:HttpNetRequestPost urlString:url paraments:dict success:^(id Json) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            BaseModel *model = [BaseModel yy_modelWithJSON:Json];
            if (model.code == 1) {
                ChangePWPassController *vc = [[ChangePWPassController alloc] init];
                vc.code = self.codeTF.text;
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                [HSToast hsShowBottomWithText:model.msg];
            }
        } failure:^(NSString *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [HSToast hsShowBottomWithText:error];
        }];
    }else{
        [HSToast hsShowBottomWithText:@"请输入验证码"];
    }
}

- (void)codeBtnClick{
    [self getNumBtnAction];
    [self getCodeData];
}
- (void)getCodeData{
    NSString *url = [HttpNetRequestTool requestUrlString:@"/user/login/captcha"];
    NSDictionary *dict = @{@"username":[AppConfig getUserName]};
    [HttpNetRequestTool netRequest:HttpNetRequestPost urlString:url paraments:dict success:^(id Json) {
        BaseModel *model = [BaseModel yy_modelWithJSON:Json];
        if (model.code == 1) {
//            CaptchaInfo *codeInfo = [CaptchaInfo yy_modelWithJSON:model.data];
//            self.codeTF.text = codeInfo.code;
        }else{
            [HSToast hsShowBottomWithText:model.msg];
//            if (_timer) {
//                dispatch_source_cancel(_timer);
//            }
//            [self.codeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//            [self.codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
//            self.codeBtn.userInteractionEnabled = YES;
        }
    } failure:^(NSString *error) {
//        [HSToast hsShowBottomWithText:error];
//        if (_timer) {
//            dispatch_source_cancel(_timer);
//        }
//        [self.codeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [self.codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
//        self.codeBtn.userInteractionEnabled = YES;
    }];
}
- (void)getNumBtnAction{
    __block NSInteger second = 60;
    //全局队列    默认优先级
    dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //定时器模式  事件源
    if (!_timer) {
         _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, quene);
    }
    //NSEC_PER_SEC是秒，＊1是每秒
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), NSEC_PER_SEC * 1, 0);
    //设置响应dispatch源事件的block，在dispatch源指定的队列上运行
    __block typeof(self) weakSelf = self;
    dispatch_source_set_event_handler(_timer, ^{
        //回调主线程，在主线程中操作UI
        dispatch_async(dispatch_get_main_queue(), ^{
            if (second >= 0) {
                NSString *title = [NSString stringWithFormat:@"(%d)重新获取",(int)second];
                [weakSelf.codeBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                [weakSelf.codeBtn setTitle:title forState:UIControlStateNormal];
                weakSelf.codeBtn.userInteractionEnabled = NO;
                second--;
            }
            else
            {
                //这句话必须写否则会出问题
                dispatch_source_cancel(_timer);
                _timer = nil;
                [weakSelf.codeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [weakSelf.codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                weakSelf.codeBtn.userInteractionEnabled = YES;
            }
        });
    });
    //启动源
    dispatch_resume(_timer);
}
- (UIButton *)codeBtn{
    if (!_codeBtn) {
        _codeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _codeBtn.adjustsImageWhenHighlighted = NO;
        _codeBtn.backgroundColor = [UIColor hdMainColor];
        [_codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        _codeBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        _codeBtn.layer.cornerRadius = 2;
        [_codeBtn addTarget:self
        action:@selector(codeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _codeBtn;
}
//退出的时候
- (void)didMoveToParentViewController:(UIViewController *)parent{
    [super didMoveToParentViewController:parent];
    if(!parent){
        if (_timer) {
            //这句话必须写否则会出问题
            dispatch_source_cancel(_timer);
        }
    }
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
