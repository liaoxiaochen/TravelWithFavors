//
//  CYPopTableView.h
//  YI
//
//  Created by Lanan on 2018/7/9.
//  Copyright © 2018年 Lanan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CYPopTableViewModel;

typedef void(^SendStrBlock) (CYPopTableViewModel *model, NSInteger index);

@interface CYPopTableView : UIView

@property(nonatomic, assign)BOOL isTop;
@property (nonatomic, copy) SendStrBlock sendStrBlock;


+ (instancetype)initWithFrame:(CGRect)frame dependView:(UIView *)view textArr:(NSArray<CYPopTableViewModel *> *)textArr block:(SendStrBlock)block;

@end


@interface CYPopTableViewModel : NSObject

@property(nonatomic, strong) NSAttributedString *attrButedString;
@property(nonatomic, assign) BOOL isSelected;
@property(nonatomic, strong) UIImage *rightIcon;


+ (CYPopTableViewModel *)initCYPopTableViewModelWithAttrButedString:(NSAttributedString *)attrButedString rightIcon:(UIImage *)rightIcon isSelect:(BOOL)isSelect;

@end
