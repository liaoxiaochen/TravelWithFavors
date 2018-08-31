//
//  CityButton.m
//  ChinaCityList
//
//  Created by zjq on 15/10/27.
//  Copyright © 2015年 zhengjq. All rights reserved.
//

#import "CityButton.h"
#define IsNilOrNull(_ref) (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]))
#define kCityItemViewTitleTextW 80
#define kCityItemViewTitleTextH 25
#define kCityItemViewTitleTextFont 15
@interface CityButton ()

@property (nonatomic, weak) UIView *container;
@property (nonatomic, weak) UILabel *titleName;
@property (nonatomic, weak) UIImageView *leftImg;

@end

@implementation CityButton

- (id)init
{
    if (self = [super init]) {
        // Custom initialization
        self.backgroundColor     = [UIColor whiteColor];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius  = 5;
        self.layer.borderColor   = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1].CGColor;
        self.layer.borderWidth   = 1;
        
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    
    UIView *container = [[UIView alloc] init];
    container.userInteractionEnabled = NO;
    container.backgroundColor = [UIColor clearColor];
    [self addSubview:container];
    self.container = container;
    
    UILabel *titleName = [[UILabel alloc] init];
    titleName.font = [UIFont systemFontOfSize:kCityItemViewTitleTextFont];
    titleName.textColor = [UIColor grayColor];
    titleName.textAlignment = NSTextAlignmentCenter;
    titleName.backgroundColor = [UIColor clearColor];
    titleName.numberOfLines = 1;
    [container addSubview:titleName];
    self.titleName = titleName;

    UIImageView *leftImg = [[UIImageView alloc] init];
    leftImg.image = [UIImage imageNamed:@"buytickets_dingwei"];
    [container addSubview:leftImg];
    self.leftImg = leftImg;
    
}



- (void)layoutSubviews {
    
    [super layoutSubviews];

    self.container.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    if (self.isLocation) {
        self.leftImg.frame = CGRectMake(7, 7, 14, 16);
        self.titleName.frame = CGRectMake(10, 0, self.container.frame.size.width - 10, self.container.frame.size.height);

    }else {
        self.leftImg.frame = CGRectZero;
        self.titleName.frame = CGRectMake(0, 0, self.container.frame.size.width, self.container.frame.size.height);

    }
}

- (void)setCityItem:(CityItem *)cityItem
{
    _cityItem = cityItem;
    if (!IsNilOrNull(_cityItem)) {
        self.titleName.text = _cityItem.titleName;
 
    }
}

@end
