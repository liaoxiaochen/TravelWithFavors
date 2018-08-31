//
//  MallBannerCollectionViewCell.h
//  TravelWithFavors
//
//  Created by MacBook on 2018/8/10.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MallBannerDelegate <NSObject>

- (void)mallBannerClick:(NSInteger)index;

@end


@interface MallBannerCollectionViewCell : UICollectionViewCell

@property (nonatomic, assign) id <MallBannerDelegate> delegate;

@end
