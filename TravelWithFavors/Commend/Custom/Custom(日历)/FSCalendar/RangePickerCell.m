//
//  RangePickerCell.m
//  FSCalendar
//
//  Created by dingwenchao on 02/11/2016.
//  Copyright © 2016 Wenchao Ding. All rights reserved.
//

#import "RangePickerCell.h"
#import "FSCalendarExtensions.h"

@implementation RangePickerCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
 
        CALayer *selectionLayer = [[CALayer alloc] init];
        selectionLayer.backgroundColor = [UIColor hdMainColor].CGColor;
        selectionLayer.actions = @{@"hidden":[NSNull null]}; // Remove hiding animation
        [self.contentView.layer insertSublayer:selectionLayer below:self.titleLabel.layer];
        self.selectionLayer = selectionLayer;


        CALayer *middleLayer = [[CALayer alloc] init];
        middleLayer.backgroundColor = [[UIColor hdMainColor] colorWithAlphaComponent:0.3].CGColor;
        middleLayer.actions = @{@"hidden":[NSNull null]}; // Remove hiding animation
        [self.contentView.layer insertSublayer:middleLayer below:self.titleLabel.layer];
        self.middleLayer = middleLayer;

        // Hide the default selection layer
        self.shapeLayer.hidden = YES;
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    self.titleLabel.frame = self.contentView.bounds;
}

- (void)layoutSublayersOfLayer:(CALayer *)layer
{
    [super layoutSublayersOfLayer:layer];
    
    CGFloat width = self.contentView.frame.size.width / 3 * 1.8;
    CGFloat widthSpace = (self.contentView.frame.size.width - width) / 2;
    CGFloat heightSpace = (self.contentView.frame.size.height - width) / 2;
    
    self.selectionLayer.frame = CGRectMake(widthSpace, heightSpace, width, width);
    self.selectionLayer.cornerRadius = width / 2;
    self.selectionLayer.masksToBounds = YES;
    
    self.middleLayer.frame = CGRectMake(widthSpace, heightSpace, width, width);
    self.middleLayer.cornerRadius = width / 2;
    self.middleLayer.masksToBounds = YES;
    
    
}

 

@end
