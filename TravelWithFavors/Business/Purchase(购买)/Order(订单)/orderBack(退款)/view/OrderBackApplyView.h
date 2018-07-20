//
//  OrderBackApplyView.h
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/7.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderBackApplyView : UIView
@property (weak, nonatomic) IBOutlet UILabel *shouXuFeiLabel;
@property (weak, nonatomic) IBOutlet UILabel *backMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *backPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@property (nonatomic, copy) void (^commitBlock) (void);
@end
