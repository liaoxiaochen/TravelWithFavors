//
//  OrderCardCell.h
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/6.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "passengerModel.h"

@protocol OrderCardCellDelegate <NSObject>
-(void)orderCardRemoveCellWithCell:(UITableViewCell *)cell;
@end


@interface OrderCardCell : UITableViewCell

@property (nonatomic,weak) id<OrderCardCellDelegate> orderCardCellDelegate;
@property (nonatomic, strong) passengerModel *passengerModel;
@property (nonatomic, assign) BOOL isPet;//是否携带宠物

@end
