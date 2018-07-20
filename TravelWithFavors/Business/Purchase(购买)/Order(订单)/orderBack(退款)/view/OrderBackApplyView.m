//
//  OrderBackApplyView.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/7.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "OrderBackApplyView.h"

@implementation OrderBackApplyView

- (void)awakeFromNib{
    [super awakeFromNib];
    [self.detailLabel lineSpace:6];
}
- (IBAction)applyClick:(id)sender {
    if (self.commitBlock) {
        self.commitBlock();
    }
}

@end
