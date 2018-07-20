//
//  CYPopTableViewCell.m
//  YI
//
//  Created by Lanan on 2018/7/9.
//  Copyright © 2018年 Lanan. All rights reserved.
//

#import "CYPopTableViewCell.h"

#import "CYPopTableView.h"

@interface CYPopTableViewCell()

@property (nonatomic, strong) UILabel *tipLabel;

@end

@implementation CYPopTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.tipLabel = [[UILabel alloc] initWithFrame:self.contentView.frame];
        self.tipLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:self.tipLabel];
    }
    return self;
}

- (void)setModel:(CYPopTableViewModel *)model {
    if (_model != model) {
        _model = model;
    }
    
//    self.textLabel.textAlignment = NSTextAlignmentCenter;
    self.tipLabel.attributedText = model.attrButedString;
    
    self.backgroundColor = model.isSelected ? [UIColor grayColor] : [UIColor whiteColor];
}


@end
