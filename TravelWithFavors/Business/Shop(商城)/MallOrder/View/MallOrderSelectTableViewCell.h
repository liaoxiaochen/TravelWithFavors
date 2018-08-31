//
//  MallOrderSelectTableViewCell.h
//  TravelWithFavors
//
//  Created by MacBook on 2018/8/23.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MallOrderSelectTableViewCell;

typedef void (^MallOrderSelectBlock)(PayWay way);

@interface MallOrderSelectTableViewCell : UITableViewCell

@property (nonatomic, strong) NSArray *tipArr;
@property (nonatomic, assign) BOOL itemSelect;
@property (nonatomic, copy) MallOrderSelectBlock orderSelectBlock;

@end
