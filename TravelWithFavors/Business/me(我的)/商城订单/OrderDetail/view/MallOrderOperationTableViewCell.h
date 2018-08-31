//
//  MallOrderOperationTableViewCell.h
//  TravelWithFavors
//
//  Created by MacBook on 2018/8/25.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MallOrderOperationTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *rightLabel;
@property (nonatomic, strong) UIButton *copyBtn;
@property (nonatomic, strong) UIButton *cancelBtn;

@property (nonatomic, assign) BOOL showCopyBtn;
@property (nonatomic, assign) BOOL showCancelBtn;

@end
