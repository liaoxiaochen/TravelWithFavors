//
//  MallSearchResultCollectionViewCell.m
//  TravelWithFavors
//
//  Created by MacBook on 2018/8/8.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "MallSearchResultCollectionViewCell.h"

@interface MallSearchResultCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *goodsImg;
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsPriceLabel;


@end

@implementation MallSearchResultCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.goodsDiscountLabel.attributedText = [NSString baselineWithString:@"$2334"];

}



@end
