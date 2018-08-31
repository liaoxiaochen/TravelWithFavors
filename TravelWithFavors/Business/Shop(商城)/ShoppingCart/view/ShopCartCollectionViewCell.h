//
//  ShopCartCollectionViewCell.h
//  TravelWithFavors
//
//  Created by MacBook on 2018/8/22.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "GBCollectionViewCell.h"

typedef void(^ShopCartListClickBlock)(BOOL isClick);

@interface ShopCartCollectionViewCell : GBCollectionViewCell

@property (weak, nonatomic) IBOutlet UIButton *clickBtn;
@property (weak, nonatomic) IBOutlet UIImageView *goodImageView;
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *presentLabel;
@property (weak, nonatomic) IBOutlet UIView *numbeBtnView;


@property (nonatomic, copy) ShopCartListClickBlock shopCarListClickBlock;


@end
