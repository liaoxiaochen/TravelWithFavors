//
//  MallScrollRecommendCollectionViewCell.h
//  TravelWithFavors
//
//  Created by MacBook on 2018/8/10.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MallScrollRecommendDelegate <NSObject>

- (void)mallScrollRecommendClick:(NSInteger)index;

@end

@interface MallScrollRecommendCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) NSMutableArray *itemRecommendScrollArr;

@property (nonatomic, assign) id <MallScrollRecommendDelegate> delegate;

@end
