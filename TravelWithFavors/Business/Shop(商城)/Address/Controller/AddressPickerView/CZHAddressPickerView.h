//
//  CZHAddressPickerView.h
//  CZHAddressPickerView
//
//  Created by 程召华 on 2017/11/24.
//  Copyright © 2017年 程召华. All rights reserved.
//



#import <UIKit/UIKit.h>

@interface CZHAddressPickerView : UIView

/**
 * 显示省份和市级和区域
 * province,city : 传入了省份和城市和区域自动滚动到选中的，没有传或者找不到默认选中第一个
 * areaBlock : 回调省份城市和区域
 */

+ (instancetype)areaPickerViewWithProvinceDic:(NSDictionary *)provinceDic cityDic:(NSDictionary *)cityDic areaDic:(NSDictionary *)areaDic areaDicBlock:(void(^)(NSDictionary *provinceDic, NSDictionary *cityDic, NSDictionary *areaDic))areaDicBlock;

@end
