//
//  MallBannerCollectionViewCell.m
//  TravelWithFavors
//
//  Created by MacBook on 2018/8/10.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "MallBannerCollectionViewCell.h"

@interface MallBannerCollectionViewCell()<SDCycleScrollViewDelegate>

@property (nonatomic, strong) SDCycleScrollView *scrollView;

@end

@implementation MallBannerCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, CONTENT_WIDTH, CONTENT_HEIGHT) imageNamesGroup:@[@"http://pic1.win4000.com/wallpaper/2017-12-29/5a46108f19717.jpg", @"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1694074041,1248343633&fm=27&gp=0.jpg"]];
        _scrollView.showPageControl = NO;
        _scrollView.delegate = self;
        [self.contentView addSubview:_scrollView];
    }
    return self;
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    

    [self.delegate mallBannerClick:index];
    
}


@end
