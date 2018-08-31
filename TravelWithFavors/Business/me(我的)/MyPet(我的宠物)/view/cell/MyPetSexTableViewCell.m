//
//  MyPetSexTableViewCell.m
//  TravelWithFavors
//
//  Created by MacBook on 2018/7/30.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "MyPetSexTableViewCell.h"
#import "PetSexView.h"

@interface MyPetSexTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *petSexImg;


@end

@implementation MyPetSexTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



- (void)setSexIndex:(NSNumber *)sexIndex {
    
    NSInteger index =  [sexIndex integerValue];
    
    switch (index) {
        case 1:
            self.petSexImg.image = [UIImage imageNamed:@"xc_gong"];
            break;
        case 2:
            self.petSexImg.image = [UIImage imageNamed:@"xc_mu"];

            break;
        case 3:
            self.petSexImg.image = [UIImage imageNamed:@"xc_jueyugong"];

            break;
        case 4:
            self.petSexImg.image = [UIImage imageNamed:@"xc_jueyumu"];
            break;
            
        default:
            break;
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
