//
//  CertificatesInfo.h
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/13.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CertificatesInfo : NSObject
//"id": 1,//游客ID
//"card_type": 1,//游客类型 1身份证 2 护照 3 港澳 4 台湾
//"card_no": "2232332",//证件号码
//"id_card_name": "tianfu",//身份证名字
//"surname": "",//姓
//"given_name": "",//名
//"create_at": 1520388851,//添加时间
//"update_at": 1520389233
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *card_type;
@property (nonatomic, copy) NSString *card_no;
@property (nonatomic, copy) NSString *id_card_name;
@property (nonatomic, copy) NSString *surname;
@property (nonatomic, copy) NSString *given_name;
@property (nonatomic, copy) NSString *create_at;
@property (nonatomic, copy) NSString *update_at;

@property (nonatomic, assign) NSInteger sex; // 0男 1女
@property (nonatomic, copy) NSString *mantype;
@property (nonatomic, copy) NSString *birthday;


@property (nonatomic, copy) NSString *user_id;

+ (NSArray *)getCertificatesInfoLists:(id)data;

@end
