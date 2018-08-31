//
//  KJBuyView.m
//  Shopping
//
//  Created by apple on 2018/7/30.
//  Copyright © 2018年 CoderYS. All rights reserved.
//

#import "GoodsBuyView.h"
#import "UICollectionViewLeftAlignedLayout.h"
#import "AttributeCell.h"
#import "AttributeHeaerView.h"
#import "AttributeFooterView.h"

#define kAttributeCell          @"AttributeCell"
#define kAttributeHeaerView     @"AttributeHeaerView"
#define kAttributeFooterView     @"AttributeFooterView"

#define bgViewH SCREEN_HEIGHT * 0.8

@interface GoodsBuyView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UIView *darkView;
@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, weak) UIView *titleView;
@property (nonatomic, weak) UIImageView *iconImage;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *priceLabel;
@property (nonatomic, weak) UILabel *tipLabel;

@property (nonatomic ,strong)UICollectionView * collectionView;

@property (nonatomic, weak) UIView *bottomView;
@property (nonatomic, weak) UIButton *buyBtn;

@property (nonatomic, weak) UIButton *closeViewBtn;

@property (nonatomic ,strong)NSMutableArray * dataSource;//!<数据源

@end

@implementation GoodsBuyView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initGesture];
        [self initView];
        
        self.dataSource = [@[@[@"价款家分割法第三方士",@"价款",@"价款家分割法第",@"价方士",@"价款家分割法第三方士",@"价款家",@"价款家",@"价款家第三方士"],@[@"价款家分割法第三方士",@"价款",@"价款家分割法第",@"价方士",@"价款家分割法第三方士",@"价款家",@"价款家",@"价款家第三方士"],@[@"价款家分割法第三方士",@"价款",@"价款家分割法第",@"价方士",@"价款家分割法第三方士",@"价款家",@"价款家",@"价款家第三方士"]] mutableCopy];
    }
    return self;
}
#pragma mark - CollectionView代理
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.dataSource.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray *arr = self.dataSource[section];
    return arr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AttributeCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kAttributeCell forIndexPath:indexPath];
    NSArray *arr = self.dataSource[indexPath.section];

    cell.propsLabel.text = arr[indexPath.row];
    cell.propsLabel.textColor = [UIColor hdTipTextColor];
    cell.userInteractionEnabled = NO;
 
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *arr = self.dataSource[indexPath.section];

    NSString * string = arr[indexPath.row];
    CGFloat width = (string.length + 2) * 12;
    return CGSizeMake(width, 25);
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader){
        AttributeHeaerView * headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kAttributeHeaerView forIndexPath:indexPath];
        headView.titleLabel.text = @"颜色";
        headView.alertLabel.hidden = YES;
        headView.specLabel.hidden = YES;
        return headView;
    }else {
        UICollectionReusableView *reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView" forIndexPath:indexPath];
        if (indexPath.section == self.dataSource.count - 1) {
            AttributeFooterView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kAttributeFooterView forIndexPath:indexPath];

            reusableview = footerView;
        }
        return reusableview;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(SCREEN_WIDTH, 30);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (section == self.dataSource.count - 1) {
        return CGSizeMake(SCREEN_WIDTH, 60);
    }
    return CGSizeZero;
}


- (void)bottomBtnClick:(UIButton *)btn {
    
}

- (void)closeViewBtnClick:(UIButton *)btn {
    
    [self dismiss];
}


- (void)initGesture {
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [self.darkView addGestureRecognizer:tap];
}

- (void)showInView:(UIView *)view transformView:(UIView *)transformView index:(NSInteger)index{
    if (index == 1) {
        self.buyBtn.backgroundColor = [UIColor colorWithHexString:@"#ff900d"];
        [self.buyBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
        
    }else {
        self.buyBtn.backgroundColor = [UIColor hdRedColor];
        [self.buyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    }
    [self show:view transform:transformView];
}
- (void)show:(UIView *)view transform:(UIView *)transformView{
    
    [UIView animateWithDuration:0.3 animations:^{
        
        transformView.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.9,0.9);
        self.bgView.y -= bgViewH;
        
    } completion:^(BOOL finished) {
    }];
    
    [view addSubview:self];
}

- (void)dismiss {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(hideBuyView)]) {
        [self.delegate hideBuyView];
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.bgView.y += bgViewH;
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
}
- (void)initView {
    [self addSubview:self.darkView];
    [self addSubview:self.bgView];
    
    UIView *titleView = [[UIView alloc] init];
    titleView.backgroundColor = [UIColor whiteColor];
    [self.bgView addSubview:titleView];
    self.titleView = titleView;
    
    UIImageView *iconImage = [[UIImageView alloc] init];
    iconImage.backgroundColor = [UIColor hdPlaceHolderColor];
    [titleView addSubview:iconImage];
    self.iconImage = iconImage;
    [self.iconImage addTapGestureRecognizer:^(id parameter) {
        NSMutableArray *items = [[NSMutableArray alloc]init];
        LBPhotoWebItem *item = [[LBPhotoWebItem alloc]initWithURLString:@"" frame:iconImage.frame];
        [items addObject:item];
        [LBPhotoBrowserManager.defaultManager showImageWithWebItems:items selectedIndex:0 fromImageViewSuperView:self].lowGifMemory = YES;
    }];
    
    UILabel *titleLable = [[UILabel alloc] init];
    titleLable.font = [UIFont systemFontOfSize:15];
    titleLable.textColor = [UIColor blackColor];
    titleLable.text = @"宠物航空箱狗狗猫咪外出箱子托运箱旅行箱运输猫笼子便携咖啡色48*30*30cm";
//    [titleView addSubview:titleLable];
    self.titleLabel = titleLable;
    
    UILabel *priceLabel = [[UILabel alloc] init];
    priceLabel.font = [UIFont systemFontOfSize:15];
    priceLabel.textColor = [UIColor hdRedColor];
    priceLabel.text = @"￥799";
    [titleView addSubview:priceLabel];
    self.priceLabel = priceLabel;
    
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.font = [UIFont systemFontOfSize:12];
    tipLabel.textColor = [UIColor hdTipTextColor];
    tipLabel.text = @"库存：224";
    [titleView addSubview:tipLabel];
    self.tipLabel = tipLabel;
    
    UIButton *closeViewBtn = [[UIButton alloc] init];
    [closeViewBtn setImage:[UIImage imageNamed:@"gg_gb"] forState:UIControlStateNormal];
    [closeViewBtn addTarget:self action:@selector(closeViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.bgView addSubview:closeViewBtn];
    self.closeViewBtn = closeViewBtn;
    
    [self createCollectionView];
   
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.bgView addSubview:bottomView];
    self.bottomView = bottomView;
    
    UIButton *buyBtn = [[UIButton alloc] init];
    buyBtn.tag = 1;
    buyBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [buyBtn setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [buyBtn addTarget:self action:@selector(bottomBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:buyBtn];
    self.buyBtn = buyBtn;

}

///规格列表
- (void)createCollectionView{
    UICollectionViewLeftAlignedLayout * flowLayout = [[UICollectionViewLeftAlignedLayout alloc]init];
    flowLayout.minimumInteritemSpacing = 15;
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.bgView addSubview:self.collectionView];
    [self.collectionView registerNib:[UINib nibWithNibName:kAttributeCell bundle:nil] forCellWithReuseIdentifier:kAttributeCell];
    [self.collectionView registerNib:[UINib nibWithNibName:kAttributeHeaerView bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kAttributeHeaerView];
    [self.collectionView registerClass:[AttributeFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kAttributeFooterView];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
 
    
}
- (UIView *)darkView {
    if (!_darkView) {
        _darkView = [[UIView alloc]init];
        _darkView.frame = CGRectMake(0, 0, self.width, self.height);
        _darkView.backgroundColor = [UIColor blackColor];
        _darkView.alpha = 0.6;
    }
    return _darkView;
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.frame = CGRectMake(0, self.height, self.width, bgViewH);
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.titleView.frame = CGRectMake(0, 0, self.bgView.width, 100);
    self.iconImage.frame = CGRectMake(10, 10, 80, 80);
    
    [self.titleLabel sizeToFit];
    self.titleLabel.x = self.iconImage.right + 10;
    self.titleLabel.y = 10;
    
    [self.tipLabel sizeToFit];
    self.tipLabel.x = self.iconImage.right + 10;
    self.tipLabel.y = self.iconImage.bottom - self.tipLabel.height;
    self.tipLabel.width = self.bgView.width - self.iconImage.right - 20;
    
    [self.priceLabel sizeToFit];
    self.priceLabel.x = self.iconImage.right + 10;
    self.priceLabel.y = self.iconImage.bottom - self.tipLabel.height - self.priceLabel.height;
    
    self.closeViewBtn.frame = CGRectMake(self.bgView.width - 35, 10, 25, 25);
    
    self.collectionView.frame = CGRectMake(0, self.titleView.bottom, self.bgView.width, self.bgView.height - 144);

    
    self.bottomView.frame = CGRectMake(0, self.bgView.height - 44, self.bgView.width, 44);
//    self.joinBtn.frame = CGRectMake(0, 0, self.bottomView.width * 0.5, 44);
    self.buyBtn.frame = CGRectMake(0, 0, self.bottomView.width, 44);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
