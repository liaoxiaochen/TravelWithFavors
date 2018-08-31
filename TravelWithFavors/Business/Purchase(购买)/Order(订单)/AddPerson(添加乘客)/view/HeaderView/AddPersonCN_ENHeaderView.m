//
//  AddPersonCN_ENHeaderView.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/7.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "AddPersonCN_ENHeaderView.h"
#import "CertificatesInfo.h"
#import "OrderChangePopupView.h"

static NSInteger const kHZMaxLength = 4;
static NSInteger const kEGMaxLength = 20;

@interface AddPersonCN_ENHeaderView()

@property (weak, nonatomic) IBOutlet UILabel *maleENLabel;
@property (weak, nonatomic) IBOutlet UILabel *femaleENLabel;
@property (weak, nonatomic) IBOutlet UILabel *adultENLabel;
@property (weak, nonatomic) IBOutlet UILabel *childENLabel;
@property (weak, nonatomic) IBOutlet UILabel *infantENLabel;

@property (weak, nonatomic) IBOutlet UILabel *SurenameENLabel;
@property (weak, nonatomic) IBOutlet UILabel *giveNameENLabel;
@property (weak, nonatomic) IBOutlet UILabel *IDNumberENLabel;
@property (weak, nonatomic) IBOutlet UILabel *birthDayENLabel;
@property (weak, nonatomic) IBOutlet UILabel *sexENLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeENLabel;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *surnameHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *givenameHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *idnumberHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *birthdayHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sexHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *typeHeight;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *maleTopHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *adultTopHeight;



@end

@implementation AddPersonCN_ENHeaderView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.codeTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.codeTextField.tag = 123;
//    self.codeTextField.delegate = self;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFiledEditChanged:) name:UITextFieldTextDidChangeNotification object:nil];
    
    
    [self setStyle:_manSexBtn select:YES];
    [self setStyle:_womanSexBtn select:NO];
    [self setStyle:_manTypeBtn select:YES];
    [self setStyle:_childTypeBtn select:NO];
    [self setStyle:_babyTypeBtn select:NO];
    
    self.birthDayLabel.userInteractionEnabled = YES;
    [self.birthDayLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(birthDayAction)]];
    
}

- (IBAction)nameRuleAction:(id)sender {
    OrderChangePopupView *view = [[OrderChangePopupView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT)];
    view.dataLists = @[@"1.乘客姓名必须与登机时所用证件上的名字一致。少数民族的乘机人可不输入点，持护照登机的外宾，须按护照上的顺序填写",@"2.姓名中包含生僻字或者繁体字，请从生僻字开始之后的中文都用拼音代替",@"3.姓名过长时请使用缩写"];
    view.headerText = @"姓名填写规则";
    [view showPopupView];
}

- (IBAction)babyBuyRuleAction:(id)sender {
    OrderChangePopupView *view = [[OrderChangePopupView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT)];
    view.dataLists = @[@"婴儿票(14天-2岁，按乘机当天的实际年龄计算)",@"1.使用婴儿票的乘客：登机当天应满14天但未满2周岁，未满14天的婴儿不能乘机。",@"2.婴儿票价为成人全票价的10%，不单独占座，机建和燃油税免收。", @"3.婴儿可凭户口本登机，订票时应准确填写户口本上登记的身份证号。如无身份证号可选择证件类型为户口本、出生证明，证件号码栏可填写出生年月日数字，格式为yyyymmdd，如20130324",@" ",@"儿童票(2岁-12岁，按乘机当天的实际年龄计算)",@" 1.票价通常为成人全票价的50%，单独占座，机场建设费免收，燃油税为成人价格的一半", @"2.购买儿童票时可选择证件类型为身份证或户口薄(填写户口本上登记的身份证号)；乘机时可用户口本登机。",@"3.儿童如无身份证号请选择证件类型为户口簿，证件号码栏可填写出生年月日数字，格式为yyyymmdd ，如20130324。",@"4.如乘机人类型选择为“成人”，票价、机场建设费和燃油税与成人同价", @" "];
    view.headerText = @"儿童/婴儿票购买说明";
    [view showPopupView];
}




- (void)setTypeStr:(NSString *)typeStr {
    _typeStr = typeStr;
    
    if (![_typeStr isEqualToString:@"护照"]) {
        self.maleENLabel.hidden = YES;
        self.femaleENLabel.hidden = YES;
        self.adultENLabel.hidden = YES;
        self.infantENLabel.hidden = YES;
        self.childENLabel.hidden = YES;
        self.SurenameENLabel.hidden = YES;
        self.giveNameENLabel.hidden = YES;
        self.IDNumberENLabel.hidden = YES;
        self.birthDayENLabel.hidden = YES;
        self.sexENLabel.hidden = YES;
        self.typeENLabel.hidden = YES;
        
        self.surnameHeight.constant = 0;
        self.givenameHeight.constant = 0;
        self.idnumberHeight.constant = 0;
        self.birthdayHeight.constant = 0;
        self.sexHeight.constant = 0;
        self.typeHeight.constant = 0;

        self.maleTopHeight.constant = 15;
        self.adultTopHeight.constant = 15;
    }else {
        self.maleENLabel.hidden = NO;
        self.femaleENLabel.hidden = NO;
        self.adultENLabel.hidden = NO;
        self.infantENLabel.hidden = NO;
        self.childENLabel.hidden = NO;
        self.SurenameENLabel.hidden = NO;
        self.giveNameENLabel.hidden = NO;
        self.IDNumberENLabel.hidden = NO;
        self.birthDayENLabel.hidden = NO;
        self.sexENLabel.hidden = NO;
        self.typeENLabel.hidden = NO;
        
        self.surnameHeight.constant = 15;
        self.givenameHeight.constant = 15;
        self.idnumberHeight.constant = 15;
        self.birthdayHeight.constant = 15;
        self.sexHeight.constant = 15;
        self.typeHeight.constant = 15;

        self.maleTopHeight.constant = 9;
        self.adultTopHeight.constant = 9;

    }
    
}

- (IBAction)manSexBtnAction:(id)sender {
    [self setStyle:_manSexBtn select:YES];
    [self setStyle:_womanSexBtn select:NO];
    if (self.sexBlock) {
        self.sexBlock(0);
    }
}

- (IBAction)womanSexBtnAction:(id)sender {
    [self setStyle:_manSexBtn select:NO];
    [self setStyle:_womanSexBtn select:YES];
    if (self.sexBlock) {
        self.sexBlock(1);
    }
}
- (IBAction)manTypeBtnAction:(id)sender {
    [self setStyle:_manTypeBtn select:YES];
    [self setStyle:_childTypeBtn select:NO];
    [self setStyle:_babyTypeBtn select:NO];
    if (self.mantypeBlock) {
        self.mantypeBlock(@"ADT");
    }
}
- (IBAction)childTypeBtnAction:(id)sender {
    [self setStyle:_manTypeBtn select:NO];
    [self setStyle:_childTypeBtn select:YES];
    [self setStyle:_babyTypeBtn select:NO];
    if (self.mantypeBlock) {
        self.mantypeBlock(@"CHD");
    }
}
- (IBAction)babyTypeBtnAction:(id)sender {
    [self setStyle:_manTypeBtn select:NO];
    [self setStyle:_childTypeBtn select:NO];
    [self setStyle:_babyTypeBtn select:YES];
    if (self.mantypeBlock) {
        self.mantypeBlock(@"INF");
    }
}

- (void)setInfo:(CertificatesInfo *)info {
    _info = info;
    self.FirstTextField.text = _info.surname;
    self.lastTextField.text = _info.given_name;
    self.codeTextField.text = _info.card_no;
    self.birthDayLabel.text = _info.birthday;
    self.birthDayLabel.textColor = [UIColor blackColor];
    if (_info.sex) {
        [self setStyle:_manSexBtn select:NO];
        [self setStyle:_womanSexBtn select:YES];
    }else {
        [self setStyle:_manSexBtn select:YES];
        [self setStyle:_womanSexBtn select:NO];
    }
}

- (void)birthDayAction {
    [[IQKeyboardManager sharedManager] resignFirstResponder];

    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectBirthDayAddPersonCN_ENHeaderView)]) {
        [self.delegate didSelectBirthDayAddPersonCN_ENHeaderView];
    }
}

- (void)setStyle:(UIButton *)btn select:(BOOL)select{
    [[IQKeyboardManager sharedManager] resignFirstResponder];

    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
    btn.layer.borderWidth = 1;
    if (select) {
        btn.layer.borderColor = [UIColor hdMainColor].CGColor;
        [btn setTitleColor:[UIColor hdMainColor] forState:(UIControlStateNormal)];
    }else {
        btn.layer.borderColor = [UIColor hdPlaceHolderColor].CGColor;
        [btn setTitleColor:[UIColor hdPlaceHolderColor] forState:(UIControlStateNormal)];
    }
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
