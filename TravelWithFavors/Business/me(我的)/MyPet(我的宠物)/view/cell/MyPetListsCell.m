//
//  MyPetListsCell.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/8.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "MyPetListsCell.h"
#import "MyPetInfo.h"
@interface MyPetListsCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

@property (weak, nonatomic) IBOutlet UIImageView *petAvatarImg;

@end
@implementation MyPetListsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    self.layer.cornerRadius = 5;
//    self.layer.masksToBounds = YES;
}
//- (void)setFrame:(CGRect)frame{
//    frame.origin.x += 10;
//    frame.size.width -= 20;
//    [super setFrame:frame];
//}
- (void)setInfo:(MyPetInfo *)info{
    _info = info;
    if (info) {
        self.nameLabel.text = info.pet_name;
        self.typeLabel.text = [info.pet_type isEqualToString:@"1"] ? @"猫" : @"狗";
        [self.petAvatarImg sd_setImageWithURL:[NSURL URLWithString:info.avatar]];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
