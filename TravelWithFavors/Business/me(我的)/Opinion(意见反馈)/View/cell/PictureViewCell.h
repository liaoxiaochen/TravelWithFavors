//
//  PictureViewCell.h
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/3.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PictureViewCellDelegate <NSObject>
- (void)deleteImageAtIndex:(NSInteger)index;
@end
@interface PictureViewCell : UITableViewCell
@property (nonatomic, assign) id <PictureViewCellDelegate> delegate;
@property (nonatomic, strong) NSArray *imageLists;
+ (CGFloat)cellHeight:(NSArray *)dataLists;
@end
