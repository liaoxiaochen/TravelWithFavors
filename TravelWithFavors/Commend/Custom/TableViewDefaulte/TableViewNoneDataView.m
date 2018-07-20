//
//  TableViewNoneDataView.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/8.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "TableViewNoneDataView.h"

@implementation TableViewNoneDataView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.titileLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 75, frame.size.width - 20, 16)];
        self.titileLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        self.titileLabel.text = @"您还未添加任何信息";
        self.titileLabel.font = [UIFont systemFontOfSize:14.0f];
        self.titileLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.titileLabel];
    }
    return self;
}

@end
