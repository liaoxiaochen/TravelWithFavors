//
//  SwitchTableViewCell.h
//  TravelWithFavors
//
//  Created by MacBook on 2018/8/21.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SwitchCellChangeBlock)(NSString *is_default);

@interface SwitchTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel* tipLabel;

@property (nonatomic, strong) UISwitch *switchBtn;

@property (nonatomic, copy) SwitchCellChangeBlock SwitchBlock;

@end
