//
//  HRAddPersonForPetCell.h
//  TravelWithFavors
//
//  Created by cushiro on 2018/4/24.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HRAddPersonForPetCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *petNameLB;
@property (nonatomic, copy) void (^selectBtnBlock)(void);
@property (nonatomic, copy) void (^addBtnBlock)(void);
@end
