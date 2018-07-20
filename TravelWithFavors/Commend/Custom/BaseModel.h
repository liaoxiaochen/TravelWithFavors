//
//  BaseModel.h
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/12.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject
@property (nonatomic, assign) NSInteger code;
@property (nonatomic, copy) NSString *msg;
@property (nonatomic, strong) id data;
@property (nonatomic, strong) NSString *price;
@end
