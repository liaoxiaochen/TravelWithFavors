//
//  OrderPersonCell.h
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/6.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "passengerModel.h"

@interface OrderPersonCell : UITableViewCell
@property (nonatomic, strong) NSArray *dataLists;
@property (nonatomic, strong) NSArray *seletedLists;
@property (nonatomic, copy) void (^addBlock)(void);
@property (nonatomic, copy) void (^helpBlock)(void);
@property (nonatomic, copy) void (^selectedBlock) (passengerModel *seletedModel);
@property (weak, nonatomic) IBOutlet UILabel *personTitleLB;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *helpBtnConstHeight;
@property (weak, nonatomic) IBOutlet UIButton *helpBtn;
@end
