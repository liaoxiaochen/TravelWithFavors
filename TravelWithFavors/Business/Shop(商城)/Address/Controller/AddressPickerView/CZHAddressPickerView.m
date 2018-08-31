//
//  CZHAddressPickerView.m
//  CZHAddressPickerView
//
//  Created by 程召华 on 2017/11/24.
//  Copyright © 2017年 程召华. All rights reserved.
//

#import "CZHAddressPickerView.h"
#import "AddressPickerHeader.h"
#import "UIButton+CZHExtension.h"

#define TOOLBAR_BUTTON_WIDTH CZH_ScaleWidth(65)

typedef NS_ENUM(NSInteger, CZHAddressPickerViewButtonType) {
    CZHAddressPickerViewButtonTypeCancle,
    CZHAddressPickerViewButtonTypeSure
};



@interface CZHAddressPickerView ()<UIPickerViewDelegate, UIPickerViewDataSource>
///<#注释#>
@property (nonatomic, assign) NSInteger columnCount;
///容器view
@property (nonatomic, weak) UIView *containView;
///
@property(nonatomic, strong) UIPickerView * pickerView;
///省
@property(nonatomic, strong) NSArray * provinceArray;
///市
@property(nonatomic, strong) NSArray * cityArray;
///区
@property(nonatomic, strong) NSArray * areaArray;
///所有数据
@property(nonatomic, strong) NSArray * dataSource;
///记录省选中的位置
@property(nonatomic, assign) NSInteger selectProvinceIndex;

///传进来的默认选中的省
@property(nonatomic, strong) NSDictionary *selectProvinceDic;
///传进来的默认选中的市
@property(nonatomic, strong) NSDictionary * selectCityDic;
///传进来的默认选中的区
@property(nonatomic, strong) NSDictionary * selectAreaDic;
///区域回调
@property (nonatomic, copy) void (^areaDicBlock)(NSDictionary *provinceDic, NSDictionary *cityDic, NSDictionary *areaDic);


@end


@implementation CZHAddressPickerView

+ (instancetype)areaPickerViewWithProvinceDic:(NSDictionary *)provinceDic cityDic:(NSDictionary *)cityDic areaDic:(NSDictionary *)areaDic areaDicBlock:(void(^)(NSDictionary *provinceDic, NSDictionary *cityDic, NSDictionary *areaDic))areaDicBlock {
    
    return [CZHAddressPickerView addressPickerViewWithProvinceDic:provinceDic cityDic:cityDic areaDic:areaDic areaDicBlock:areaDicBlock];
}


+ (instancetype)addressPickerViewWithProvinceDic:(NSDictionary *)provinceDic cityDic:(NSDictionary *)cityDic areaDic:(NSDictionary *)areaDic areaDicBlock:(void(^)(NSDictionary *provinceDic, NSDictionary *cityDic, NSDictionary *areaDic))areaDicBlock {
    
    CZHAddressPickerView *_view = [[CZHAddressPickerView alloc] init];
    
    
    _view.selectProvinceDic = provinceDic;
    
    _view.selectCityDic = cityDic;
    
    _view.selectAreaDic = areaDic;

    
    _view.areaDicBlock = areaDicBlock;
    
    [_view cheakCacheData];
    
    [_view showView];
    
    return _view;
    
}
- (void)cheakCacheData{
    //异步方式
    NSString *key = @"ProvinceCityArea";
    YYCache *yyCache=[YYCache cacheWithName:@"ProvinceCityArea"];
    //根据key读取数据
    [yyCache objectForKey:key withBlock:^(NSString * _Nonnull key, id<NSCoding>  _Nonnull object) {
        if (object) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self refreshData:object];
                [self czh_getDataFormNetRefreshNow:NO];
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self czh_getDataFormNetRefreshNow:YES];
            });
        }
    }];
}

- (void)saveCacheData:(id)data refreshNow:(BOOL)refreshNow{
    NSString *key = @"ProvinceCityArea";
    YYCache *yyCache=[YYCache cacheWithName:@"ProvinceCityArea"];
    [yyCache containsObjectForKey:key withBlock:^(NSString * _Nonnull key, BOOL contains) {
        NSLog(@"containsObject : %@", contains?@"YES":@"NO");
        if (contains) {
            [yyCache removeObjectForKey:key withBlock:^(NSString * _Nonnull key) {
                NSLog(@"removeObjectForKey %@",key);
                //根据key写入缓存value
                [yyCache setObject:data forKey:key withBlock:^{
                    HRLog(@"setObject sucess");
                }];
            }];
        }else {
            //根据key写入缓存value
            [yyCache setObject:data forKey:key withBlock:^{
                HRLog(@"setObject sucess");
            }];
        }
    }];

    if (refreshNow) {
        [self refreshData:data];
    }
}
- (void)refreshData:(id)data {
    
    self.dataSource = data[@"province_list"];
    self.provinceArray = self.dataSource;
    self.cityArray = [self.provinceArray firstObject][@"city_list"];
    self.areaArray = [self.cityArray firstObject][@"area_list"];
    
    if (!self.selectProvinceDic) {
        self.selectProvinceDic = [self.provinceArray firstObject];
    }
    if (!self.selectCityDic) {
        self.selectCityDic = [self.cityArray firstObject];
    }
    if (!self.selectAreaDic) {
        self.selectAreaDic = [self.areaArray firstObject];
    }
    
    
    NSInteger provinceIndex = 0;
    NSInteger cityIndex = 0;
    NSInteger areaIndex = 0;
    
    for (NSInteger p = 0; p < self.provinceArray.count; p++) {
        NSDictionary *proDic = self.provinceArray[p];
        if ([proDic[@"province"] isEqualToString:self.selectProvinceDic[@"province"]]) {
            self.selectProvinceIndex = p;
            HRLog(@"P    %ld", p);
            provinceIndex = p;
            self.cityArray = self.provinceArray[p][@"city_list"];
            
            for (NSInteger c = 0; c < self.cityArray.count; c++) {
                NSDictionary *cityDic = self.cityArray[c];
 
                if ([cityDic[@"city"] isEqualToString:self.selectCityDic[@"city"]]) {
                    cityIndex = c;
                    self.areaArray = self.cityArray[c][@"area_list"];
                    
                    for (NSInteger a = 0; a < self.areaArray.count; a++) {
                        NSDictionary *areaDic = self.areaArray[a];
 
                        if ([areaDic[@"area"] isEqualToString:self.selectAreaDic[@"area"]]) {
                            areaIndex = a;
                        }
                    }
                }
            }
        }
    }
    
    
    
    [self.pickerView reloadAllComponents];
    
    [self.pickerView selectRow:provinceIndex inComponent:0 animated:YES];
    [self.pickerView selectRow:cityIndex inComponent:1 animated:YES];
    [self.pickerView selectRow:areaIndex inComponent:2 animated:YES];
    
}

- (void)czh_getDataFormNetRefreshNow:(BOOL)refreshNow{
    
    NSString *url = [HttpNetRequestTool requestUrlString:@"/business/address"];
    [HttpNetRequestTool netRequestWithHeader:HttpNetRequestPost urlString:url paraments:nil success:^(id Json) {
        BaseModel *model = [BaseModel yy_modelWithJSON:Json];
        [self saveCacheData:model.data refreshNow:refreshNow];
        
    } failure:^(NSString *error) {
        
    }];
    
}

- (void)buttonClick:(UIButton *)sender {
    
    [self hideView];
    
    if (sender.tag == CZHAddressPickerViewButtonTypeSure) {
 
        if (_areaDicBlock) {
            _areaDicBlock(self.selectProvinceDic, self.selectCityDic, self.selectAreaDic);
        }
    }
}

#pragma mark -- UIPickerView Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return self.columnCount;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
         return self.provinceArray.count;
    }else if (component == 1){
 
        return self.cityArray.count;
    }else if (component == 2){
 
        return self.areaArray.count;
    }
    return 0;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width / 3, 30)];
    label.adjustsFontSizeToFitWidth = YES;
    label.textAlignment = NSTextAlignmentCenter;
    if (component == 0) {
        label.text = self.provinceArray[row][@"province"];
    }else if (component == 1){
        label.text = self.cityArray[row][@"city"];
    }else if (component == 2){
        label.text = self.areaArray[row][@"area"];
    }
    return label;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {//选择省
        
        self.selectProvinceIndex = row;
        
        self.cityArray = self.provinceArray[row][@"city_list"];
        self.areaArray = [self.cityArray firstObject][@"area_list"];
        [self.pickerView reloadComponent:1];
        [self.pickerView selectRow:0 inComponent:1 animated:YES];
        [self.pickerView reloadComponent:2];
        [self.pickerView selectRow:0 inComponent:2 animated:YES];
        
        self.selectProvinceDic = self.provinceArray[row];
        self.selectCityDic = [self.cityArray firstObject];
        self.selectAreaDic = [self.areaArray firstObject];
        
    }else if (component == 1){//选择市
        if ([self.provinceArray[self.selectProvinceIndex][@"city_list"] count] > row) {
            self.areaArray = self.provinceArray[self.selectProvinceIndex][@"city_list"][row][@"area_list"];
        }
        [self.pickerView reloadComponent:2];
        [self.pickerView selectRow:0 inComponent:2 animated:YES];
        if (self.cityArray.count > row) {
            self.selectCityDic = self.cityArray[row];
        }
        self.selectAreaDic = [self.areaArray firstObject];
        
    }else if (component == 2){//选择区
        
        if (self.areaArray.count > row) {
            self.selectAreaDic = self.areaArray[row];
        }
        
    }
}
#pragma mark - UI
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40.0;
}

- (void)showView {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    self.backgroundColor = [UIColor clearColor];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = CZHRGBColor(0x000000, 0.3);
        self.containView.czh_bottom = ScreenHeight;
    }];
}

- (void)hideView {
    
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [UIColor clearColor];
        self.containView.czh_y = ScreenHeight;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}


- (instancetype)init {
    if (self = [super init]) {
        
        [self czh_setView];
    }
    return self;
}


- (void)czh_setView {
    
    self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    
    UIView *containView = [[UIView alloc] init];
    containView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, CZH_ScaleHeight(270));
    [self addSubview:containView];
    self.containView = containView;
    
    
    UIView *toolBar = [[UIView alloc] init];
    toolBar.frame = CGRectMake(0, 0, ScreenWidth, CZH_ScaleHeight(55));
    toolBar.backgroundColor = CZHColor(0xf6f6f6);
    [containView addSubview:toolBar];
    
    UIButton *cancleButton = [UIButton czh_buttonWithTarget:self action:@selector(buttonClick:) frame:CGRectMake(0, 0, TOOLBAR_BUTTON_WIDTH, toolBar.czh_height) titleColor:CZHColor(0x666666) titleFont:CZHGlobelNormalFont(18) title:@"取消"];
    cancleButton.tag = CZHAddressPickerViewButtonTypeCancle;
    [toolBar addSubview:cancleButton];
    
    UIButton *sureButton = [UIButton czh_buttonWithTarget:self action:@selector(buttonClick:) frame:CGRectMake(toolBar.czh_width - TOOLBAR_BUTTON_WIDTH, 0, TOOLBAR_BUTTON_WIDTH, toolBar.czh_height) titleColor:CZHThemeColor titleFont:CZHGlobelNormalFont(18) title:@"确定"];
    sureButton.tag = CZHAddressPickerViewButtonTypeSure;
    [toolBar addSubview:sureButton];
    
    
    UIPickerView *pickerView = [[UIPickerView alloc] init];
    pickerView.backgroundColor = CZHColor(0xffffff);
    pickerView.frame = CGRectMake(0, toolBar.czh_bottom, ScreenWidth, containView.czh_height - toolBar.czh_height);
    pickerView.delegate = self;
    pickerView.dataSource = self;
    [containView addSubview:pickerView];
    self.pickerView = pickerView;
    self.columnCount = 3;
}

- (NSArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSArray array];
    }
    return _dataSource;
}


- (NSArray *)provinceArray
{
    if (!_provinceArray) {
        _provinceArray = [NSArray array];
    }
    return _provinceArray;
}

- (NSArray *)cityArray
{
    if (!_cityArray) {
        _cityArray = [NSArray array];
    }
    return _cityArray;
}

- (NSArray *)areaArray
{
    if (!_areaArray) {
        _areaArray = [NSArray array];
    }
    return _areaArray;
}

@end
