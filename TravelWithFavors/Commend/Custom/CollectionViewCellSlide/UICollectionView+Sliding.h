//
//  UICollectionView+Sliding.h
//  DemoCollection
//
//  Created by gb on 2018/4/17.
//  Copyright © 2018年  GB. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GBCollectionViewCell;
@interface UICollectionView (Sliding)
- (void)editingStateChangedForCell:(GBCollectionViewCell *)cell;
- (void)endConfirmationState;

@end
