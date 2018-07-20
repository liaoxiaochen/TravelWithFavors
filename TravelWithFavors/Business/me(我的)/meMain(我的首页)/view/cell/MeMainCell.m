//
//  MeMainCell.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/2.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "MeMainCell.h"
@interface MeMainCell ()
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@end
@implementation MeMainCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setDict:(NSDictionary *)dict{
    _dict = dict;
    self.leftImageView.image = [UIImage imageNamed:dict[@"image"]];
    self.titleLabel.text = dict[@"title"];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
