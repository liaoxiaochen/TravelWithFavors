//
//  MallTypeItemCollectionViewCell.m
//  TravelWithFavors
//
//  Created by MacBook on 2018/8/10.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "MallTypeItemCollectionViewCell.h"

@interface MallTypeItemCollectionViewCell()

@property (nonatomic, strong) UIButton *itemBtn;

@end

@implementation MallTypeItemCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.itemArr = [NSMutableArray array];
        [self initUI];
    }
    return self;
}


- (void)setItemArr:(NSArray *)itemArr {
    _itemArr = itemArr;
    if (_itemArr.count < 2) {
        return;
    }
    [_itemBtn setTitle:_itemArr[0] forState:UIControlStateNormal];
    [_itemBtn setImage:[UIImage imageNamed:_itemArr[1]] forState:(UIControlStateNormal)];
}


- (void)initUI {
    self.backgroundColor = [UIColor whiteColor];

    [self.contentView addSubview:self.itemBtn];
    
}
- (UIButton *)itemBtn {
    if (!_itemBtn) {
        _itemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _itemBtn.frame = CGRectMake(0, 0 , CONTENT_WIDTH, CONTENT_HEIGHT);
        [_itemBtn setTitle:@"出行" forState:(UIControlStateNormal)];
        [_itemBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        _itemBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_itemBtn setImage:[UIImage imageNamed:@"sc_cs"] forState:UIControlStateNormal];
        _itemBtn.userInteractionEnabled = NO;
        [UIButton initButton:_itemBtn spacing:10];
    }
    return _itemBtn;
}



@end
