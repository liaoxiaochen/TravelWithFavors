//
//  InsuranceModel.h
//  TravelWithFavors
//
//  Created by cushiro on 2018/4/10.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InsuranceModel : NSObject

@property (nonatomic, copy) NSString *pid;
@property (nonatomic, copy) NSString *i_name;
@property (nonatomic, copy) NSString *i_remark;
@property (nonatomic, copy) NSString *i_price;
@property (nonatomic, copy) NSString *i_account;
@property (nonatomic, assign) BOOL isSelected;
@end
