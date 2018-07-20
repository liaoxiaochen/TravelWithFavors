//
//  UserProtocolCell.h
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/9.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserProtocolCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (nonatomic, copy) NSString *detail;
@end
