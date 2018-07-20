//
//  MyPetChoseCell.h
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/13.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyPetChoseCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *dogBtn;
@property (weak, nonatomic) IBOutlet UIButton *catBtn;
@property (nonatomic, copy) void (^choseBlock) (NSString *type);
@property (nonatomic, copy) NSString *petType;
@end
