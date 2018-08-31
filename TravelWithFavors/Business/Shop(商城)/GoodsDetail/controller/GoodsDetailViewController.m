//
//  GoodsDetailViewController.m
//  TravelWithFavors
//
//  Created by MacBook on 2018/8/16.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "GoodsDetailViewController.h"
#import "GoodsDetailTableViewCell.h"
#import "GoodsDetailImgTableViewCell.h"
#import "GoodsBottomView.h"
#import "GoodsProduceTableViewCell.h"
#import "GoodsBuyView.h"
#import "AddressViewController.h"
#import "ShoppingCartViewController.h"

#define KLoopViewH SCREEN_WIDTH * 0.9

@interface GoodsDetailViewController ()<UITableViewDelegate, UITableViewDataSource, SDCycleScrollViewDelegate, GoodsBuyViewDelegate>
{
    UIView *view_bar;
    UIButton *shareBtn;
    UIButton *backBtn;
}
@property (nonatomic, strong) UITableView *goodsDetailtableView;
@property (nonatomic, strong) SDCycleScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *detailData;
@property (nonatomic, strong) NSArray *detailData1;

@end

@implementation GoodsDetailViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    HRLog(@"------");
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    HRLog(@"00000000");
    [self.navigationController setNavigationBarHidden:NO animated:YES];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    
    self.detailData = [@[@[@"已选:",@"航空箱ASD198（白色）"], @[@"货源:",@"大连"],@[@"详情:",@"宠物航空箱狗狗猫咪外出箱子托运箱旅行箱运输猫笼子便携咖啡色48*30*30cm"],@[@"配件:",@"航空箱ASD198（白色）"]] mutableCopy];
    self.detailData1 = @[@"http://pic1.win4000.com/wallpaper/2017-12-29/5a46108f19717.jpg", @"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1694074041,1248343633&fm=27&gp=0.jpg",@"http://pic1.win4000.com/wallpaper/2017-12-29/5a46108f19717.jpg", @"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1694074041,1248343633&fm=27&gp=0.jpg"];
    
}


#pragma mark - 轮播点击
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
    NSMutableArray *items = [[NSMutableArray alloc]init];
    NSArray *imgArr = @[@"http://pic1.win4000.com/wallpaper/2017-12-29/5a46108f19717.jpg", @"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1694074041,1248343633&fm=27&gp=0.jpg"];
    for (NSInteger i = 0; i < imgArr.count; i++) {
        
        LBPhotoWebItem *item = [[LBPhotoWebItem alloc]initWithURLString:imgArr[i]
                                                                  frame:self.goodsDetailtableView.tableHeaderView.frame];
        [items addObject:item];
    }
    
    [LBPhotoBrowserManager.defaultManager showImageWithWebItems:items selectedIndex:index fromImageViewSuperView:self.view].lowGifMemory = YES;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        GoodsProduceTableViewCell *produceCell = [tableView dequeueReusableCellWithIdentifier:@"GoodsProduceTableViewCell"];
        produceCell.selectionStyle = UITableViewCellSelectionStyleNone;
         return produceCell;
    }else if (indexPath.section == 1) {
        
        GoodsDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GoodsDetailTableViewCell"];
        cell.leftLabel.text = self.detailData[indexPath.row][0];
        cell.rightLabel.text = self.detailData[indexPath.row][1];
        
        return cell;
    }else if (indexPath.section == 2) {
        GoodsDetailImgTableViewCell *imgCell = [tableView dequeueReusableCellWithIdentifier:@"GoodsDetailImgTableViewCell"];
        imgCell.imgUrl = self.detailData1[indexPath.row];
        return imgCell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return self.detailData.count;
            break;
        case 2:
            return self.detailData1.count;
            
        default:
            return 0;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 100;
    } else if (indexPath.section == 1) {
        NSString *rightStr =  self.detailData[indexPath.row][1];
        CGFloat cellHeight = [UILabel getLabelHeightWithText:rightStr width:SCREEN_WIDTH - 70 font:12] + 10;
        return cellHeight + 5;
    }else if (indexPath.section == 2) {
        return 250;
    }
    return 0;
}

- (void)leftBtnClick:(UIButton *)btn {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)setupUI {
    
    self.view.backgroundColor = [UIColor blackColor];
    
    self.goodsDetailtableView.sectionHeaderHeight = 0;
    self.goodsDetailtableView.sectionFooterHeight = 10;
    [self.view addSubview:self.goodsDetailtableView];
    if (@available(iOS 11.0, *)) {
        self.goodsDetailtableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    _scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, KLoopViewH) imageNamesGroup:@[@"http://pic1.win4000.com/wallpaper/2017-12-29/5a46108f19717.jpg", @"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1694074041,1248343633&fm=27&gp=0.jpg"]];
    _scrollView.showPageControl = YES;
    _scrollView.delegate = self;
    self.goodsDetailtableView.tableHeaderView = _scrollView;
    
    GoodsBottomView *bottomView = [[GoodsBottomView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 44, SCREEN_WIDTH, 44)];
    [bottomView setBottomBlock:^(GoodsBottomView *bottomView, NSInteger index) {
        NSLog(@"%zd",index);
        if (index == 0) {
            ShoppingCartViewController *vc = [[ShoppingCartViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        if (index == 1 || index == 2) {
            
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            GoodsBuyView *buyView = [[GoodsBuyView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
            buyView.delegate = self;
            [buyView showInView:window transformView:self.view index:index];
        }
        
    }];
    [self.view addSubview:bottomView];
    
    [self NavigationBa];
    
}

- (void)hideBuyView {
    [UIView animateWithDuration:0.3 animations:^{
        self.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1,1);
    }];
    
}

-(UIView*)NavigationBa
{
    view_bar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, [AppConfig getNavigationBarHeight])];
    view_bar.backgroundColor = [UIColor clearColor];
    [self.view addSubview: view_bar];
    
    UILabel *title_label=[[UILabel alloc]initWithFrame:CGRectMake(65, view_bar.frame.size.height-44, self.view.frame.size.width-130, 44)];
    title_label.text = @"详情";
    title_label.font = [UIFont boldSystemFontOfSize:17];
    title_label.backgroundColor = [UIColor clearColor];
    title_label.textColor = [UIColor blackColor];
    title_label.textAlignment = 1;
    [view_bar addSubview:title_label];
    
    shareBtn=[[UIButton alloc]initWithFrame:CGRectMake(view_bar.frame.size.width-44, view_bar.frame.size.height-34, 25, 25)];
    [shareBtn setBackgroundImage:[UIImage imageNamed:@"xc_daohan_fenx_black"] forState:UIControlStateNormal];
    [shareBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [view_bar addSubview:shareBtn];
    
    backBtn=[[UIButton alloc] initWithFrame:CGRectMake(10, view_bar.frame.size.height-34, 25, 25)];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"xc_daohan_fanhui_black"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [view_bar addSubview:backBtn];
    return view_bar;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (self.goodsDetailtableView.contentOffset.y<-20) {
        
        [view_bar setHidden:YES];
        [shareBtn setBackgroundImage:[UIImage imageNamed:@"xc_daohan_fenx_black"] forState:UIControlStateNormal];
        [backBtn setBackgroundImage:[UIImage imageNamed:@"xc_daohan_fanhui_black"] forState:UIControlStateNormal];
    } else if (self.goodsDetailtableView.contentOffset.y<=KLoopViewH - [AppConfig getNavigationBarHeight]){
        [view_bar setHidden:NO];
        view_bar.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:self.goodsDetailtableView.contentOffset.y / (KLoopViewH - [AppConfig getNavigationBarHeight])];
        [shareBtn setBackgroundImage:[UIImage imageNamed:@"xc_daohan_fenx_black"] forState:UIControlStateNormal];
        [backBtn setBackgroundImage:[UIImage imageNamed:@"xc_daohan_fanhui_black"] forState:UIControlStateNormal];
    } else {
        
        [view_bar setHidden:NO];
        view_bar.backgroundColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:1];
        [shareBtn setBackgroundImage:[UIImage imageNamed:@"xc_daohan_fxwudiseh"] forState:UIControlStateNormal];
        [backBtn setBackgroundImage:[UIImage imageNamed:@"xc_daohan_fanhuihei"] forState:UIControlStateNormal];
        
    }
    
    
}

- (UITableView *)goodsDetailtableView {
    if (!_goodsDetailtableView) {
        
        _goodsDetailtableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 44) style:UITableViewStyleGrouped];
        [_goodsDetailtableView registerClass:[GoodsDetailTableViewCell class] forCellReuseIdentifier:@"GoodsDetailTableViewCell"];
        [_goodsDetailtableView registerClass:[GoodsDetailImgTableViewCell class] forCellReuseIdentifier:@"GoodsDetailImgTableViewCell"];
        [_goodsDetailtableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
        [_goodsDetailtableView registerNib:[UINib nibWithNibName:@"GoodsProduceTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"GoodsProduceTableViewCell"];
        
        _goodsDetailtableView.delegate = self;
        _goodsDetailtableView.dataSource = self;
        _goodsDetailtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _goodsDetailtableView;
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
