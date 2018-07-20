//
//  passengerModel.h
//  TravelWithFavors
//
//  Created by cushiro on 2018/4/9.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyPetInfo.h"

@interface passengerModel : NSObject

@property (nonatomic, copy) NSString *pid;
@property (nonatomic, copy) NSString *card_type;
@property (nonatomic, copy) NSString *card_no;
@property (nonatomic, copy) NSString *id_card_name;
@property (nonatomic, copy) NSString *surname;
@property (nonatomic, copy) NSString *given_name;
@property (nonatomic, copy) NSString *create_at;
@property (nonatomic, copy) NSString *update_at;
@property (nonatomic, copy) NSString *birthday;
@property (nonatomic, copy) NSString *insurancenum;
@property (nonatomic, copy) NSString *insuranceprice;
@property (nonatomic, copy) NSString *mantype;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *pet_id;

@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, assign) BOOL isHavePet;
@property (nonatomic, strong) MyPetInfo *pet;
@end
