//
//  CYPopTableView.m
//  YI
//
//  Created by Lanan on 2018/7/9.
//  Copyright © 2018年 Lanan. All rights reserved.
//

#import "CYPopTableView.h"
#import "UIView+CYExtension.h"
#import "CYPopTableViewCell.h"

#define CYWINDOW [[[UIApplication sharedApplication] delegate] window]
#define kCYScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kCYScreenHight  [UIScreen mainScreen].bounds.size.height
/// 弱引用
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

@interface CYPopTableView ()<UITableViewDelegate,UITableViewDataSource>


@property(nonatomic, strong) NSArray<CYPopTableViewModel *> * arry;
@property(nonatomic, strong) UIView * backView;
@property(nonatomic, strong) UIView * showView;
@property(nonatomic, strong) UITableView * tableView;

@property(nonatomic, assign) CGRect frame;
@property(nonatomic, assign) CGRect popFrame;

@end

@implementation CYPopTableView

+ (instancetype)initWithFrame:(CGRect)frame dependView:(UIView *)view textArr:(NSArray *)textArr block:(SendStrBlock)block {
    CYPopTableView * popView = [[CYPopTableView alloc] initWithFrame:frame];
    popView.arry = textArr;
    popView.sendStrBlock = block;
    CGRect rect = [view convertRect:view.bounds toView:CYWINDOW];
    [popView frame:frame popUpFrame:rect];
    return popView;
}

- (void)frame:(CGRect)frame popUpFrame:(CGRect)popFrame {
    _frame = frame;
    _popFrame = frame;
    
    self.backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kCYScreenWidth, kCYScreenHight)];
    self.backView.backgroundColor = [UIColor clearColor];
    [CYWINDOW addSubview:self.backView];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self.backView addGestureRecognizer:tap];
    
    self.showView = [[UIView alloc] init];
    self.showView.backgroundColor = [UIColor whiteColor];
    self.showView.layer.shadowOpacity = 0.5;
    self.showView.layer.shadowColor = [UIColor grayColor].CGColor;
    self.showView.layer.shadowRadius = 2;
    self.showView.layer.shadowOffset = CGSizeMake(1, 1);
    
    [CYWINDOW addSubview:self.showView];
    
    UITableView * popTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.showView.width, self.showView.height) style:UITableViewStylePlain];
    [popTable registerClass:[CYPopTableViewCell class] forCellReuseIdentifier:@"CYPopTableViewCell"];
    popTable.delegate = self;
    popTable.dataSource = self;
    popTable.tableFooterView = [[UIView alloc] init];
    self.tableView = popTable;
    [self.showView addSubview:popTable];
    
    if (popFrame.origin.y + frame.size.height <= CYWINDOW.height - 30) {
        self.showView.frame = CGRectMake(popFrame.origin.x, popFrame.origin.y + popFrame.size.height , frame.size.width , 0);
    } else if (popFrame.origin.y + frame.size.height > CYWINDOW.height - 30) {
        self.showView.frame = CGRectMake(popFrame.origin.x , popFrame.origin.y - frame.size.height, frame.size.width , 0);
    }
    self.tableView.frame = CGRectMake(0, 0, self.showView.width, 0);
    
    
    [UIView animateWithDuration: 0.25 animations:^{
        if (popFrame.origin.y + frame.size.height <= CYWINDOW.height - 30) {
            
            self.showView.frame = CGRectMake(popFrame.origin.x, popFrame.origin.y + popFrame.size.height , frame.size.width , frame.size.height);
            
        } else if (popFrame.origin.y + frame.size.height > CYWINDOW.height - 30) {
            
            self.showView.frame = CGRectMake(popFrame.origin.x , popFrame.origin.y - frame.size.height, frame.size.width , frame.size.height);
            
        }
        self.tableView.frame = CGRectMake(0, 0, self.showView.width, self.showView.height);
        self.showView.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)tap:(UITapGestureRecognizer *)tap {
    
    WS(ws)
    [UIView animateWithDuration:0.25 animations:^{
        ws.showView.frame = CGRectMake(ws.showView.frame.origin.x, ws.showView.frame.origin.y, ws.showView.frame.size.width, 0);
        ws.tableView.frame = CGRectMake(0, 0, ws.showView.width, 0);
    } completion:^(BOOL finished) {
        
        
        [ws.backView removeFromSuperview];
        [ws.showView removeFromSuperview];
        [ws removeFromSuperview];
        
        [ws.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }];
}



#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"CYPopTableViewCell";
    CYPopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.model = self.arry[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CGRectGetHeight(tableView.frame) / self.arry.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.sendStrBlock) {
        self.sendStrBlock(self.arry[indexPath.row], indexPath.row);
    }
    for (CYPopTableViewModel *model in self.arry) {
        model.isSelected = NO;
    }
    self.arry[indexPath.row].isSelected = YES;
    
    [self tap:nil];
}

@end



@implementation CYPopTableViewModel

+ (CYPopTableViewModel *)initCYPopTableViewModelWithAttrButedString:(NSAttributedString *)attrButedString rightIcon:(UIImage *)rightIcon isSelect:(BOOL)isSelect {
    CYPopTableViewModel *model = [CYPopTableViewModel new];
    model.attrButedString = attrButedString;
    model.isSelected = isSelect;
    model.rightIcon = rightIcon;
    return model;
}


@end
