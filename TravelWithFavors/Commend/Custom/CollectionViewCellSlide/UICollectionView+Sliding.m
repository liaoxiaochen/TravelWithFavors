//
//  UICollectionView+Sliding.m
//  DemoCollection
//
//  Created by gb on 2018/4/17.
//  Copyright © 2018年  GB. All rights reserved.
//

#import "UICollectionView+Sliding.h"
#import "GBCollectionViewCell.h"

@implementation UICollectionView (Sliding)


- (void)editingStateChangedForCell:(GBCollectionViewCell *)cell
{
    if ( cell != nil && [self.visibleCells containsObject:cell] ) {
        if ( cell.isEditing ) {
            [self enterConfirmationStateForCell:cell];
        }
    }
}

- (void)enterConfirmationStateForCell:(GBCollectionViewCell *)cell
{
    [self.visibleCells enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ( [obj isKindOfClass:[GBCollectionViewCell class]] && obj != cell ) {
            [(GBCollectionViewCell *)obj setEditing:NO animated:YES];
        }
    }];
    self.panGestureRecognizer.enabled = NO;
}


//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    if (!self.panGestureRecognizer.enabled) {
//        [self endConfirmationState];
//    }
//    else {
//        [super touchesBegan:touches withEvent:event];
//
//    }
//}

- (void)endConfirmationState
{
    [self.visibleCells enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ( [obj isKindOfClass:[GBCollectionViewCell class]] ) {
            [(GBCollectionViewCell *)obj setEditing:NO animated:YES];
        }
    }];
    self.panGestureRecognizer.enabled = YES;
}


@end
