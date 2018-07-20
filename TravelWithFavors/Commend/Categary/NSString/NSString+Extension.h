//
//  NSString+Extension.h
//  HugeDiscountApp
//
//  Created by 江雅芹 on 2018/1/10.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)
//判断手机号
+ (BOOL)valiMobile:(NSString *)mobile;
//判断手机号
+ (BOOL)checkoutPhoneNum:(NSString *)phoneNum;
#pragma mark --MD5加密
// 32位小写
+(NSString *)MD5ForLower32Bate:(NSString *)str;
// 32位大写
+(NSString *)MD5ForUpper32Bate:(NSString *)str;
// 16为大写
+(NSString *)MD5ForUpper16Bate:(NSString *)str;
// 16位小写
+(NSString *)MD5ForLower16Bate:(NSString *)str;
#pragma mark --判断空字符串
+ (NSString *)nullString:(NSString *)string dispathString:(NSString *)dispathString;
+ (NSString *)toastStringWithCode:(NSInteger)code;
#pragma mark --关于金额限制App
- (BOOL)isChinese;
//金额数字判断
+ (BOOL)isRightInPutOfString:(NSString *) string withInputString:(NSString *) inputString range:(NSRange)range;
- (BOOL)isNull;
//身份证号
+ (BOOL)CheckIsIdentityCard: (NSString *)identityCard;
/** 最多保留2位小数 */
+(NSString *)stringConversionWithNumber:(double)number;
+(NSString *)stringConversionWithNumber:(double)number afterPoint:(int)position;

+ (NSMutableAttributedString *)changeLabelWithMaxString:(NSString *)maxString diffrenIndex:(NSInteger)diffrenIndex maxFont:(NSInteger)maxFont littleFont:(NSInteger)littleFont;

@end
