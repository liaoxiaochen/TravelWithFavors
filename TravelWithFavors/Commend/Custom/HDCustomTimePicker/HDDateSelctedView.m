//
//  HDDateSelctedView.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/4.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "HDDateSelctedView.h"
#import "HDDatePickerView.h"
#import "HDDatePickerDateModel.h"
@interface HDDateSelctedView ()
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) HDDatePickerView *pickerView;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *markLabel;
@property (nonatomic, strong) UIButton *sureBtn;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, copy) NSString *year;
@property (nonatomic, copy) NSString *month;
@property (nonatomic, copy) NSString *day;
@end
@implementation HDDateSelctedView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
        self.bgView.frame = CGRectMake(0, 0, 300, 200);
        [self addSubview:self.bgView];
        
        self.timeLabel.frame = CGRectMake(0, 0, self.bgView.bounds.size.width, 100);
        [self.bgView addSubview:self.timeLabel];
        
        self.markLabel.frame = CGRectMake(0, CGRectGetMaxY(self.timeLabel.frame), self.bgView.bounds.size.width, 50);
        [self.bgView addSubview:self.markLabel];
        
        self.pickerView.frame = CGRectMake(0, CGRectGetMaxY(self.markLabel.frame), self.bgView.bounds.size.width, 100);
        if (self.birth) {
            NSDateFormatter *format=[[NSDateFormatter alloc] init];
            [format setDateFormat:@"yyyy-MM-dd"];
            NSDate *fromdate=[format dateFromString:self.birth];
            NSTimeZone *fromzone = [NSTimeZone systemTimeZone];
            NSInteger frominterval = [fromzone secondsFromGMTForDate: fromdate];
            NSDate *fromDate = [fromdate  dateByAddingTimeInterval: frominterval];
            NSLog(@"fromdate=%@",fromDate);
            self.pickerView.defaultLimitedDate = fromDate;
        }else{
            //默认时间
            self.year =  [[HDDatePickerDateModel alloc] initWithHSDate:[NSDate date]].year;
            self.month = [[HDDatePickerDateModel alloc] initWithHSDate:[NSDate date]].month;
            self.day = [[HDDatePickerDateModel alloc] initWithHSDate:[NSDate date]].day;
        }
        __weak typeof(self) weakSelf = self;
        self.pickerView.timeBlocl = ^(NSString *year, NSString *month, NSString *day) {
            weakSelf.year = year;
            weakSelf.month = month;
            weakSelf.day = day;
        };
        self.pickerView.maxLimitedDate = [NSDate date];
        [self.bgView addSubview:self.pickerView];
        
        self.sureBtn.frame = CGRectMake(self.bgView.bounds.size.width - 60 - 8, CGRectGetMaxY(self.pickerView.frame) + 8, 60, 30);
        [self.bgView addSubview:self.sureBtn];
        
        self.cancelBtn.frame = CGRectMake(CGRectGetMinX(self.sureBtn.frame) - 60 - 24, self.sureBtn.frame.origin.y, self.sureBtn.bounds.size.width, self.sureBtn.bounds.size.height);
        [self.bgView addSubview:self.cancelBtn];
        CGFloat bgH = CGRectGetMaxY(self.sureBtn.frame) + 8;
        self.bgView.frame = CGRectMake((frame.size.width - 300)/2, (frame.size.height - bgH)/2, 300, bgH);
    }
    return self;
}
- (void)setBirth:(NSString *)birth{
    _birth = birth;
    if (birth.length > 0) {
        NSArray *arr = [birth componentsSeparatedByString:@"-"];
        if (arr.count == 3) {
            self.year = arr[0];
            self.month = arr[1];
            self.day = arr[2];
        }
    }
}
- (void)showHDDateSelctedView{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}
- (void)dismiss{
    [self removeFromSuperview];
}
#pragma mark --action
- (void)sureBtnClick{
    if (self.birthBlocl) {
        self.birthBlocl(self.year, self.month, self.day);
    }
    [self dismiss];
}
- (void)cancelBtnClick{
    [self dismiss];
}
#pragma mark --load--
- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.cornerRadius = 5;
        _bgView.layer.masksToBounds = YES;
    }
    return _bgView;
}
- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textColor = [UIColor whiteColor];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.backgroundColor = [UIColor colorWithHexString:@"#FF980D"];
    }
    return _timeLabel;
}
- (UILabel *)markLabel{
    if (!_markLabel) {
        _markLabel = [[UILabel alloc] init];
        _markLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _markLabel.text = @"选择出生年月日";
        _markLabel.font = [UIFont systemFontOfSize:11.0f];
        _markLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _markLabel;
}
- (HDDatePickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[HDDatePickerView alloc] init];
    }
    return _pickerView;
}
- (UIButton *)sureBtn{
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_sureBtn setTitleColor:[UIColor colorWithHexString:@"#FF980D"] forState:UIControlStateNormal];
        _sureBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [_sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}
- (UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [_cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}
- (void)dealloc{
    debugLog(@"时间选择器的view释放了");
}
@end
