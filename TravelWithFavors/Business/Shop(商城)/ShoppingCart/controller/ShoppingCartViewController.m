
//
//  ShoppingCartViewController.m
//  TravelWithFavors
//
//  Created by MacBook on 2018/8/22.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "ShoppingCartViewController.h"
#import "ShopCartCollectionViewCell.h"
#import "ShopCartCollectionReusableView.h"
#import "MallSearchResultCollectionViewCell.h"
#import "MallPupolarListCollectionReusableView.h"
#import "ShopCartBottomView.h"
#import "MallOrderViewController.h"

@interface ShoppingCartViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *shopCartcollectionView;
/**
 选中的数组
 */
@property (nonatomic, strong) NSMutableArray *selectArray;

@end

@implementation ShoppingCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"购物车";
    [self setupUI];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (!collectionView.panGestureRecognizer.enabled) {
        [collectionView endConfirmationState];
    }else {
        
    }
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
   
    return 4;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        ShopCartCollectionViewCell *cartCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShopCartCollectionViewCell" forIndexPath:indexPath];
        cartCell.collectionView = collectionView;
        
        cartCell.shopCarListClickBlock = ^(BOOL isClick) {
            
        };
        return cartCell;
    }else {
    
        MallSearchResultCollectionViewCell *cartCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MallSearchResultCollectionViewCell" forIndexPath:indexPath];
        
        return cartCell;
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
 
        MallPupolarListCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MallPupolarListCollectionReusableView" forIndexPath:indexPath];
 
        headerView.headerImgStr = @"wntje";
        reusableView = headerView;
 
    }
    return reusableView;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return CGSizeMake(SCREEN_WIDTH, 50);
    }
    // 个数*90+头视图10
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return CGSizeMake(SCREEN_WIDTH, 90);
    }
    return CGSizeMake((SCREEN_WIDTH - 30) / 2, (SCREEN_WIDTH - 30) / 2.0 * 4 / 3 + 65);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section == 0) {
      return UIEdgeInsetsMake(10, 0, 0, 0);
    }
   return UIEdgeInsetsMake(0, 10, 10, 10);
}



- (void)setupUI {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
     self.shopCartcollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 50) collectionViewLayout:layout];
    self.shopCartcollectionView.delegate = self;
    self.shopCartcollectionView.dataSource = self;
    self.shopCartcollectionView.backgroundColor = [UIColor hdTableViewBackGoundColor];

    [self.shopCartcollectionView registerNib:[UINib nibWithNibName:@"ShopCartCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"ShopCartCollectionViewCell"];

    [self.shopCartcollectionView registerNib:[UINib nibWithNibName:@"MallSearchResultCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"MallSearchResultCollectionViewCell"];

    [self.shopCartcollectionView registerNib:[UINib nibWithNibName:@"ShopCartCollectionReusableView" bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ShopCartCollectionReusableView"];
    [self.shopCartcollectionView registerClass:[MallPupolarListCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MallPupolarListCollectionReusableView"];
 

    [self.view addSubview:self.shopCartcollectionView];
    
    ShopCartBottomView *bottomView = [[ShopCartBottomView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 50, SCREEN_WIDTH, 50)];
    bottomView.shopCartbottomBlock = ^(NSInteger index,BOOL isClick) {
        // 0全选 1结算
        if (index == 0) {
            
            if (isClick) {
            
            }else {
                
                
            }
            
        }else {
            MallOrderViewController *vc = [[MallOrderViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    };
    [self.view addSubview:bottomView];
}
- (NSMutableArray *)selectArray {
    if (!_selectArray) {
        self.selectArray = [NSMutableArray new];
    }
    return _selectArray;
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
