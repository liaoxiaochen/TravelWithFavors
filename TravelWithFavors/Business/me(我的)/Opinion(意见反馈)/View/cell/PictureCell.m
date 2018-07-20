//
//  PictureCell.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/3.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "PictureCell.h"

@implementation PictureCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.closeBtn.layer.cornerRadius  = self.closeBtn.bounds.size.width/2;
}
- (IBAction)closeClick:(id)sender {
    if (self.close) {
        self.close();
    }
}

@end
