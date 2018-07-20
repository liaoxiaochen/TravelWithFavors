//
//  AddPersonCN_ENHeaderView.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/7.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "AddPersonCN_ENHeaderView.h"
static NSInteger const kHZMaxLength = 4;
static NSInteger const kEGMaxLength = 20;
@implementation AddPersonCN_ENHeaderView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.codeTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.codeTextField.tag = 123;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFiledEditChanged:) name:UITextFieldTextDidChangeNotification object:nil];
}
-(void)textFiledEditChanged:(NSNotification*)obj{
    UITextField *textField = (UITextField *)obj.object;
    if (textField != self.FirstTextField || textField != self.lastTextField || textField.tag == 123 || textField.tag == 124) {
        return;
    }
    NSString *toBeString = textField.text;
    
    BOOL isEmoj = [self stringContainsEmoji:toBeString];
    NSString * _showStr;
    
    toBeString = [self disable_emoji:toBeString];
    
    NSString *lang = [[UIApplication sharedApplication] textInputMode].primaryLanguage; // 键盘输入模式
    if([lang isEqualToString:@"zh-Hans"]) { //简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        //没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if(!position) {
            if(toBeString.length > kHZMaxLength) {
                textField.text = [toBeString substringToIndex:kHZMaxLength];
                _showStr = [toBeString substringToIndex:kHZMaxLength];
            }
        }
        //有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
            
        }
    }
    //中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        if(toBeString.length > kEGMaxLength) {
            
            textField.text= [toBeString substringToIndex:kEGMaxLength];
            
            _showStr = [toBeString substringToIndex:kEGMaxLength];
        }
    }
    
    if (isEmoj) {
        
        if ([_showStr length]) {
            
            textField.text = _showStr;
            
        }else{
            textField.text = toBeString;
        }
    }
}

//判断NSString字符串是否包含emoji表情
- (BOOL)stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue =NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        const unichar hs = [substring characterAtIndex:0];
        // surrogate pair
        if (0xd800) {
            if (0xd800 <= hs && hs <= 0xdbff) {
                if (substring.length > 1) {
                    const unichar ls = [substring characterAtIndex:1];
                    const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                    if (0x1d000 <= uc && uc <= 0x1f77f) {
                        returnValue =YES;
                    }
                }
            }else if (substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                if (ls == 0x20e3) {
                    returnValue =YES;
                }
            }else {
                // non surrogate
                if (0x2100 <= hs && hs <= 0x27ff) {
                    returnValue =YES;
                }else if (0x2B05 <= hs && hs <= 0x2b07) {
                    returnValue =YES;
                }else if (0x2934 <= hs && hs <= 0x2935) {
                    returnValue =YES;
                }else if (0x3297 <= hs && hs <= 0x3299) {
                    returnValue =YES;
                }else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                    returnValue =YES;
                }
            }
        }
    }];
    return returnValue;
}
#pragma Mark   ---  过滤表情

- (NSString *)disable_emoji:(NSString *)text
{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:text
                                                               options:0
                                                                 range:NSMakeRange(0, [text length])
                                                          withTemplate:@""];
    return modifiedString;
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (IBAction)typeBtnClick:(id)sender {
    if (self.typeBlock) {
        [[IQKeyboardManager sharedManager] resignFirstResponder];
        self.typeBlock();
    }
}

@end
