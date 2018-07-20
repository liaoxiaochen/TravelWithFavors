//
//  HRorderChangeModel.h
//  TravelWithFavors
//
//  Created by cushiro on 2018/4/20.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HRorderModel.h"

@interface ChangeStateModel : NSObject
@property (nonatomic, copy) NSString *pid;
@property (nonatomic, copy) NSString *changeno;
@property (nonatomic, copy) NSString *changestate;
@property (nonatomic, copy) NSString *create_at;
@property (nonatomic, copy) NSString *changestatemsg;
@end

@interface HRorderChangeModel : NSObject

@property (nonatomic, copy) NSString *pid;
@property (nonatomic, copy) NSString *alterdate;
@property (nonatomic, copy) NSString *alterflight;
@property (nonatomic, copy) NSString *changeno;
@property (nonatomic, copy) NSString *changestate;
@property (nonatomic, copy) NSString *changestatemsg;

@property (nonatomic, copy) NSString *order_id;
@property (nonatomic, copy) NSString *orderno;
@property (nonatomic, copy) NSString *pay_type;
@property (nonatomic, copy) NSString *position_id;
@property (nonatomic, copy) NSString *poundagefee;
@property (nonatomic, copy) NSString *update_at;

@property (nonatomic, strong) NSArray<ChangeStateModel *> *change_list;//改签进度
@property (nonatomic, strong) HRorderModel *ago;
@property (nonatomic, strong) HRorderModel *cur;

+ (HRorderChangeModel *)getOrderChangeInfo:(id)data;
-(NSString *)getChangeStateFromCode;
@end

