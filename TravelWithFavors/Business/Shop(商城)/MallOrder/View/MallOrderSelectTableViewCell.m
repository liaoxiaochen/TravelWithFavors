//
//  MallOrderSelectTableViewCell.m
//  TravelWithFavors
//
//  Created by MacBook on 2018/8/23.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "MallOrderSelectTableViewCell.h"

@interface MallOrderSelectTableViewCell()

@property (nonatomic, strong) UIImageView *itemIcon;
@property (nonatomic, strong) UILabel *itemName;
@property (nonatomic, strong) UIButton *itemSelectBtn;

@end

@implementation MallOrderSelectTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        [self.contentView addSubview:self.itemIcon];
        [self.contentView addSubview:self.itemName];
        [self.contentView addSubview:self.itemSelectBtn];

        
    }
    return self;
}

- (void)selectBtnAction:(UIButton *)sender {
    NSInteger index = 1;
    if ([_tipArr[0] isEqualToString:@"支付宝"] || [_tipArr[0] isEqualToString:@"顺丰"] ) {
        index = 0;
    }
    if (self.orderSelectBlock) {
        self.orderSelectBlock(index);
    }
}

- (void)setTipArr:(NSArray *)tipArr {
    _tipArr = tipArr;
    _itemName.text = _tipArr[0];
    _itemIcon.image = [UIImage imageNamed:_tipArr[1]];
    if (_itemSelect) {
        [_itemSelectBtn setImage:[UIImage imageNamed:@"sc_js_xz"] forState:UIControlStateNormal];
    }else {
        [_itemSelectBtn setImage:[UIImage imageNamed:@"sc_js_wxz"] forState:UIControlStateNormal];

    }
}

- (UIImageView *)itemIcon {
    if (!_itemIcon) {
        _itemIcon = [[UIImageView alloc] initWithFrame:CGRectMake(10, (SELF_HEIGHT - 20) /2, 20,  20)];
        _itemIcon.image = [UIImage imageNamed:@"ddzf_sf"];
    }
    return _itemIcon;
}

- (UILabel *)itemName {
    if (!_itemName) {
        _itemName = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 200, CONTENT_HEIGHT)];
        _itemName.text = @"顺丰";
        _itemName.font = [UIFont systemFontOfSize:12];
        _itemName.textColor = [UIColor hdTextColor];
    }
    return _itemName;
}

- (UIButton *)itemSelectBtn {
    if (!_itemSelectBtn) {
        _itemSelectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _itemSelectBtn.frame = CGRectMake(SCREEN_WIDTH - SELF_HEIGHT , 0, SELF_HEIGHT - 10, SELF_HEIGHT);
        [_itemSelectBtn setImage:[UIImage imageNamed:@"sc_js_wxz"] forState:UIControlStateNormal];
        _itemSelectBtn.tag = 1;
        [_itemSelectBtn addTarget:self action:@selector(selectBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _itemSelectBtn;
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
