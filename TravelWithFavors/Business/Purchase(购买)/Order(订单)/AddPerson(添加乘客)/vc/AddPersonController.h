//
//  AddPersonController.h
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/7.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "HDTableViewController.h"
#import "passengerModel.h"
#import "MyPetInfo.h"
@interface AddPersonController : HDTableViewController

@property (nonatomic, copy) NSString *p_id;
@property (nonatomic, copy) void (^refreshBlock)(void);
@property (nonatomic, copy) void (^cerDataBlock)(passengerModel *info);
@property (nonatomic, assign) BOOL isPet;//是否是携宠用户下单详情
@property (nonatomic, strong) NSMutableArray *petALLArray;//携宠用户所有宠物信息
@property (nonatomic, strong) NSMutableArray *petArray;//携宠用户宠物信息(不包括其他乘机人已选宠物)
@property (nonatomic, strong) MyPetInfo *selectedPet;//携宠用户选择的宠物
@property (nonatomic, copy) void (^petBlock)(passengerModel *info,MyPetInfo * pet);
@property (nonatomic, copy) void (^updatePetBlock)(NSArray * petArray);
@end
