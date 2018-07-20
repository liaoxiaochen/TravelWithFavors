//
//  CYPopTableViewCell.h
//  YI
//
//  Created by Lanan on 2018/7/9.
//  Copyright © 2018年 Lanan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CYPopTableViewModel;

@interface CYPopTableViewCell : UITableViewCell

@property(nonatomic, strong) CYPopTableViewModel *model;

@end
