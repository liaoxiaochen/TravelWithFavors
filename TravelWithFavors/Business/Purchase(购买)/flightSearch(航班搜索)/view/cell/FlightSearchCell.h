//
//  FlightSearchCell.h
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/6.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FlightInfo;
@interface FlightSearchCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftPalceLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightPlaceLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *conparyLabel;
@property (weak, nonatomic) IBOutlet UILabel *discountLB;
@property (nonatomic, strong) FlightInfo *info;
@property (nonatomic, strong) NSString *price;//往/返最低价
/** 1-单程 2-往返去 3-往返回 */
@property (nonatomic, assign) NSString *ride_type;
@end
