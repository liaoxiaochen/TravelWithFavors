//
//  GBCollectionViewCell.h
//  DemoCollection
//
//  Created by gb on 2018/4/17.
//  Copyright © 2018年 GB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UICollectionView+Sliding.h"
@interface GBCollectionViewCell : UICollectionViewCell
@property (nonatomic, copy) void (^deleteCell)(NSIndexPath *indexPath);
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, strong) UIButton *deleteCellBtn;
@property (nonatomic, assign) BOOL isEditing;
- (void)setEditing:(BOOL)editing animated:(BOOL)animated;
@end
