//
//  AddPersonCell.h
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/7.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddPersonCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (nonatomic, copy) void (^typeBlock)(void);
@end
