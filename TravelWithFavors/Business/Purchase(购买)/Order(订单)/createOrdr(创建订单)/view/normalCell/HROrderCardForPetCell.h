//
//  HROrderCardForPetCell.h
//  TravelWithFavors
//
//  Created by cushiro on 2018/4/24.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "passengerModel.h"

@protocol OrderCardForPetCellDelegate <NSObject>
-(void)orderCardForPetRemoveCellWithCell:(UITableViewCell *)cell;
@end


@interface HROrderCardForPetCell : UITableViewCell

@property (nonatomic,weak) id<OrderCardForPetCellDelegate> orderCardForPetCellDelegate;
@property (nonatomic, strong) passengerModel *passengerModel;

@end
