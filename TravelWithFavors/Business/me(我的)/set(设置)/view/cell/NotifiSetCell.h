//
//  NotifiSetCell.h
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/3.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <UIKit/UIKit.h>
//@class NotifiSetCell;
//@protocol NotifiSetCellDelegate <NSObject>
//@optional
//- (void)swithType:(NotifiSetCell *)cell;
//@end
typedef void (^testBlock)(BOOL switchIsOpen);
@interface NotifiSetCell : UITableViewCell
//@property (nonatomic, assign) id <NotifiSetCellDelegate> delegate;
//@property (nonatomic, strong) NSIndexPath *path;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UISwitch *typeSwitch;
@property (nonatomic, copy) testBlock teudb;
@end
