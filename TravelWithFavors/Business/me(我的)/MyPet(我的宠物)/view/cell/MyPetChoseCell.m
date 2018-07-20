//
//  MyPetChoseCell.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/13.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "MyPetChoseCell.h"
@interface MyPetChoseCell ()
@property (nonatomic, copy) NSString *type;
@end
@implementation MyPetChoseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    //默认是狗 1-猫 2-狗
    self.type = @"2";
//    左文右图
    // 还可增设间距
    CGFloat spacing = 5.0;
    // 图片右移
    CGSize imageSize = self.dogBtn.imageView.frame.size;
    self.dogBtn.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width * 2 - spacing, 0.0, 0.0);
    
        // 文字左移
    CGSize titleSize = self.dogBtn.titleLabel.frame.size;
    self.dogBtn.imageEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, - titleSize.width * 2 - spacing);
    
    // 图片右移
    CGSize catImageSize = self.catBtn.imageView.frame.size;
    self.catBtn.titleEdgeInsets = UIEdgeInsetsMake(0.0, - catImageSize.width * 2 - spacing, 0.0, 0.0);
    
    // 文字左移
    CGSize catTitleSize = self.catBtn.titleLabel.frame.size;
    self.catBtn.imageEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, - catTitleSize.width * 2 - spacing);
    
}
- (IBAction)dogBtnClick:(id)sender {
//    [self.dogBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    //dbm-gx 选中  wdcw_jxk 未选中
    if (![self.type isEqualToString:@"2"]) {
        self.type = @"2";
//        [self.dogBtn setImage:[UIImage imageNamed:@"dbm-gx"] forState:UIControlStateNormal];
//        [self.catBtn setImage:[UIImage imageNamed:@"wdcw_jxk"] forState:UIControlStateNormal];
        if (self.choseBlock) {
            self.choseBlock(self.type);
        }
    }
}
- (IBAction)catBtnClick:(id)sender {
    if (![self.type isEqualToString:@"1"]) {
        self.type = @"1";
//        [self.catBtn setImage:[UIImage imageNamed:@"dbm-gx"] forState:UIControlStateNormal];
//        [self.dogBtn setImage:[UIImage imageNamed:@"wdcw_jxk"] forState:UIControlStateNormal];
        if (self.choseBlock) {
            self.choseBlock(self.type);
        }
    }
}
- (void)setPetType:(NSString *)petType{
    _petType  = petType;
    self.type = petType;
    if ([petType isEqualToString:@"1"]) {
        [self.catBtn setImage:[UIImage imageNamed:@"dbm-gx"] forState:UIControlStateNormal];
        [self.dogBtn setImage:[UIImage imageNamed:@"wdcw_jxk"] forState:UIControlStateNormal];
    }else{
        [self.dogBtn setImage:[UIImage imageNamed:@"dbm-gx"] forState:UIControlStateNormal];
        [self.catBtn setImage:[UIImage imageNamed:@"wdcw_jxk"] forState:UIControlStateNormal];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
