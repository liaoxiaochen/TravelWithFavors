//
//  HRSelectView.h
//  TravelWithFavors
//
//  Created by cushiro on 2018/4/24.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HRSelectViewDelegate <NSObject>
- (void)didSelected:(NSInteger)index;
@end
@interface HRSelectView : UIView
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, weak) id <HRSelectViewDelegate> delegate;
@property (nonatomic, assign) NSInteger selectedRow;
+(instancetype)initFromNib:(CGRect)frame;
@end
