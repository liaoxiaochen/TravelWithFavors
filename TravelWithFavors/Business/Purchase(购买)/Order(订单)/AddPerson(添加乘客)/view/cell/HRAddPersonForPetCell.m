//
//  HRAddPersonForPetCell.m
//  TravelWithFavors
//
//  Created by cushiro on 2018/4/24.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "HRAddPersonForPetCell.h"
#import "HRSelectView.h"

@interface HRAddPersonForPetCell()
@property (weak, nonatomic) IBOutlet UIButton *addBtn;

@end

@implementation HRAddPersonForPetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.addBtn.layer.cornerRadius = 3;
    self.addBtn.layer.borderColor = [UIColor colorWithHexString:@"#FF980D"].CGColor;
    self.addBtn.layer.borderWidth = 1;
}
- (IBAction)selectBtnClick:(UIButton *)sender {
    if (self.selectBtnBlock) {
        self.selectBtnBlock();
    }
}
- (IBAction)addBtnClick:(UIButton *)sender {
    if (self.addBtnBlock) {
        self.addBtnBlock();
    }
}
@end
