//
//  RulePopupViewCell.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/7.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "RulePopupViewCell.h"
@interface RulePopupViewCell ()
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end
@implementation RulePopupViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.lineView.layer.cornerRadius = self.lineView.bounds.size.width/2;
    self.lineView.layer.masksToBounds = YES;
}
- (void)setTitleStr:(NSString *)titleStr{
    _titleStr = titleStr;
    //改变行间距
    UIFont *font = self.titleLabel.font;
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = 6; //设置行间距
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    //设置字间距 NSKernAttributeName:@1.5f
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.0f};
    
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:titleStr attributes:dic];
    self.titleLabel.attributedText = attributeStr;
//    self.titleLabel.text = titleStr;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
