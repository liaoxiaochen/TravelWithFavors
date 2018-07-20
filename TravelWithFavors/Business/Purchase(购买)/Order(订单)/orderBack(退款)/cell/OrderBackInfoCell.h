//
//  OrderBackInfoCell.h
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/7.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderBackInfoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *orderNoLB;
@property (weak, nonatomic) IBOutlet UILabel *orderTotalFeeLB;
@property (weak, nonatomic) IBOutlet UILabel *orderPoundageFeeLB;
@property (weak, nonatomic) IBOutlet UILabel *orderRefundFeeLB;

@end
