//
//  ExplainCell.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/8.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "ExplainCell.h"

@implementation ExplainCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    [self.explainLabel lineSpace:6];
}
- (void)setExplain:(NSString *)explain{
    _explain = explain;
    self.explainLabel.text = explain;
    [self.explainLabel lineSpace:6];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
