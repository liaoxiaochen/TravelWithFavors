//
//  MallViewController.m
//  TravelWithFavors
//
//  Created by MacBook on 2018/8/13.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "MallViewController.h"

#import "PYSearch.h"
#import "MallSearchResultViewController.h"
#import "GoodsDetailViewController.h"
#import "MallTypeItemCollectionViewCell.h"
#import "MallScrollRecommendCollectionViewCell.h"
#import "MallBannerCollectionViewCell.h"

#import "MallTypeCollectionReusableView.h"
#import "MallSectionCollectionReusableView.h"
#import "MallPupolarListCollectionReusableView.h"

#import "MallSearchResultCollectionViewCell.h"
#import "GoodsTypeCollectionViewCell.h"
#import "MallInfoCollectionViewCell.h"

#import "XPCollectionViewWaterfallFlowLayout.h"


static NSString *const headerCell = @"header";
#define colWidth (SCREEN_WIDTH - 30) / 2.0 * 4 / 3.0 + 50

@interface MallViewController ()<PYSearchViewControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource, XPCollectionViewWaterfallFlowLayoutDataSource, MallBannerDelegate, MallScrollRecommendDelegate>

@property (nonatomic, strong) UIButton *searchBtn;
@property (nonatomic, strong) UIImageView *searchImageView;
@property (nonatomic, assign) CGFloat headerOffsetY;

@property (nonatomic, strong) UICollectionView *shopCollectionView;

@property (nonatomic, strong) NSArray *firtSectionArr;
 
@property (nonatomic, strong) NSMutableArray<NSMutableArray<NSNumber *> *> *datas;

@property (nonatomic, strong) UIButton *topBtn;

@end

@implementation MallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"商城";
    _datas = [NSMutableArray array];
    
    NSMutableArray *cellheightArr = [NSMutableArray array];
    [cellheightArr addObject:@((SCREEN_WIDTH - 30) / 2 / 1.46 + 50)];
    for (int i = 0; i<9; i++) {
        CGFloat cellHeight = (SCREEN_WIDTH - 30) / 2.0 * 4 / 3 + 65;
        [cellheightArr addObject:@(cellHeight)];
    }
    
    _datas = [@[@[@(100),@(100),@(100),@(100),@(100)],@[@(SCREEN_WIDTH / 2.3)],@[@((SCREEN_WIDTH - 60) / 3 * 1.3 + 60)]] mutableCopy];
    [_datas addObject:cellheightArr];
    
    [self initData];
    [self setupUI];
    
}
#pragma mark - Item Select
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        [self pushSearchResult:YES];
    }else if (indexPath.section == 3) {
        GoodsDetailViewController *vc = [[GoodsDetailViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)mallBannerClick:(NSInteger)index {
    
    HRLog(@"%ld", index);
}
- (void)mallScrollRecommendClick:(NSInteger)index {
    HRLog(@"%ld", index);
    GoodsDetailViewController *vc = [[GoodsDetailViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)searchBtnAction {
    
    // 1.创建热门搜索
    NSArray *hotSeaches = @[@"有氧舱", @"猫咪沐浴露", @"有氧舱 大号"];
    // 2. 创建控制器
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:@"搜索" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        // 开始搜索执行以下代码
        // 如：跳转到指定控制器
        MallSearchResultViewController *vc = [[MallSearchResultViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.isType = NO;
        [searchViewController.navigationController pushViewController:vc animated:YES];
//        [searchViewController.navigationController pushViewController:[[MallSearchResultViewController alloc] init] animated:YES];
    }];
    searchViewController.hotSearchStyle = PYSearchHistoryStyleDefault;
    searchViewController.searchHistoryStyle = PYSearchHistoryStyleBorderTag;
    // 4. 设置代理
    searchViewController.delegate = self;
    searchViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchViewController animated:YES];
    
}
- (void)pushSearchResult:(BOOL)isType {
    MallSearchResultViewController *vc = [[MallSearchResultViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.isType = isType;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UICollectionViewDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        MallTypeItemCollectionViewCell *mallTyleCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MallTypeItemCollectionViewCell" forIndexPath:indexPath];
        mallTyleCell.itemArr = self.firtSectionArr[indexPath.row];
        return mallTyleCell;
    }else if (indexPath.section == 1) {
        MallBannerCollectionViewCell *mallTyleCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MallBannerCollectionViewCell" forIndexPath:indexPath];
        mallTyleCell.delegate = self;
        return mallTyleCell;
    } else if (indexPath.section == 2) {
        MallScrollRecommendCollectionViewCell *mallTyleCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MallScrollRecommendCollectionViewCell" forIndexPath:indexPath];
        mallTyleCell.delegate = self;
        mallTyleCell.itemRecommendScrollArr = [@[@"",@"",@"",@"",@"",@""] mutableCopy];
        return mallTyleCell;
    }else if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            MallInfoCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MallInfoCollectionViewCell" forIndexPath:indexPath];
            
            return cell;
        }
        MallSearchResultCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MallSearchResultCollectionViewCell" forIndexPath:indexPath];
 
        return cell;
    }
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader){
        if (indexPath.section == 0) {
            MallTypeCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerCell forIndexPath:indexPath];
            reusableview = headerView;
        }else if (indexPath.section == 2) {
            MallSectionCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MallSectionCollectionReusableView" forIndexPath:indexPath];
            reusableview = headerView;
        }else if (indexPath.section == 3) {
            MallPupolarListCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MallPupolarListCollectionReusableView" forIndexPath:indexPath];
            headerView.headerImgStr = @"rqbd";
            reusableview = headerView;
        }
    }
    return reusableview;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.datas.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.datas objectAtIndex:section].count;

}

- (NSInteger)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout *)layout numberOfColumnInSection:(NSInteger)section {

    if (section == 3) {
        return 2;
    }else if (section == 0) {
        return 5;
    }else {
        return 1;
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout *)layout itemWidth:(CGFloat)width heightForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSNumber *number = self.datas[indexPath.section][indexPath.item];
    return [number floatValue];
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout *)layout insetForSectionAtIndex:(NSInteger)section {
    if (section == 3) {
        return UIEdgeInsetsMake(10, 10, 10, 10);
    }
    return UIEdgeInsetsMake(0, 0, 10.0, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout*)layout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if (section == 3) {
        return 10;
    }
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout*)layout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    if (section == 3) {
        return 10;
    }
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout *)layout referenceHeightForHeaderInSection:(NSInteger)section {
    if (section == 0 || section == 2 || section == 3) {
        return 30;
    }
    return 0;
}


- (void)initData {
    
    self.firtSectionArr = @[@[@"出行", @"sc_cs"], @[@"美食", @"sc_ms"], @[@"美容", @"sc_mr"],@[@"医疗", @"sc_yl"],@[@"其他", @"sc_qt"]];
}

- (void)setupUI {
    
    _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _searchBtn.frame = CGRectMake(20, 25, SCREEN_WIDTH - 40, 30);
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
    
    
    
    XPCollectionViewWaterfallFlowLayout *flowLayout = [[XPCollectionViewWaterfallFlowLayout alloc] init];
    flowLayout.dataSource = self;
    flowLayout.sectionHeadersPinToVisibleBounds = YES;

    _shopCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - [AppConfig getTabBarHeight]) collectionViewLayout:flowLayout];
    _shopCollectionView.dataSource = self;
    _shopCollectionView.delegate = self;
    _shopCollectionView.backgroundColor = [UIColor hdTableViewBackGoundColor];
    _shopCollectionView.showsVerticalScrollIndicator = NO;
    [_shopCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    [_shopCollectionView registerClass:[MallTypeItemCollectionViewCell class] forCellWithReuseIdentifier:@"MallTypeItemCollectionViewCell"];
    [_shopCollectionView registerClass:[MallScrollRecommendCollectionViewCell class] forCellWithReuseIdentifier:@"MallScrollRecommendCollectionViewCell"];
    [_shopCollectionView registerClass:[MallBannerCollectionViewCell class] forCellWithReuseIdentifier:@"MallBannerCollectionViewCell"];
    [_shopCollectionView registerClass:[MallInfoCollectionViewCell class] forCellWithReuseIdentifier:@"MallInfoCollectionViewCell"];

    
//    [_shopCollectionView registerNib:[UINib nibWithNibName:@"GoodsTypeCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"GoodsTypeCollectionViewCell"];
    [_shopCollectionView registerNib:[UINib nibWithNibName:@"MallSearchResultCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"MallSearchResultCollectionViewCell"];
    
    
    [_shopCollectionView registerClass:[MallTypeCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerCell];
    [_shopCollectionView registerClass:[MallSectionCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MallSectionCollectionReusableView"];
    [_shopCollectionView registerClass:[MallPupolarListCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MallPupolarListCollectionReusableView"];
    [self.view addSubview:_shopCollectionView];
    
    [self.view addSubview:self.topBtn];
 }



- (void)topBtnAction {
    
    [self.shopCollectionView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
}

- (UIButton *)topBtn {
    if (!_topBtn) {
        _topBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 60, SCREEN_HEIGHT - [AppConfig getTabBarHeight] - 60, 40, 40)];
        [_topBtn setImage:[UIImage imageNamed:@"sc_top"] forState:UIControlStateNormal];
        [_topBtn addTarget:self action:@selector(topBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _topBtn.hidden = YES;
    }
    return _topBtn;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
