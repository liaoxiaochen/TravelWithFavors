//
//  HROrderPayResultViewController.h
//  TravelWithFavors
//
//  Created by cushiro on 2018/4/11.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "RootViewController.h"

@interface HROrderPayResultViewController : RootViewController
@property (weak, nonatomic) IBOutlet UILabel *tipsLB;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/** 支付结果 */
@property (nonatomic, assign) BOOL result;
/** 哪个页面跳转 1.下单 2.订单详情 */
@property (nonatomic, strong) NSString *jumpType;


@end
