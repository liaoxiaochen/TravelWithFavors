//
//  LananBlockClass-Header.h
//  XiaoShiSports
//
//  Created by Lanan on 2018/4/17.
//  Copyright © 2018年 Lanan. All rights reserved.
//

#ifndef LananBlockClass_Header_h
#define LananBlockClass_Header_h

typedef void(^blockHadParameterAndNoReturn) (id parameter);
typedef void(^blockNoParameterAndNoReturn) (void);
typedef id(^blockHadParameterAndHadReturn) (id parameter);
typedef id(^blockNoParameterAndHadReturn) (void);

#endif /* LananBlockClass_Header_h */
