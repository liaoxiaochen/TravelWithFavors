//
//  MyLevelHeaderView.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/8.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "MyLevelHeaderView.h"
#import "MyLevelCollectionCell.h"
static NSString *const cellID = @"MyLevelCollectionCell";
@interface MyLevelHeaderView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *levelLists;
@end
@implementation MyLevelHeaderView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.level = -1;//默认不是
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 1;
    layout.minimumInteritemSpacing = 1;
    layout.itemSize = CGSizeMake((SCREEN_WIDTH - 1)/2, 60);
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.collectionViewLayout = layout;
    self.collectionView.scrollEnabled = NO;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:cellID bundle:nil] forCellWithReuseIdentifier:cellID];
    [self.collectionView reloadData];
}
- (void)setLevel:(NSInteger)level{
    _level = level;
    if (level >= 0 && level < self.levelLists.count) {
        NSDictionary *dict = self.levelLists[level];
        self.levelLabel.text = dict[@"title"];
        self.levelLabel.textColor = [UIColor hdYellowColor];
       
    }else{
        self.levelLabel.text = @"您还不是会员";
        self.levelLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    }
    [self.collectionView reloadData];
}
#pragma mark --UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.levelLists.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MyLevelCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    NSDictionary *dict = self.levelLists[indexPath.row];
    if (self.level == indexPath.row) {
        cell.levelImageView.image = [UIImage imageNamed:dict[@"selected"]];
    }else{
        cell.levelImageView.image = [UIImage imageNamed:dict[@"image"]];
    }
    cell.levelLabel.text = dict[@"title"];
    return cell;
}
#pragma mark --load
- (NSArray *)levelLists{
    if (!_levelLists) {
        _levelLists = @[@{@"title":@"携宠会员",@"image":@"xchy",@"selected":@"xchyd"},@{@"title":@"黄金会员",@"image":@"hjhy",@"selected":@"hjhyd"},@{@"title":@"白金会员",@"image":@"bjhy",@"selected":@"bjhyd"},@{@"title":@"钻石会员",@"image":@"zshy",@"selected":@"zshy"}];
    }
    return _levelLists;
}
@end
