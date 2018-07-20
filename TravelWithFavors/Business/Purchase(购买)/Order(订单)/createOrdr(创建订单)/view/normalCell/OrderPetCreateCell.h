//
//  OrderPetCreateCell.h
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/7.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyPetInfo.h"

@interface OrderPetCreateCell : UITableViewCell
@property (nonatomic, strong) NSArray *dataLists;
@property (nonatomic, strong) NSArray *seletedLists;
@property (nonatomic, copy) void (^addPetBlock)(void);
@property (nonatomic, copy) void (^selectedBlock) (MyPetInfo *seletedModel);
@property (weak, nonatomic) IBOutlet UILabel *petTitleLB;
@end
