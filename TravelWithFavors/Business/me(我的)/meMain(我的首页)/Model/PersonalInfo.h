//
//  PersonalInfo.h
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/12.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonalInfo : NSObject
//"avatar": "liantianfu",//头像地址
//"sex": 1,//性别 0-保密 1-男 2-女
//"mobile": "17743253694",//手机号
//"user_nickname": "liantianfu"//用户昵称
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *user_nickname;
@property (nonatomic, copy) NSString *grade;//等级
@property (nonatomic, copy) NSString *score;//积分
@end
