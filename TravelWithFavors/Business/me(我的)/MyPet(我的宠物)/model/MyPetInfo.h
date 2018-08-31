//
//  MyPetInfo.h
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/13.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyPetInfo : NSObject
//"id": 1,//宠物ID
//"pet_name": "天赋的宠物",//宠物名字
//"avatar": "''",//头像地址
//"birthday": 1520319904,//生日，时间戳
//"weight": 23,//体重
//"box_length": 113,//航空箱长度
//"box_height": 50,//航空箱高度
//"box_width": 120,//航空箱宽度
//"is_short": 2,//是否为短鼻猫狗 1-是 2-不是
//"pet_type": 1,//宠物类型 1-猫 2-狗
//"create_at": 1520319971,
//"update_at": 1520319971
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *pet_name;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *birthday;
@property (nonatomic, copy) NSString *weight;
@property (nonatomic, copy) NSString *box_length;
@property (nonatomic, copy) NSString *box_height;
@property (nonatomic, copy) NSString *box_width;
@property (nonatomic, copy) NSString *is_short;
@property (nonatomic, copy) NSString *pet_type;
@property (nonatomic, copy) NSString *pet_no;
@property (nonatomic, copy) NSString *create_at;
@property (nonatomic, copy) NSString *update_at;
@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, strong) NSNumber *sex;
@property (nonatomic, assign) BOOL isSelected;

+ (NSArray *)getMyPetInfoLists:(id)data;
@end
