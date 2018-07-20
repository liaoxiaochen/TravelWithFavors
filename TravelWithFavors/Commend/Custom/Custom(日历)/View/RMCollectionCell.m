//
//  RMCollectionCell.m
//  RMCalendar
//
//  Created by 迟浩东 on 15/7/15.
//  Copyright © 2015年 迟浩东(http://www.ruanman.net). All rights reserved.
//

#import "RMCollectionCell.h"
#import "UIView+CustomFrame.h"
#import "RMCalendarModel.h"

#import "TicketModel.h"

#define kFont(x) [UIFont systemFontOfSize:x]
#define COLOR_HIGHLIGHT ([UIColor redColor])
#define COLOR_NOAML ([UIColor colorWithRed:26/256.0  green:168/256.0 blue:186/256.0 alpha:1])

@interface RMCollectionCell()

/**
 *  显示日期
 */
@property (nonatomic, weak) UILabel *dayLabel;
/**
 *  显示农历
 */
@property (nonatomic, weak) UILabel *chineseCalendar;
/**
 *  假日
 */
@property (nonatomic, weak) UILabel *holidayLabel;
/**
 *  选中的背景图片
 */
@property (nonatomic, weak) UIImageView *selectImageView;
/**
 *  票价   此处可根据项目需求自行修改
 */
@property (nonatomic, weak) UILabel *price;

@end

@implementation RMCollectionCell

- (nonnull instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    [self initCellView];
    return self;
}

- (void)initCellView {
    
    //选中时显示的图片
    UIImageView *selectImageView = [[UIImageView alloc]initWithFrame:self.bounds];
    selectImageView.image = [UIImage imageNamed:@"CalenderSelectedDate"];
    //    selectImageView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"CalendarSelectedDate"]];
    self.selectImageView = selectImageView;
    [self addSubview:selectImageView];
    
//    UILabel *dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.width * 0.5)];
    UILabel *dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height )];
    dayLabel.font = kFont(18);
    dayLabel.textAlignment = NSTextAlignmentCenter;
    self.dayLabel = dayLabel;
    [self addSubview:dayLabel];
    
    UILabel *chineseCalendar = [[UILabel alloc] init];
    chineseCalendar.font = kFont(12);
    self.chineseCalendar = chineseCalendar;
    [self addSubview:chineseCalendar];
    
    UILabel *holidayLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 15, dayLabel.width, 15)];
    holidayLabel.font = kFont(9);
    holidayLabel.textAlignment = NSTextAlignmentCenter;
    self.holidayLabel = holidayLabel;
    [self addSubview:holidayLabel];
    
#warning 价格Label 可根据需求修改
    UILabel *price = [[UILabel alloc] initWithFrame:CGRectMake(0, dayLabel.height, dayLabel.width, dayLabel.height)];
    price.font = kFont(9);
    price.textAlignment = NSTextAlignmentCenter;
    self.price = price;
    [self addSubview:price];
}

- (void)setModel:(RMCalendarModel *)model {
    _model = model;
    
    //没有剩余票数
    if (!model.ticketModel.ticketCount || model.style == CellDayTypePast) {
        self.price.hidden = YES;
        model.isEnable ? model.style : model.style != CellDayTypeEmpty ? model.style = CellDayTypePast : model.style;
    } else {
        self.price.hidden = NO;
        self.price.textColor = [UIColor orangeColor];
        self.price.text = [NSString stringWithFormat:@"￥%.1f",model.ticketModel.ticketPrice];
    }

    switch (model.style) {
        case CellDayTypeEmpty:
            self.selectImageView.hidden = YES;
            self.dayLabel.hidden = YES;
            self.holidayLabel.hidden = YES;
            self.backgroundColor = [UIColor whiteColor];
            break;
        case CellDayTypePast:
            self.dayLabel.hidden = NO;
            self.selectImageView.hidden = YES;
            if (model.holiday) {
                self.holidayLabel.hidden = NO;
                self.holidayLabel.text = model.holiday;
            } else {
                self.holidayLabel.hidden = YES;
            }
            self.dayLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)model.day];
            self.dayLabel.textColor = [UIColor colorWithHexString:@"#999999"];
            // self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"CalendarDisableDate"]];
            break;
            
        case CellDayTypeFutur:
            self.dayLabel.hidden = NO;
            self.selectImageView.hidden = YES;
            if (model.holiday) {
                self.holidayLabel.hidden = NO;
                self.holidayLabel.text = model.holiday;
            } else {
                self.holidayLabel.hidden = YES;
            }
                self.dayLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)model.day];
//                self.dayLabel.textColor = COLOR_NOAML;
                self.dayLabel.textColor = [UIColor colorWithHexString:@"#333333"];

            
//            self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"CalendarNormalDate"]];
            break;
            
        case CellDayTypeWeek:
            self.dayLabel.hidden = NO;
            self.selectImageView.hidden = YES;
            if (model.holiday) {
                self.holidayLabel.hidden = NO;
                self.holidayLabel.text = model.holiday;
            } else {
                self.holidayLabel.hidden = YES;
            }
                self.dayLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)model.day];
                //                self.dayLabel.textColor = COLOR_NOAML;
                self.dayLabel.textColor = [UIColor colorWithHexString:@"#333333"];
                
 //            self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"CalendarNormalDate"]];
            //            day_title.text = model.Chinese_calendar;
            break;
            
        case CellDayTypeClick:
            self.dayLabel.hidden = NO;
            self.selectImageView.hidden = NO;
            if (model.holiday) {
                self.holidayLabel.hidden = NO;
                self.holidayLabel.text = model.holiday;
            } else {
                self.holidayLabel.hidden = YES;
            }
//            self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"CalendarNormalDate"]];
            self.dayLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)model.day];
            self.dayLabel.textColor = [UIColor whiteColor];
            self.price.textColor = [UIColor whiteColor];
            //            day_title.text = model.Chinese_calendar;
            break;
       

    }
    
}

@end
