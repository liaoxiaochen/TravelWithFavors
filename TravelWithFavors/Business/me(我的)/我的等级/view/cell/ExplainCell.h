//
//  ExplainCell.h
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/8.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExplainCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *explainLabel;
@property (nonatomic, copy) NSString *explain;
@end
