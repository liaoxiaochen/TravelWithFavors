//
//  PictureViewCell.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/3.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "PictureViewCell.h"
#import "PictureCell.h"
#import "PictureMoreCell.h"
static NSString *const cellID = @"PictureCell";
static NSString *const cellMoreID = @"PictureMoreCell";
@interface PictureViewCell ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collelction;
@property (nonatomic, strong) NSArray *dataLists;
@end
@implementation PictureViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.collelction];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.collelction.frame = CGRectMake(10, 10, self.bounds.size.width - 10, self.bounds.size.height - 30);
}
- (void)setImageLists:(NSArray *)imageLists{
    _imageLists = imageLists;
    self.dataLists = imageLists;
    [self.collelction reloadData];
}
#pragma mark --UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.dataLists.count < 9) {
        return self.dataLists.count + 1;
    }
    return self.dataLists.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataLists.count == indexPath.row && self.dataLists.count < 9) {
        PictureMoreCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellMoreID forIndexPath:indexPath];
        return cell;
    }
    PictureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.pictreImageView.image = self.dataLists[indexPath.row];
    __block typeof(self) weakSelf = self;
    cell.close = ^{
        [weakSelf closeCell:indexPath.row];
    };
    return cell;
}
- (void)closeCell:(NSInteger)index{
    if (self.delegate && [self.delegate respondsToSelector:@selector(deleteImageAtIndex:)]) {
        [self.delegate deleteImageAtIndex:index];
    }
}
#pragma  mark --UICollectionViewDelegateFlowLayout
//- (CGSize)cellectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    return CGSizeMake(70, 70);
//}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == self.imageLists.count) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(deleteImageAtIndex:)]) {
            [self.delegate deleteImageAtIndex:indexPath.row];
        }
    }
}
+ (CGFloat)cellHeight:(NSArray *)dataLists{
    NSInteger spa = (dataLists.count + 1 + 3)/4;
    return 70 * spa + 10 *(spa - 1) + 30;
}
#pragma mark --load--
- (UICollectionView *)collelction{
    if (!_collelction) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 0;
        layout.itemSize = CGSizeMake(70, 70);
        _collelction = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collelction.backgroundColor = [UIColor whiteColor];
        _collelction.delegate = self;
        _collelction.dataSource = self;
        _collelction.scrollEnabled = NO;
        [_collelction registerNib:[UINib nibWithNibName:cellID bundle:nil] forCellWithReuseIdentifier:cellID];
        [_collelction registerNib:[UINib nibWithNibName:cellMoreID bundle:nil] forCellWithReuseIdentifier:cellMoreID];
    }
    return _collelction;
}
- (NSArray *)dataLists{
    if (!_dataLists) {
        _dataLists = [[NSArray alloc] init];
    }
    return _dataLists;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
