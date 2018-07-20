//
//  HDDatePickerView.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/4.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "HDDatePickerView.h"
#import "HDDateHelper.h"
#import "NSDate+HDCalculateDay.h"
#import "UIPickerView+malPicker.h"
#define kDefaultMinLimitedDate @"1970-01-01 00:00" //最小时间
#define kDefaultMaxLimitedDate @"2060-12-31 23:59" //最大时间
@interface HDDatePickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>{
    // 时间数据源的数组中，选中元素的索引
    NSInteger _yearIndex;
    NSInteger _monthIndex;
    NSInteger _dayIndex;
    
    // 最小和最大限制时间、滚动到指定时间实体对象实例
    HDDatePickerDateModel *_datePickerDateMinLimited;
    HDDatePickerDateModel *_datePickerDateMaxLimited;
    HDDatePickerDateModel *_datePickerDateScrollTo;
}
@property (nonatomic, strong) UIPickerView *yearPicker;
@property (nonatomic, strong) UIPickerView *monthPicker;
@property (nonatomic, strong) UIPickerView *dayPicker;
@property (nonatomic, strong) NSMutableArray *yearArr;
@property (nonatomic, strong) NSMutableArray *monthArr;
@property (nonatomic, strong) NSMutableArray *dayArr;
@property (nonatomic, strong) UILabel *yearLabel;
@property (nonatomic, strong) UILabel *monthLabel;
@property (nonatomic, strong) UILabel *dayLabel;
@end
@implementation HDDatePickerView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.yearPicker];
        [self addSubview:self.monthPicker];
        [self addSubview:self.dayPicker];
        
        [self addSubview:self.yearLabel];
        [self addSubview:self.monthLabel];
        [self addSubview:self.dayLabel];
        
        [self loadData];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.yearPicker.frame = CGRectMake(28, 0, 36, self.bounds.size.height);
    self.monthPicker.frame = CGRectMake(124, 0, 36, self.bounds.size.height);
    self.dayPicker.frame = CGRectMake(self.bounds.size.width - 44 - 36, 0, 36, self.bounds.size.height);
    self.yearLabel.frame = CGRectMake(CGRectGetMaxX(self.yearPicker.frame) + 10, (self.bounds.size.height - 20)/2, CGRectGetMinX(self.monthPicker.frame) - CGRectGetMaxX(self.yearPicker.frame) - 20, 20);

    self.monthLabel.frame = CGRectMake(CGRectGetMaxX(self.monthPicker.frame) + 10, (self.bounds.size.height - 20)/2, CGRectGetMinX(self.dayPicker.frame) - CGRectGetMaxX(self.monthPicker.frame) - 20, 20);

    self.dayLabel.frame = CGRectMake(CGRectGetMaxX(self.dayPicker.frame) + 10, (self.bounds.size.height - 20)/2, self.bounds.size.width - CGRectGetMaxX(self.dayPicker.frame) - 20, 20);
}
#pragma mark --自定义方法
- (void)loadData {
    // 初始化最小和最大限制时间、滚动到指定时间实体对象实例
    if (!_minLimitedDate) {
        _minLimitedDate = [HDDateHelper fetchDateFromString:kDefaultMinLimitedDate withFormat:nil];
    }
    _datePickerDateMinLimited = [[HDDatePickerDateModel alloc] initWithHSDate:_minLimitedDate];
    
    if (!_maxLimitedDate) {
        _maxLimitedDate = [HDDateHelper fetchDateFromString:kDefaultMaxLimitedDate withFormat:nil];
    }
    _datePickerDateMaxLimited = [[HDDatePickerDateModel alloc] initWithHSDate:_maxLimitedDate];
    
    // 滚动到指定时间；默认值为当前时间。如果是使用自定义时间小于最小限制时间，这时就以最小限制时间为准；如果是使用自定义时间大于最大限制时间，这时就以最大限制时间为准
    if (!_scrollToDate) {
        _scrollToDate = [HDDateHelper fetchLocalDate];
    }
    if ([_scrollToDate compare:_minLimitedDate] == NSOrderedAscending) {
        _scrollToDate = _minLimitedDate;
    } else if ([_scrollToDate compare:_maxLimitedDate] == NSOrderedDescending) {
        _scrollToDate = _maxLimitedDate;
    }
    _datePickerDateScrollTo = [[HDDatePickerDateModel alloc] initWithHSDate:_scrollToDate];
    
    // 初始化存储时间数据源的数组
    // 年
    for (NSInteger beginVal=[_datePickerDateMinLimited.year integerValue], endVal=[_datePickerDateMaxLimited.year integerValue]; beginVal<=endVal; beginVal++) {
        [self.yearArr addObject:[NSString stringWithFormat:@"%ld", (long)beginVal]];
    }
    _yearIndex = [_datePickerDateScrollTo.year integerValue] - [_datePickerDateMinLimited.year integerValue];
    
    // 月
    for (NSInteger i=1; i<=12; i++) {
        [self.monthArr addObject:[NSString stringWithFormat:@"%02ld", (long)i]];
    }
    _monthIndex = [_datePickerDateScrollTo.month integerValue] - 1;
    
    // 日
    [self reloadDayArray];
    _dayIndex = [_datePickerDateScrollTo.day integerValue] - 1;
    [self.yearPicker selectRow:_yearIndex inComponent:0 animated:YES];
    [self.monthPicker selectRow:_monthIndex inComponent:0 animated:YES];
    [self.dayPicker selectRow:_dayIndex inComponent:0 animated:YES];
}
- (void)reloadDayArray {
    if (self.dayArr.count > 0) {
        [self.dayArr removeAllObjects];
    }
    for (NSUInteger i=1, len=[self fetchDaysOfMonth]; i<=len; i++) {
        [self.dayArr addObject:[NSString stringWithFormat:@"%02ld", (long)i]];
    }
    
    [self.dayPicker reloadAllComponents];
    while (self.dayArr.count-1 < _dayIndex) {
        _dayIndex = self.dayArr.count-1;
    }
    [self.dayPicker selectRow:_dayIndex inComponent:0 animated:YES];
}
- (NSUInteger)fetchDaysOfMonth {
    NSString *dateStr = [NSString stringWithFormat:@"%@-%@-01", self.yearArr[_yearIndex], self.monthArr[_monthIndex]];
    return [[HDDateHelper fetchDateFromString:dateStr withFormat:@"yyyy-MM-dd"] fetchDaysOfMonth];
}
- (BOOL)validatedDate:(NSDate *)date {
    NSString *minDateStr = [NSString stringWithFormat:@"%@-%@-%@",
                            _datePickerDateMinLimited.year,
                            _datePickerDateMinLimited.month,
                            _datePickerDateMinLimited.day];
    
    return !([date compare:[HDDateHelper fetchDateFromString:minDateStr withFormat:@"yyyy-MM-dd"]] == NSOrderedAscending ||
             [date compare:_maxLimitedDate] == NSOrderedDescending);
}
- (void)scrollToNowDateIndexPosition:(UIButton *)sender {
    [self scrollToDateIndexPositionWithDate:[HDDateHelper fetchLocalDate]];
}
- (void)scrollToDateIndexPositionWithDate:(NSDate *)date {
    // 为了区别最大最小限制范围外行的标签颜色，这里需要重新加载所有组件列
//    [self.yearPicker reloadAllComponents];
//    [self.monthPicker reloadAllComponents];
//    [self.dayPicker reloadAllComponents];
    _scrollToDate = date;
    _datePickerDateScrollTo = [[HDDatePickerDateModel alloc] initWithHSDate:_scrollToDate];
    _yearIndex = [_datePickerDateScrollTo.year integerValue] - [_datePickerDateMinLimited.year integerValue];
    _monthIndex = [_datePickerDateScrollTo.month integerValue] - 1;
    _dayIndex = [_datePickerDateScrollTo.day integerValue] - 1;
//    [self scrollToDateIndexPosition];
    //滚动
    [self.yearPicker selectRow:_yearIndex inComponent:0 animated:YES];
    [self.monthPicker selectRow:_monthIndex inComponent:0 animated:YES];
    [self.dayPicker selectRow:_dayIndex inComponent:0 animated:YES];
    if (self.timeBlocl) {
        self.timeBlocl(_datePickerDateScrollTo.year, _datePickerDateScrollTo.month, _datePickerDateScrollTo.day);
    }
}
- (void)scrollToDateIndexPosition {
    NSArray *arrIndex = @[
                         [NSNumber numberWithInteger:_yearIndex],
                         [NSNumber numberWithInteger:_monthIndex],
                         [NSNumber numberWithInteger:_dayIndex]
                         ];
    
    
    for (NSUInteger i=0, len=arrIndex.count; i<len; i++) {
        [self.yearPicker selectRow:[arrIndex[i] integerValue] inComponent:0 animated:YES];
        [self.monthPicker selectRow:[arrIndex[i] integerValue] inComponent:1 animated:YES];
        [self.dayPicker selectRow:[arrIndex[i] integerValue] inComponent:2 animated:YES];
    }
}
#pragma mark - 重写属性
- (void)setMinLimitedDate:(NSDate *)minLimitedDate {
    _minLimitedDate = minLimitedDate;
    if (_minLimitedDate && !_defaultLimitedDate) {
        _defaultLimitedDate = _minLimitedDate;
    }
}
- (void)setMaxLimitedDate:(NSDate *)maxLimitedDate{
    _maxLimitedDate = maxLimitedDate;
    if (_maxLimitedDate && !_defaultLimitedDate) {
        _defaultLimitedDate = _maxLimitedDate;
    }
}
- (void)setDefaultLimitedDate:(NSDate *)defaultLimitedDate{
    _defaultLimitedDate = defaultLimitedDate;
    _scrollToDate = _defaultLimitedDate;
    _datePickerDateScrollTo = [[HDDatePickerDateModel alloc] initWithHSDate:_scrollToDate];
//    if (![self validatedDate:_scrollToDate]) {
        [self scrollToDateIndexPositionWithDate:_defaultLimitedDate];
//    }
}
#pragma mark --UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if (pickerView == self.yearPicker) {
        return self.yearArr.count;
    }
    if (pickerView == self.monthPicker) {
        return self.monthArr.count;
    }
    return self.dayArr.count;
}
#pragma mark --UIPickerViewDelegate

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 30.0;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *lblCustom = (UILabel *)view;
    if (!lblCustom) {
        lblCustom = [UILabel new];
        lblCustom.textAlignment = NSTextAlignmentCenter;
        lblCustom.textColor = [UIColor colorWithHexString:@"#333333"];
        lblCustom.font = [UIFont systemFontOfSize:14.0];
    }
    if (pickerView == self.yearPicker) {
        lblCustom.text = self.yearArr[row];
    }
    else if (pickerView == self.monthPicker){
        lblCustom.text = self.monthArr[row];
    }
    else{
        lblCustom.text = self.dayArr[row];
    }
    [pickerView clearSpearatorLine];
    return lblCustom;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (pickerView == self.yearPicker) {
        _yearIndex = row;
        [self reloadDayArray];
        
    }
    if (pickerView == self.monthPicker) {
        _monthIndex = row;
        [self reloadDayArray];
    }
    if (pickerView == self.dayPicker) {
        _dayIndex = row;
    }
    NSString *dateStr = [NSString stringWithFormat:@"%@-%@-%@",
                         self.yearArr[_yearIndex],
                         self.monthArr[_monthIndex],
                         self.dayArr[_dayIndex]];
    _scrollToDate = [HDDateHelper fetchDateFromString:dateStr withFormat:@"yyyy-MM-dd "];
    _datePickerDateScrollTo = [[HDDatePickerDateModel alloc] initWithHSDate:_scrollToDate];
    if (![self validatedDate:_scrollToDate]) {
        [self scrollToDateIndexPositionWithDate:_defaultLimitedDate];
    }else{
        if (self.timeBlocl) {
            self.timeBlocl(_datePickerDateScrollTo.year, _datePickerDateScrollTo.month, _datePickerDateScrollTo.day);
        }
    }
}
#pragma mark --laod--
- (UIPickerView *)yearPicker{
    if (!_yearPicker) {
        _yearPicker = [[UIPickerView alloc] init];
        _yearPicker.delegate = self;
        _yearPicker.dataSource = self;
    }
    return _yearPicker;
}
- (UIPickerView *)monthPicker{
    if (!_monthPicker) {
        _monthPicker = [[UIPickerView alloc] init];
        _monthPicker.delegate = self;
        _monthPicker.dataSource = self;
    }
    return _monthPicker;
}
- (UIPickerView *)dayPicker{
    if (!_dayPicker) {
        _dayPicker = [[UIPickerView alloc] init];
        _dayPicker.delegate = self;
        _dayPicker.dataSource = self;
    }
    return _dayPicker;
}
- (NSMutableArray *)yearArr{
    if (!_yearArr) {
        _yearArr = [[NSMutableArray alloc] init];
    }
    return _yearArr;
}
- (NSMutableArray *)monthArr{
    if (!_monthArr) {
        _monthArr = [[NSMutableArray alloc] init];
    }
    return _monthArr;
}
- (NSMutableArray *)dayArr{
    if (!_dayArr) {
        _dayArr = [[NSMutableArray alloc] init];
    }
    return _dayArr;
}
- (UILabel *)yearLabel{
    if (!_yearLabel) {
        _yearLabel = [[UILabel alloc] init];
        _yearLabel.text = @"年";
        _yearLabel.textColor = [UIColor colorWithHexString:@"#FF980D"];
        _yearLabel.font = [UIFont systemFontOfSize:15.0f];
        _yearLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _yearLabel;
}
- (UILabel *)monthLabel{
    if (!_monthLabel) {
        _monthLabel = [[UILabel alloc] init];
        _monthLabel.text = @"月";
        _monthLabel.textColor = [UIColor colorWithHexString:@"#FF980D"];
        _monthLabel.font = [UIFont systemFontOfSize:15.0f];
        _monthLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _monthLabel;
}
- (UILabel *)dayLabel{
    if (!_dayLabel) {
        _dayLabel = [[UILabel alloc] init];
        _dayLabel.text = @"日";
        _dayLabel.textColor = [UIColor colorWithHexString:@"#FF980D"];
        _dayLabel.font = [UIFont systemFontOfSize:15.0f];
        _dayLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _dayLabel;
}
- (void)dealloc{
    debugLog(@"时间选择器释放了");
}
@end
