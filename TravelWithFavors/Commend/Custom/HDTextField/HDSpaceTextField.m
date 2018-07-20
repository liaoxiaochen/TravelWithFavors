//
//  HDSpaceTextField.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/8.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "HDSpaceTextField.h"

@implementation HDSpaceTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(CGRect)placeholderRectForBounds:(CGRect)bounds
{
    //    if (@available(iOS 11.0, *)) {
    CGRect inset = CGRectMake(bounds.origin.x + 10, (self.bounds.size.height - bounds.size.height)/2, bounds.size.width - 20, bounds.size.height);
    return inset;
    //    }else{
    //        return bounds;
    //    }
}
@end
