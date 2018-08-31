//
//  CityHistoryView.h
//  TravelWithFavors
//
//  Created by MacBook on 2018/7/23.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CityHistoryView;
@class CityButton;

@protocol CityHistoryViewDelegate <NSObject>

- (void)cityHistoryViewdidClickedItem:(CityButton *)item;

@end


@interface CityHistoryView : UIView


@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) id<CityHistoryViewDelegate> delegate;

@end
