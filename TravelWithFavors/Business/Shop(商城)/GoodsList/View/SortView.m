//
//  SortView.m
//  TravelWithFavors
//
//  Created by MacBook on 2018/8/13.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "SortView.h"

@implementation SortView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor hdMainColor];
        
        NSArray *sortArr = @[@"综合排序",@"最新上架",@"销量最高",@"价格排序"];
        for (NSInteger i = 0; i < 4; i++) {
            UIButton *sortBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [sortBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            sortBtn.titleLabel.font = [UIFont systemFontOfSize:14];
            sortBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
            [sortBtn setTitle:sortArr[i] forState:UIControlStateNormal];
            sortBtn.frame = CGRectMake(SELF_WIDTH / 4 * i, 0, SELF_WIDTH / 4, SELF_HEIGHT);
            sortBtn.tag = 2000 + i;
            [sortBtn addTarget:self action:@selector(sortBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:sortBtn];
        }
    }
    return self;
}

- (void)sortBtnAction:(UIButton *)sender {
    
    [self.delegate sortBtnClick:sender.tag - 2000];
    
}
 

@end
