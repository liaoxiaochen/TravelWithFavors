//
//  ShareCustomView.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/3.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "ShareCustomView.h"
#import "ShareCustomCell.h"
static NSString *const cellID = @"ShareCustomCell";
@interface ShareCustomView ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *dataLists;
@end
@implementation ShareCustomView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
//        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
        
        self.bgView.frame = CGRectMake(0, frame.size.height, frame.size.width, 200);
        [self addSubview:self.bgView];
        
        UILabel *shareLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 21, self.bgView.bounds.size.width - 20, 30)];
        shareLabel.text = @"分享到";
        shareLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        shareLabel.textAlignment = NSTextAlignmentCenter;
        shareLabel.font = [UIFont systemFontOfSize:14.0f];
        [self.bgView addSubview:shareLabel];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(shareLabel.frame) + 20, self.bgView.bounds.size.width, 1)];
        line.backgroundColor = [UIColor colorWithHexString:@"#DDDDDD"];
        [self.bgView addSubview:line];
        
        self.collectionView.frame = CGRectMake(0, CGRectGetMaxY(line.frame), self.bgView.bounds.size.width, self.bgView.bounds.size.height - CGRectGetMaxY(line.frame));
        [self.bgView addSubview:self.collectionView];
        
    }
    return self;
}
- (void)showShareCustomView{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0.2 animations:^{
        self.bgView.frame = CGRectMake(0, self.frame.size.height - 200, self.frame.size.width, 200);

    }];
}
- (void)dismiss{
    
    [UIView animateWithDuration:0.2 animations:^{
    
        self.bgView.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, 200);

    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point=[[touches anyObject] locationInView:self];
        if (![self.bgView.layer containsPoint:point]) {
            [self dismiss];
    }
}
#pragma mark --UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataLists.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ShareCustomCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    NSDictionary *dic = self.dataLists[indexPath.row];
    cell.topImageView.image = [UIImage imageNamed:dic[@"image"]];
    cell.titleLabel.text = dic[@"title"];
    return cell;
}
#pragma mark --UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(collectionView.bounds.size.width/self.dataLists.count, collectionView.bounds.size.height);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.delegate && [self.delegate respondsToSelector:@selector(shareSelected:)]) {
        [self.delegate shareSelected:indexPath.row];
    }
    [self dismiss];
}
#pragma mark -- load--
- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.cornerRadius = 5;
        _bgView.layer.masksToBounds = YES;
        _bgView.userInteractionEnabled = YES;
    }
    return _bgView;
}
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.scrollEnabled = NO;
        [_collectionView registerNib:[UINib nibWithNibName:cellID bundle:nil] forCellWithReuseIdentifier:cellID];
    }
    return _collectionView;
}
- (NSArray *)dataLists{
    if (!_dataLists) {
        _dataLists = @[@{@"image":@"weixin",@"title":@"微信"},@{@"image":@"pyq",@"title":@"朋友圈"},@{@"image":@"qq",@"title":@"QQ"},@{@"image":@"weibo",@"title":@"微博"}];
    }
    return _dataLists;
}
- (void)dealloc{
    debugLog(@"%@ 释放了",[self class]);
}
@end
