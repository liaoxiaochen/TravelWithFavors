//
//  MallSearchResultViewController.m
//  TravelWithFavors
//
//  Created by MacBook on 2018/8/8.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "MallSearchResultViewController.h"
#import "MallSearchResultCollectionViewCell.h"
#import "GoodsTypeCollectionViewCell.h"
#import "XPCollectionViewWaterfallFlowLayout.h"
#import "PYSearchViewController.h"
#import "SortView.h"
#import "MXPullDownMenu.h"
#import "GoodsDetailViewController.h"
#import "ShoppingCartViewController.h"

#define colMargin 5
#define colCount 2
#define rowMargin 5
#define colWidth (SCREEN_WIDTH - 30) / 2.0 * 4 / 3.0 + 50

@interface MallSearchResultViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, XPCollectionViewWaterfallFlowLayoutDataSource, PYSearchViewControllerDelegate, MXPullDownMenuDelegate>

@property(nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic, strong) SortView *sortView;

@property (nonatomic,strong) XPCollectionViewWaterfallFlowLayout *waterfallLayout;
 
@property (nonatomic, strong) NSMutableArray<NSMutableArray<NSNumber *> *> *datas;

@property (nonatomic, strong) UIButton *searchBtn;
@property (nonatomic, strong) UIImageView *searchImageView;
//@property (nonatomic, strong) UILabel *numberLabel;
@end

@implementation MallSearchResultViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _datas = [NSMutableArray array];
    NSMutableArray *cellheightArr = [NSMutableArray array];
    [cellheightArr addObject:@(95)];
    for (int i = 0; i<9; i++) {
        CGFloat cellHeight = (SCREEN_WIDTH - 30) / 2.0 * 4 / 3 + 65;
        [cellheightArr addObject:@(cellHeight)];
    }
    [_datas addObject:cellheightArr];

    [self setupNav];
    [self createCollectionView];
    
}

- (void)shopCarClickAction {
    
    ShoppingCartViewController *vc = [[ShoppingCartViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)searchBtnAction {
    
    // 1.创建热门搜索
    NSArray *hotSeaches = @[@"有氧舱", @"猫咪沐浴露", @"有氧舱 大号"];
    // 2. 创建控制器
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:@"搜索" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        // 开始搜索执行以下代码
        // 如：跳转到指定控制器
        [searchViewController.navigationController pushViewController:[[MallSearchResultViewController alloc] init] animated:YES];
    }];
    searchViewController.hotSearchStyle = PYSearchHistoryStyleDefault;
    searchViewController.searchHistoryStyle = PYSearchHistoryStyleBorderTag;
    // 4. 设置代理
    searchViewController.delegate = self;
    searchViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchViewController animated:YES];
    
}
- (void)PullDownMenu:(MXPullDownMenu *)pullDownMenu didSelectRowAtColumn:(NSInteger)column row:(NSInteger)row {
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    GoodsDetailViewController *vc = [[GoodsDetailViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)setupNav {
    _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _searchBtn.frame = CGRectMake(20, 25, SCREEN_WIDTH - 100, 30);
    _searchBtn.backgroundColor = [UIColor whiteColor];
    [_searchBtn setTitle:@"搜索你想要的商品名称" forState:UIControlStateNormal];
    _searchBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [_searchBtn setTitleColor:[UIColor hdPlaceHolderColor] forState:UIControlStateNormal];
    _searchBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 20 , 0, -20);
    _searchBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 30 , 0, -30);
    _searchBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_searchBtn addTarget:self action:@selector(searchBtnAction) forControlEvents:UIControlEventTouchUpInside];
    ViewRadius(_searchBtn, 15);
    self.navigationItem.titleView = _searchBtn;
    
    _searchImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 5, 20, 21)];
    _searchImageView.image = [UIImage imageNamed:@"home_search"];
    [_searchBtn addSubview:_searchImageView];
    
 
    [self addTopNotice];
 
    
}

-(void)addTopNotice{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"sc_gwctb"] forState:UIControlStateNormal];
    button.frame = CGRectMake(0,100,button.currentImage.size.width, button.currentImage.size.height);
    [button addTarget:self action:@selector(shopCarClickAction) forControlEvents:UIControlEventTouchDown];

    // 添加角标
    UIBarButtonItem *navLeftButton = [[UIBarButtonItem alloc] initWithCustomView:button];
//    UIBarButtonItem *navLeftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"sc_gwctb"] style:UIBarButtonItemStylePlain target:self action:@selector(shopCarClickAction)];
    self.navigationItem.rightBarButtonItem = navLeftButton;
    self.navigationItem.rightBarButtonItem.badgeValue = @"1";
    self.navigationItem.rightBarButtonItem.badgeBGColor = [UIColor redColor];

}

-(void)createCollectionView
{
    
    self.sortView = [[SortView alloc] initWithFrame:CGRectMake(0, [AppConfig getNavigationBarHeight], SCREEN_WIDTH, 30)];
    [self.view addSubview:self.sortView];

    
    NSArray *testArray;
    testArray = @[@[@"品牌", @"金尚", @"雀路", @"下拉菜单", @"的点击做" , @"出反馈" , @"就是这样" ], @[@"年龄", @"18"], @[@"口味", @"水果", @"面食", @"肉类", @"素食"] , @[@"产地", @"大连", @"内蒙", @"上海", @"辽宁"] ];
    MXPullDownMenu *menu = [[MXPullDownMenu alloc] initWithArray:testArray selectedColor:[UIColor hdRedColor]];
    menu.delegate = self;
     menu.frame = CGRectMake(0, CGRectGetMaxY(self.sortView.frame), SCREEN_WIDTH, 30);
    [self.view addSubview:menu];
    if (self.isType) {
        menu.height = 30;
    }else {
        menu.height = 0;
    }
    
    
   // 自定义瀑布流
    self.waterfallLayout = [[XPCollectionViewWaterfallFlowLayout alloc] init];
    self.waterfallLayout.dataSource = self;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(menu.frame), SCREEN_WIDTH, SCREEN_HEIGHT - CGRectGetMaxY(menu.frame)) collectionViewLayout:self.waterfallLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    
     [self.collectionView registerNib:[UINib nibWithNibName:@"GoodsTypeCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"GoodsTypeCollectionViewCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"MallSearchResultCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"MallSearchResultCollectionViewCell"];
    [self.view addSubview:self.collectionView];
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        GoodsTypeCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GoodsTypeCollectionViewCell" forIndexPath:indexPath];
        
        return cell;
    }
    MallSearchResultCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MallSearchResultCollectionViewCell" forIndexPath:indexPath];
 
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.datas.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.datas objectAtIndex:section].count;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout *)layout numberOfColumnInSection:(NSInteger)section {
    return 2;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout *)layout itemWidth:(CGFloat)width heightForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSNumber *number = self.datas[indexPath.section][indexPath.item];
    return [number floatValue];
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout *)layout insetForSectionAtIndex:(NSInteger)section {
         return UIEdgeInsetsMake(10, 10, 10, 10);
 }
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout*)layout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
         return 10;
 
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout*)layout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
         return 10;
 
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout *)layout referenceHeightForHeaderInSection:(NSInteger)section {
    return 0;
}


- (void)searchBtnAction:(UIButton *)btn {
    
    
    
}

- (UIButton *)searchBtn {
    if (!_searchBtn) {
        _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _searchBtn.backgroundColor = [UIColor whiteColor];
        _searchBtn.layer.cornerRadius = 10;
        [_searchBtn setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
        [_searchBtn setTitle:@"有氧舱" forState:(UIControlStateNormal)];
        _searchBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _searchBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        _searchBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_searchBtn addTarget:self action:@selector(searchBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchBtn;
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
