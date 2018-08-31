//
//  MallScrollRecommendCollectionViewCell.m
//  TravelWithFavors
//
//  Created by MacBook on 2018/8/10.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "MallScrollRecommendCollectionViewCell.h"
#import "MallRecommendCollectionViewCell.h"

@interface MallScrollRecommendCollectionViewCell()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *itemCollectionView;

@end

@implementation MallScrollRecommendCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setItemRecommendScrollArr:(NSMutableArray *)itemRecommendScrollArr {
    _itemRecommendScrollArr = itemRecommendScrollArr;
}

#pragma mark - UICollectionViewDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MallRecommendCollectionViewCell *mallTyleCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MallRecommendCollectionViewCell" forIndexPath:indexPath];
    return mallTyleCell;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.itemRecommendScrollArr.count;
}
#pragma mark -- UICollectionViewDelegateFlowLayout
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((SCREEN_WIDTH - 60) / 3, (SCREEN_WIDTH - 60) / 3 * 1.3 + 60);
}

//距离collectionview的上下左右边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0,10,0,10);
}

#pragma mark --UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate mallScrollRecommendClick:indexPath.row];
 }


- (void)setupUI {
 

    [self.contentView addSubview:self.itemCollectionView];
    
}

- (UICollectionView *)itemCollectionView {
    if (!_itemCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _itemCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CONTENT_HEIGHT) collectionViewLayout:flowLayout];
        _itemCollectionView.dataSource = self;
        _itemCollectionView.delegate = self;
        _itemCollectionView.showsHorizontalScrollIndicator = NO;
        _itemCollectionView.backgroundColor = [UIColor whiteColor];
        [_itemCollectionView registerClass:[MallRecommendCollectionViewCell class] forCellWithReuseIdentifier:@"MallRecommendCollectionViewCell"];
    }
    return _itemCollectionView;
}


@end
