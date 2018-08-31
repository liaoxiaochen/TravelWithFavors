//
//  CityHistoryView.m
//  TravelWithFavors
//
//  Created by MacBook on 2018/7/23.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "CityHistoryView.h"
#import "ButtonGroupView.h"

@interface CityHistoryView()<ButtonGroupViewDelegate>

@property (strong, nonatomic) ButtonGroupView *historicalCityGroupView; //历史使用城市/常用城市
@property (nonatomic, strong) NSMutableArray *cityItemArr;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, assign) CGFloat hisViewHight;

@end

@implementation CityHistoryView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        
         [self setupUI];
    }
    return self;
}

- (void)setDataSource:(NSMutableArray *)dataSource {
    _dataSource = dataSource;
    
    _cityItemArr = [NSMutableArray array];
    for (NSString*cityName in dataSource) {
        [_cityItemArr addObject: [CityItem initWithTitleName:cityName]];
    }
    _historicalCityGroupView.items = _cityItemArr;
    
    long rowHistorical = _cityItemArr.count/3;
    if (_cityItemArr.count % 3 > 0) {
        rowHistorical += 1;
    }
    CGFloat hisViewHight = 45 * rowHistorical;
    _historicalCityGroupView.frame = CGRectMake(0, 50, self.frame.size.width, hisViewHight);

}

- (void)setupUI {
    
    [self addSubview:self.backView];
 
    [self addSubview:self.tipLabel];
    
    [self addSubview:self.historicalCityGroupView];

}

- (ButtonGroupView *)historicalCityGroupView {
    
    if (!_historicalCityGroupView) {
        _historicalCityGroupView = [[ButtonGroupView alloc]initWithFrame:CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width - 20, self.hisViewHight)];
        _historicalCityGroupView.backgroundColor = [UIColor clearColor];
        _historicalCityGroupView.columns = 3;
        _historicalCityGroupView.delegate = self;
    }
    
    return _historicalCityGroupView;
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 30)];
        _backView.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
    }
    return _backView;
}

- (UILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, self.backView.bounds.size.width - 32, self.backView.bounds.size.height)];
        _tipLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _tipLabel.text = @"当前/历史";
    }
    return _tipLabel;
}

-(void)ButtonGroupView:(ButtonGroupView *)buttonGroupView didClickedItem:(CityButton *)item
{

    if (self.delegate && [self.delegate respondsToSelector:@selector(cityHistoryViewdidClickedItem:)]) {
        [self.delegate cityHistoryViewdidClickedItem:item];
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
