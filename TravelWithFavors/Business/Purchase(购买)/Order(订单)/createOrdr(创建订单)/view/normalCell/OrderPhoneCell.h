//
//  OrderPhoneCell.h
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/6.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderPhoneCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;

@property (nonatomic, copy) void(^inputBlock)(UITextField *tf) ;

@end
