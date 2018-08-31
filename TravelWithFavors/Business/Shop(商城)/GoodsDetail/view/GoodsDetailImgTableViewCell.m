//
//  GoodsDetailImgTableViewCell.m
//  TravelWithFavors
//
//  Created by MacBook on 2018/8/17.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "GoodsDetailImgTableViewCell.h"

@interface GoodsDetailImgTableViewCell()

@property (nonatomic, strong) UIImageView *detailImg;

@end

@implementation GoodsDetailImgTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.detailImg];
    }
    return self;
}

- (void)setImgUrl:(NSString *)imgUrl {
    _imgUrl = imgUrl;
    [_detailImg sd_setImageWithURL:[NSURL URLWithString:_imgUrl]];
    _detailImg.frame = CGRectMake(0, 0, SCREEN_WIDTH, 250);
}

- (UIImageView *)detailImg {
    if (!_detailImg) {
        _detailImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CONTENT_HEIGHT)];
        
    }
    return _detailImg;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
