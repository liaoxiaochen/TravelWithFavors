//
//  ApplyAfterSalesTypeView.m
//  TravelWithFavors
//
//  Created by MacBook on 2018/8/25.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "ApplyAfterSalesTypeView.h"

@interface ApplyAfterSalesTypeView()
@property (weak, nonatomic) IBOutlet UIButton *changeGoodBtn;
@property (weak, nonatomic) IBOutlet UIButton *exitGoodBtn;


@end

@implementation ApplyAfterSalesTypeView
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
    if (self) {
        self.frame = frame;
    }
//     self.changeGoodBtn.layer.masksToBounds = YES;
    self.changeGoodBtn.layer.borderWidth = 1;
    [self.changeGoodBtn setTitleColor:[UIColor hdMainColor] forState:UIControlStateNormal];
    self.changeGoodBtn.layer.borderColor = [UIColor hdMainColor].CGColor;
    
    self.exitGoodBtn.layer.borderWidth = 1;
    [self.exitGoodBtn setTitleColor:[UIColor hdPlaceHolderColor] forState:UIControlStateNormal];
    self.exitGoodBtn.layer.borderColor = [UIColor hdPlaceHolderColor].CGColor;
    return self;
}

- (IBAction)changeGoodAction:(id)sender {
    
    [self.changeGoodBtn setTitleColor:[UIColor hdMainColor] forState:UIControlStateNormal];
    self.changeGoodBtn.layer.borderColor = [UIColor hdMainColor].CGColor;
    
    [self.exitGoodBtn setTitleColor:[UIColor hdPlaceHolderColor] forState:UIControlStateNormal];
    self.exitGoodBtn.layer.borderColor = [UIColor hdPlaceHolderColor].CGColor;
}
- (IBAction)exitGoodAction:(id)sender {
    
    [self.changeGoodBtn setTitleColor:[UIColor hdPlaceHolderColor] forState:UIControlStateNormal];
    self.changeGoodBtn.layer.borderColor = [UIColor hdPlaceHolderColor].CGColor;
    
    [self.exitGoodBtn setTitleColor:[UIColor hdMainColor] forState:UIControlStateNormal];
    self.exitGoodBtn.layer.borderColor = [UIColor hdMainColor].CGColor;
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
