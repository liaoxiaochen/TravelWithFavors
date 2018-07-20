//
//  OrderChangeTypeCell.h
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/7.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderChangeTypeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *changeStatusLB;
@property (weak, nonatomic) IBOutlet UILabel *feeTitleLB;
@property (weak, nonatomic) IBOutlet UILabel *feeLB;
@property (weak, nonatomic) IBOutlet UILabel *orderNoLB;

@property (nonatomic, copy) void (^ruleBlock) (void);

@end
