//
//  FSCalendarStaticHeader.m
//  FSCalendar
//
//  Created by dingwenchao on 9/17/15.
//  Copyright (c) 2015 Wenchao Ding. All rights reserved.
//

#import "FSCalendarStickyHeader.h"
#import "FSCalendar.h"
#import "FSCalendarWeekdayView.h"
#import "FSCalendarExtensions.h"
#import "FSCalendarConstants.h"
#import "FSCalendarDynamicHeader.h"

#define CATDayLabelWidth  ([UIScreen mainScreen].bounds.size.width/7)
#define CATDayLabelHeight 20.0f

@interface FSCalendarStickyHeader ()

@property (weak  , nonatomic) UIView  *contentView;
@property (weak  , nonatomic) FSCalendarWeekdayView *weekdayView;



@end

@implementation FSCalendarStickyHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *view;
        UILabel *label;
        UILabel *rightLabel;
        
        CGFloat headerWidth = [UIScreen mainScreen].bounds.size.width;
        UIView *spaceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, headerWidth, 20)];
        spaceView.backgroundColor = [UIColor colorWithHexString:@"#e6e6e6"];
        [self addSubview:spaceView];
        
        view = [[UIView alloc] initWithFrame:CGRectZero];
        view.backgroundColor = [UIColor clearColor];
        [self addSubview:view];
        self.contentView = view;
        
        label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.textAlignment = NSTextAlignmentLeft;
        label.numberOfLines = 0;
        [_contentView addSubview:label];
        self.titleLabel = label;
        self.titleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        
        rightLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        rightLabel.textAlignment = NSTextAlignmentRight;
        rightLabel.numberOfLines = 0;
        [_contentView addSubview:rightLabel];
        self.yearLabel = rightLabel;
        self.yearLabel.font = [UIFont systemFontOfSize:16];
        self.yearLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        
        CGFloat titleWidth = self.frame.size.width / 2;
        _titleLabel.frame = CGRectMake(20.f, 40.0f, titleWidth - 20, 30.f);
        _yearLabel.frame = CGRectMake(titleWidth, 40.0f, titleWidth - 20, 30.f);
        
        CGFloat yOffset = CGRectGetMaxY(rightLabel.frame) + 35;
        NSArray *textArray = @[@"日", @"一", @"二", @"三", @"四", @"五", @"六"];
        for (int i = 0; i < textArray.count; i++) {
            [self initHeaderWeekText:textArray[i] titleColor:[UIColor colorWithHexString:@"#333333"] x:CATDayLabelWidth * i y:yOffset];
        }
        
        [self configureAppearance];
        
        
        FSCalendarWeekdayView *weekdayView = [[FSCalendarWeekdayView alloc] init];
        [self.contentView addSubview:weekdayView];
        self.weekdayView = weekdayView;
    }
    return self;
}


#pragma mark - Properties
- (void)setCalendar:(FSCalendar *)calendar
{
    if (![_calendar isEqual:calendar]) {
        _calendar = calendar;
        _weekdayView.calendar = calendar;
        [self configureAppearance];
    }
}

#pragma mark - Private methods

- (void)configureAppearance
{
    [self.weekdayView configureAppearance];
}

- (void)setMonth:(NSDate *)month
{
    _month = month;

    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy"];
    NSInteger currentYear=[[formatter stringFromDate:month] integerValue];
    [formatter setDateFormat:@"MM"];
    NSInteger currentMonth=[[formatter stringFromDate:month]integerValue];

    NSString *monthStr = [NSString stringWithFormat:@"%ld",(long)currentMonth];
     self.titleLabel.attributedText = [NSString changeLabelWithMaxString:[NSString stringWithFormat:@"%@月", monthStr] diffrenIndex:monthStr.length maxFont:32 littleFont:16];
    self.yearLabel.text = [NSString stringWithFormat:@"%ld年", (long)currentYear];

}


// 初始化数据
- (void)initHeaderWeekText:(NSString *)text titleColor:(UIColor *)color x:(CGFloat)x y:(CGFloat)y {
    UILabel *titleText = [[UILabel alloc]initWithFrame:CGRectMake(x, y, CATDayLabelWidth, CATDayLabelHeight)];
    [titleText setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15.0f]];
    titleText.textAlignment = NSTextAlignmentCenter;
    titleText.textColor = color;
    titleText.text = text;
    [self addSubview:titleText];
}

@end


