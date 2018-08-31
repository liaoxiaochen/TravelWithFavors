//
//  AddPersonCardHeaderView.h
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/7.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CertificatesInfo;

@protocol AddPersonCardHeaderViewDelegate <NSObject>

- (void)didSelectBirthDay;

@end


@interface AddPersonCardHeaderView : UIView
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;

@property (weak, nonatomic) IBOutlet UILabel *birthdayLabel;

@property (weak, nonatomic) IBOutlet UIButton *manSexBtn;
@property (weak, nonatomic) IBOutlet UIButton *womanSexBtn;
@property (weak, nonatomic) IBOutlet UIButton *manTypeBtn;
@property (weak, nonatomic) IBOutlet UIButton *childTypeBtn;
@property (weak, nonatomic) IBOutlet UIButton *babyTypeBtn;


@property (nonatomic, strong) CertificatesInfo *info;

@property (weak, nonatomic) IBOutlet UIButton *nameRule;
@property (weak, nonatomic) IBOutlet UIButton *babyBuyRule;



@property (nonatomic, assign) id<AddPersonCardHeaderViewDelegate> delegate;
@property (nonatomic, copy) void (^typeBlock)(void); // 证件类型
@property (nonatomic, copy) void (^sexBlock)(NSInteger);
@property (nonatomic, copy) void (^mantypeBlock)(NSString *);
@property (nonatomic, copy) void (^birthDayBlock)(NSString *);

@end
