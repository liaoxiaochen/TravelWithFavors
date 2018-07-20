//
//  FlightSearchHeaderView.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/6.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "FlightSearchHeaderView.h"
#import "FlightSearchHeaderCell.h"
#import "FlightSearchLayout.h"
#import "RMCalendarModel.h"
#import "NSDate+RMCalendarLogic.h"

static NSString *const cellID = @"FlightSearchHeaderCell";
@interface FlightSearchHeaderView ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, strong) NSMutableArray *dataLists;
@end
@implementation FlightSearchHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.selectedIndex = 0;
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(frame.size.width - 81, (frame.size.height - 30)/2, 1, 30)];
        view.backgroundColor = [UIColor whiteColor];
        [self addSubview:view];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(frame.size.width - 80, (frame.size.height - 50)/2, 70, 50);
        button.adjustsImageWhenHighlighted = NO;
        [button setTitle:@"日历" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        [button setImage:[UIImage imageNamed:@"xq_rl"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(butonClick) forControlEvents:UIControlEventTouchUpInside];
        [self initButton:button];
        [self addSubview:button];
        
        self.collectionView.frame = CGRectMake(10, (frame.size.height - 50)/2, CGRectGetMinX(view.frame) - 20, 50);
        [self addSubview:self.collectionView];
    }
    return self;
}
-(void)initButton:(UIButton*)button{
//    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
//    [btn setTitleEdgeInsets:UIEdgeInsetsMake(btn.imageView.frame.size.height ,-btn.imageView.frame.size.width, 0.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
//    [btn setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0,0.0, -btn.titleLabel.bounds.size.width)];//图片距离右边框距离减少图片的宽度，其它不边
    CGFloat offset = 6.0f;
    button.titleEdgeInsets = UIEdgeInsetsMake(0, -button.imageView.frame.size.width, -button.imageView.frame.size.height-offset/2, 0);
    // button.imageEdgeInsets = UIEdgeInsetsMake(-button.titleLabel.frame.size.height-offset/2, 0, 0, -button.titleLabel.frame.size.width);
    // 由于iOS8中titleLabel的size为0，用上面这样设置有问题，修改一下即可
    button.imageEdgeInsets = UIEdgeInsetsMake(-button.titleLabel.intrinsicContentSize.height-offset/2, 0, 0, -button.titleLabel.intrinsicContentSize.width);
}
- (void)butonClick{
    if (self.calendarBlock) {
        self.calendarBlock();
    }
}
- (void)setDateTime:(RMCalendarModel *)dateTime{
    _dateTime = dateTime;
    [self.dataLists removeAllObjects];
    [self.dataLists addObject:_dateTime];
    for (int i = 1; i <= 6; i++) {
        NSDate *date = [[_dateTime date] dayInTheFollowingDay:i];
        NSDateComponents *component = [date YMDComponents];
        RMCalendarModel *model = [RMCalendarModel calendarWithYear:component.year month:component.month day:component.day];
        [self.dataLists addObject:model];
    }
    if ([dateTime.getWeek isEqualToString:@"周一"]) {
        
    }
    else if ([dateTime.getWeek isEqualToString:@"周二"]){
        
    }
    else if ([dateTime.getWeek isEqualToString:@"周三"]){
        
    }
    else if ([dateTime.getWeek isEqualToString:@"周四"]){
        
    }
    else if ([dateTime.getWeek isEqualToString:@"周五"]){
        
    }
    else if ([dateTime.getWeek isEqualToString:@"周六"]){
        
    }
    else{
        
    }
    debugLog(@"%@",dateTime.getWeek);
    self.selectedIndex = 0;
    [self.collectionView reloadData];
}
#pragma mark --UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataLists.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FlightSearchHeaderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    if (indexPath.row == self.selectedIndex) {
        cell.backgroundColor = [UIColor whiteColor];
        cell.dayLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        cell.timeLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        cell.priceLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    }else{
        cell.backgroundColor = [UIColor clearColor];
        cell.dayLabel.textColor = [UIColor whiteColor];
        cell.timeLabel.textColor = [UIColor whiteColor];
        cell.priceLabel.textColor = [UIColor whiteColor];
    }
    RMCalendarModel *model = self.dataLists[indexPath.row];
    cell.dayLabel.text = model.getWeek;
    cell.timeLabel.text = [NSString stringWithFormat:@"%.1lu/%.1lu",model.month,model.day];
    cell.priceLabel.text = @"￥--";
    return cell;
}
#pragma mark --UICollectionViewDelegateFlowLayout
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.selectedIndex != indexPath.row) {
        self.selectedIndex = indexPath.row;
        [self.collectionView reloadData];
        if (self.selectedBlock) {
            self.selectedBlock(indexPath.row,self.dataLists[indexPath.row]);
        }
    }
}
#pragma mark --load
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(72, 50);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerNib:[UINib nibWithNibName:cellID bundle:nil] forCellWithReuseIdentifier:cellID];
        _collectionView.showsHorizontalScrollIndicator = NO;
    }
    return _collectionView;
}
- (NSMutableArray *)dataLists{
    if (!_dataLists) {
        _dataLists = [[NSMutableArray alloc] init];
    }
    return _dataLists;
}
@end
