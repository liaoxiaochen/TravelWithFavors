//
//  AddPersonCN_ENHeaderView.h
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/7.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CertificatesInfo;
@protocol AddPersonCN_ENHeaderViewDelegate <NSObject>

- (void)didSelectBirthDayAddPersonCN_ENHeaderView;

@end

@interface AddPersonCN_ENHeaderView : UIView

@property (nonatomic, copy) NSString *typeStr;

@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UITextField *FirstTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;

@property (weak, nonatomic) IBOutlet UILabel *birthDayLabel;
@property (weak, nonatomic) IBOutlet UIButton *manSexBtn;
@property (weak, nonatomic) IBOutlet UIButton *womanSexBtn;
@property (weak, nonatomic) IBOutlet UIButton *manTypeBtn;
@property (weak, nonatomic) IBOutlet UIButton *childTypeBtn;
@property (weak, nonatomic) IBOutlet UIButton *babyTypeBtn;

@property (nonatomic, strong) CertificatesInfo *info;

@property (weak, nonatomic) IBOutlet UIButton *nameRule;
@property (weak, nonatomic) IBOutlet UIButton *babyBuyRule;


@property (nonatomic, assign) id<AddPersonCN_ENHeaderViewDelegate> delegate;
@property (nonatomic, copy) void (^typeBlock)(void);
@property (nonatomic, copy) void (^sexBlock)(NSInteger);
@property (nonatomic, copy) void (^mantypeBlock)(NSString *);
@property (nonatomic, copy) void (^birthDayBlock)(NSString *);


@end
