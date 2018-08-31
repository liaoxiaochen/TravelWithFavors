//
//  NSString+Extension.m
//  HugeDiscountApp
//
//  Created by 江雅芹 on 2018/1/10.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "NSString+Extension.h"
#import <CommonCrypto/CommonDigest.h>
@implementation NSString (Extension)
//判断手机号
+ (BOOL)valiMobile:(NSString *)mobile{
    if (!mobile) {
        return NO;
    }
    if (mobile.length != 11)
    {
        return NO;
    }
    /**
     * 手机号码:
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[6, 7, 8], 18[0-9], 170[0-9]
     * 移动号段: 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     * 联通号段: 130,131,132,155,156,185,186,145,176,1709
     * 电信号段: 133,153,180,181,189,177,1700
     */
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[0678])\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     */
    NSString *CM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)";
    /**
     * 中国联通：China Unicom
     * 130,131,132,155,156,185,186,145,176,1709
     */
    NSString *CU = @"(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)";
    /**
     * 中国电信：China Telecom
     * 133,153,180,181,189,177,1700
     */
    NSString *CT = @"(^1(33|53|77|8[019])\\d{8}$)|(^1700\\d{7}$)";
    /**
     25     * 大陆地区固话及小灵通
     26     * 区号：010,020,021,022,023,024,025,027,028,029
     27     * 号码：七位或八位
     28     */
    //  NSString * PHS = @"^(0[0-9]{2})\\d{8}$|^(0[0-9]{3}(\\d{7,8}))$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    if (([regextestmobile evaluateWithObject:mobile] == YES)
        || ([regextestcm evaluateWithObject:mobile] == YES)
        || ([regextestct evaluateWithObject:mobile] == YES)
        || ([regextestcu evaluateWithObject:mobile] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
//判断手机号
+ (BOOL)checkoutPhoneNum:(NSString *)phoneNum {
    //    if (phoneNum.length <= 0) {
    //        return NO;
    //    }
    //    NSString *regexStr = @"^1[3,8]\\d{9}|14[5,7,9]\\d{8}|15[^4]\\d{8}|17[^2,4,9]\\d{8}$";
    //    NSError *error;
    //    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:regexStr options:NSRegularExpressionCaseInsensitive error:&error];
    //    if (error) return NO;
    //    NSInteger count = [regular numberOfMatchesInString:phoneNum options:NSMatchingReportCompletion range:NSMakeRange(0, phoneNum.length)];
    //    if (count > 0) {
    //        return YES;
    //    } else {
    //        return NO;
    //    }
    if (phoneNum.length == 11) {
        return YES;
    }else{
        return NO;
    }
}
#pragma mark - 32位 小写
+(NSString *)MD5ForLower32Bate:(NSString *)str{
    
    //要进行UTF8的转码
    const char* input = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02x", result[i]];
    }
    
    return digest;
}

#pragma mark - 32位 大写
+(NSString *)MD5ForUpper32Bate:(NSString *)str{
    
    //要进行UTF8的转码
    const char* input = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02X", result[i]];
    }
    
    return digest;
}

#pragma mark - 16位 大写
+(NSString *)MD5ForUpper16Bate:(NSString *)str{
    
    NSString *md5Str = [self MD5ForUpper32Bate:str];
    
    NSString  *string;
    for (int i=0; i<24; i++) {
        string=[md5Str substringWithRange:NSMakeRange(8, 16)];
    }
    return string;
}


#pragma mark - 16位 小写
+(NSString *)MD5ForLower16Bate:(NSString *)str{
    
    NSString *md5Str = [self MD5ForLower32Bate:str];
    
    NSString  *string;
    for (int i=0; i<24; i++) {
        string=[md5Str substringWithRange:NSMakeRange(8, 16)];
    }
    return string;
}

#pragma mark --判断空字符串
+ (NSString *)nullString:(NSString *)string dispathString:(NSString *)dispathString{
    if (string == nil || string == NULL) {
        return dispathString;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return dispathString;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return dispathString;
    }
    return string;
}
#pragma mark --关于金额限制
- (BOOL)isChinese
{
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}
//金额数字判断
+ (BOOL)isRightInPutOfString:(NSString *) string withInputString:(NSString *) inputString range:(NSRange) range{
    //删除处理
    if ([inputString isEqualToString:@""]) {
        return YES;
    }
    //首位不能为.号
    if (range.location == 0 && [inputString isEqualToString:@"."]) {
        return NO;
    }
    //判断只输出数字和.号
    NSString *passWordRegex = @"[0-9\\.]";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    if (![passWordPredicate evaluateWithObject:inputString]) {
        return NO;
    }
    //逻辑处理
    if ([string containsString:@"."]) {
        if ([inputString isEqualToString:@"."]) {
            return NO;
        }
        NSRange subRange = [string rangeOfString:@"."];
        if (range.location - subRange.location > 2) {
            return NO;
        }
    }else{
        //整数 11位
        NSInteger existedLength = string.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = inputString.length;
        if (existedLength - selectedLength + replaceLength > 11) {
            return NO;
        }
    }
    return YES;
}
+ (NSString *)toastStringWithCode:(NSInteger)code{
    // code： 200 成功， 201 需要登录， 202 内部异常， 203 用户不存在， 204 密码错误， 205 必填参数不能为空， 206 参数有误，比如字段类型等问题， 207 请求地址不正确, 208 手机号码已被注册， 209 短信验证码错误， 300 业务逻辑错误
    NSString *codeString = @"";
    switch (code) {
        case 200:{
            codeString = @"成功";
        }
            break;
        case 201:{
            codeString = @"需要登录";
        }
            break;
        case 202:{
            codeString = @"内部异常";
        }
            break;
        case 203:{
            codeString = @"用户不存在";
        }
            break;
        case 204:{
            codeString = @"密码错误";
        }
            break;
        case 205:{
            codeString = @"必填参数不能为空";
        }
            break;
        case 206:{
            codeString = @"参数有误";
        }
            break;
        case 207:{
            codeString = @"请求地址不正确";
        }
            break;
        case 208:{
            codeString = @"手机号码已被注册";
        }
            break;
        case 209:{
            codeString = @"短信验证码错误";
        }
            break;
        case 300:{
            codeString = @"业务逻辑错误";
        }
            break;
        default:{
            codeString = @"其他错误";
        }
            break;
    }
    return codeString;
}
- (BOOL)isNull{
    if (self == nil || self == NULL) {
        return YES;
    }
    if ([self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}
//身份证号
+ (BOOL)CheckIsIdentityCard: (NSString *)identityCard
{
    //判断是否为空
    if (identityCard==nil||identityCard.length <= 0) {
        return NO;
    }
    //判断是否是18位，末尾是否是x
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    if(![identityCardPredicate evaluateWithObject:identityCard]){
        return NO;
    }
    //判断生日是否合法
    NSRange range = NSMakeRange(6,8);
    NSString *datestr = [identityCard substringWithRange:range];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat : @"yyyyMMdd"];
    if([formatter dateFromString:datestr]==nil){
        return NO;
    }
    //判断校验位
    if(identityCard.length==18)
    {
        NSArray *idCardWi= @[ @"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2" ]; //将前17位加权因子保存在数组里
        NSArray * idCardY=@[ @"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2" ]; //这是除以11后，可能产生的11位余数、验证码，也保存成数组
        int idCardWiSum=0; //用来保存前17位各自乖以加权因子后的总和
        for(int i=0;i<17;i++){
            idCardWiSum+=[[identityCard substringWithRange:NSMakeRange(i,1)] intValue]*[idCardWi[i] intValue];
        }
        
        int idCardMod=idCardWiSum%11;//计算出校验码所在数组的位置
        NSString *idCardLast=[identityCard substringWithRange:NSMakeRange(17,1)];//得到最后一位身份证号码
        
        //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
        if(idCardMod==2){
            if([idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]){
                return YES;
            }else{
                return NO;
            }
        }else{
            //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
            if([idCardLast intValue]==[idCardY[idCardMod] intValue]){
                return YES;
            }else{
                return NO;
            }
        }
    }
    return NO;
}

#pragma mark - 根据身份证号识别
+(NSString *)birthdayStrFromIdentityCard:(NSString *)numberStr {
    
    NSMutableString *result = [NSMutableString stringWithCapacity:0];
    NSString *year = nil;
    NSString *month = nil;
    BOOL isAllNumber = YES;
    NSString *day = nil;
    if([numberStr length]<18)
        return result;
    
    //**从第6位开始 截取8个数
    NSString *fontNumer = [numberStr substringWithRange:NSMakeRange(6, 8)];
    //**检测前12位否全都是数字;
    const char *str = [fontNumer UTF8String];
    const char *p = str;
    while (*p!='\0') {
        if(!(*p>='0'&&*p<='9'))
            isAllNumber = NO;
        p++;
    }
    
    if(!isAllNumber)
        return result;
    year = [NSString stringWithFormat:@"19%@",[numberStr substringWithRange:NSMakeRange(8, 2)]];
    month = [numberStr substringWithRange:NSMakeRange(10, 2)];
    day = [numberStr substringWithRange:NSMakeRange(12,2)];
    [result appendString:year];
    [result appendString:@"-"];
    [result appendString:month];
    [result appendString:@"-"];
    [result appendString:day];
    
    return result;
}

+ (NSInteger)getIdentityCardSex:(NSString *)numberStr {
    NSInteger sex = 0;
    // 0男 1女
    //获取18位 二代身份证  性别
    if (numberStr.length==18){
        int sexInt=[[numberStr substringWithRange:NSMakeRange(16,1)] intValue];
        if(sexInt%2!=0){
            sex = 0;
            
        }else{
            sex = 1;
        }
    }
    //  获取15位 一代身份证  性别
    if (numberStr.length==15){
        int sexInt=[[numberStr substringWithRange:NSMakeRange(14,1)] intValue];
        if(sexInt%2!=0){
            sex = 0;
        }else{
            sex = 1;
        }
    }
    return sex;
}

+ (NSInteger)getIdentityCardAge:(NSString *)numberStr {
    NSDateFormatter *formatterTow = [[NSDateFormatter alloc]init];
    [formatterTow setDateFormat:@"yyyy-MM-dd"];
    NSDate *bsyDate = [formatterTow dateFromString:[NSString birthdayStrFromIdentityCard:numberStr]];
    NSTimeInterval dateDiff = [bsyDate timeIntervalSinceNow];
    int age = trunc(dateDiff/(60*60*24))/365;
    return -age;
}



/** 最多保留2位小数 */
+(NSString *)stringConversionWithNumber:(double)number{
    //    NSString *doubleString = [NSString stringWithFormat:@"%lf",number];//处理精度丢失
    //    NSDecimalNumber *decimalNumber = [NSDecimalNumber decimalNumberWithString:doubleString];
    //    CGFloat numberf = (floor([decimalNumber doubleValue]*100 + 0.5))/100;//四舍五入
    //    if (fmod(numberf, 1) == 0) {
    //        return [NSString stringWithFormat:@"%.0lf",numberf];
    //    } else if (fmod(numberf*10, 1) == 0) {
    //        return [NSString stringWithFormat:@"%.1lf",numberf];
    //    } else {
    //        return [NSString stringWithFormat:@"%.2lf",numberf];
    //    }
    return [self stringConversionWithNumber:number afterPoint:2];
}
+(NSString *)stringConversionWithNumber:(double)number afterPoint:(int)position{
    HRLog(@"%lf",number)
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSString *doubleString = [NSString stringWithFormat:@"%lf",number];//处理精度丢失
    NSDecimalNumber *ouncesDecimal = [[NSDecimalNumber alloc] initWithString:doubleString];
    NSDecimalNumber *roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    return [NSString stringWithFormat:@"%@",roundedOunces];
}

+ (NSMutableAttributedString *)changeLabelWithMaxString:(NSString *)maxString diffrenIndex:(NSInteger)diffrenIndex maxFont:(NSInteger)maxFont littleFont:(NSInteger)littleFont {
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:maxString];
    UIFont *font = [UIFont systemFontOfSize:maxFont];
    [attrString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, diffrenIndex)];
    
    UIFont *font1 = [UIFont systemFontOfSize:littleFont];
    [attrString addAttribute:NSFontAttributeName value:font1 range:NSMakeRange(diffrenIndex, maxString.length - diffrenIndex)];
    
    return attrString;
}
+ (NSMutableAttributedString *)changeLabelColorWithMainStr:(NSString *)mainStr diffrenStr:(NSString *)diffrenStr diffrenColor:(UIColor *)diffrenColor {
    NSMutableAttributedString *attrDescribeStr = [[NSMutableAttributedString alloc] initWithString:mainStr];
    [attrDescribeStr addAttribute:NSForegroundColorAttributeName value:diffrenColor range:[mainStr rangeOfString:diffrenStr]];
    return attrDescribeStr;
}

+ (NSMutableAttributedString *)changeLabelColorAndFontWithMainStr:(NSString *)mainStr diffrenStr:(NSString *)diffrenStr diffrenColor:(UIColor *)diffrenColor  diffrenFont:(NSInteger)diffrenFont {
    
    NSMutableAttributedString *attrMainStr = [[NSMutableAttributedString alloc] initWithString:mainStr];
    [attrMainStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:diffrenFont] range:[mainStr rangeOfString:diffrenStr]];
    [attrMainStr addAttribute:NSForegroundColorAttributeName value:diffrenColor range:[mainStr rangeOfString:diffrenStr]];
    
    
    return attrMainStr;
    
}


+ (NSMutableAttributedString *)baselineWithString:(NSString *)baselineString {
    
    NSMutableAttributedString*str = [[NSMutableAttributedString alloc] initWithString:baselineString];
    [str addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid) range:NSMakeRange(0, str.length)];

    return str;
}

@end
