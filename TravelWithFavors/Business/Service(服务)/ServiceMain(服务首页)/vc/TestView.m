//
//  TestView.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/9.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "TestView.h"

@implementation TestView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        UIView *bgView = [[UIView alloc] initWithFrame:self.tableView.bounds];
        
        self.textView = [[UITextField alloc] initWithFrame:CGRectMake(0, bgView.bounds.size.height - 30, self.tableView.bounds.size.width, 30)];
        self.textView.text = @"111";
        [bgView addSubview:self.textView];
        self.tableView.tableHeaderView = bgView;
        [self addSubview:self.tableView];
    }
    return self;
}

@end
