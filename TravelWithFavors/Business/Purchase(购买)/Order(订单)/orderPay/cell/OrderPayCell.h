//
//  OrderPayCell.h
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/7.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderPayCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *detailBtn;
@property (weak, nonatomic) IBOutlet UILabel *priceLB;
@property (weak, nonatomic) IBOutlet UILabel *priceTitleLB;

@property (nonatomic, assign) BOOL isOpen;
@property (nonatomic, copy) void (^detailBlock)(void);
@end
