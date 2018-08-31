//
//  GoodsProduceTableViewCell.m
//  TravelWithFavors
//
//  Created by MacBook on 2018/8/17.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "GoodsProduceTableViewCell.h"
#import "AddressInfoModel.h"
@interface GoodsProduceTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *goodName;
@property (weak, nonatomic) IBOutlet UILabel *goodDescribe;
@property (weak, nonatomic) IBOutlet UILabel *goodPrice;
@property (weak, nonatomic) IBOutlet UILabel *goodOriginPrice;
@property (weak, nonatomic) IBOutlet UILabel *stockLabel;
 
@end

@implementation GoodsProduceTableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    

    self.goodOriginPrice.attributedText = [NSString baselineWithString:@"$2334"];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
