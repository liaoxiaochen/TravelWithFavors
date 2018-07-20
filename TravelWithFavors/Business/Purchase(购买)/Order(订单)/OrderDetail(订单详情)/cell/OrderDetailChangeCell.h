//
//  OrderDetailChangeCell.h
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/7.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetailChangeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UIButton *changeBtn;
@property (weak, nonatomic) IBOutlet UIButton *repayBtn;

@property (nonatomic, copy) void (^backBlock) (void);
@property (nonatomic, copy) void (^changeBlock) (void);
@property (nonatomic, copy) void (^repayBlock) (void);

/** 是否完成支付 */
@property (nonatomic, assign) BOOL isCompletePayment;

@end
