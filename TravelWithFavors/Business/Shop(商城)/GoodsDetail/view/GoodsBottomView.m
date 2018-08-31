//
//  GoodsBottomView.m
//  TravelWithFavors
//
//  Created by MacBook on 2018/8/16.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "GoodsBottomView.h"

@interface GoodsBottomView()

@property (nonatomic, weak) UIView *serviceView;
@property (nonatomic, weak) UIView *carView;
@property (nonatomic, weak) UIButton *shopBtn;
@property (nonatomic, weak) UIButton *carBtn;
@property (nonatomic, weak) UIButton *joinBtn;
@property (nonatomic, weak) UIButton *buyBtn;
@property (nonatomic, weak) UIImageView *lineView;
@end

@implementation GoodsBottomView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

- (void)initView {
    
    UIView *serviceView = [[UIView alloc] init];
    serviceView.backgroundColor = [UIColor whiteColor]; // 背景颜色
    [self addSubview:serviceView];
    self.serviceView = serviceView;
    
    UIButton *shopBtn = [[UIButton alloc] init];
//    shopBtn.tag = 0;
    shopBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    [shopBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [shopBtn setTitle:@"店铺" forState:UIControlStateNormal];
    shopBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    shopBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [shopBtn setImage:[UIImage imageNamed:@"sc_dptb"] forState:UIControlStateNormal];
    [shopBtn addTarget:self action:@selector(bottomBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [serviceView addSubview:shopBtn];
    self.shopBtn = shopBtn;
    
    UIView *carView = [[UIView alloc] init];
    carView.backgroundColor = [UIColor whiteColor]; // 背景颜色
    [self addSubview:carView];
    self.carView = carView;
    
    UIButton *carBtn = [[UIButton alloc] init];
    carBtn.tag = 0;
    carBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    [carBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [carBtn setTitle:@"购物车" forState:UIControlStateNormal];
    carBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    carBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [carBtn setImage:[UIImage imageNamed:@"sc_gwctb_black"] forState:UIControlStateNormal];
    [carBtn addTarget:self action:@selector (bottomBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [carView addSubview:carBtn];
    self.carBtn = carBtn;
    
    UIButton *joinBtn = [[UIButton alloc] init];
    joinBtn.tag = 1;
    joinBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    joinBtn.backgroundColor = [UIColor colorWithHexString:@"#ff900d"];
    [joinBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [joinBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
    [joinBtn addTarget:self action:@selector(bottomBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:joinBtn];
    self.joinBtn = joinBtn;
    
    UIButton *buyBtn = [[UIButton alloc] init];
    buyBtn.tag = 2;
    buyBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    buyBtn.backgroundColor = [UIColor hdRedColor];
    [buyBtn setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [buyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    [buyBtn addTarget:self action:@selector(bottomBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:buyBtn];
    self.buyBtn = buyBtn;
    
    UIImageView *lineView = [[UIImageView alloc] init];
    lineView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    [self addSubview:lineView];
    self.lineView = lineView;
}

- (void)bottomBtnClick:(UIButton *)btn {
    
    if (self.bottomBlock) {
        self.bottomBlock(self, btn.tag);
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.serviceView.size = CGSizeMake(self.width * 0.2, self.height);
//    self.serviceView.x = 0;
    
    self.carView.size = self.serviceView.size;
    self.carView.x = 0;
    
    self.joinBtn.size = CGSizeMake(self.width * 0.4, self.height);
    self.joinBtn.x = self.width * 0.2;
    
    self.buyBtn.size = CGSizeMake(self.width * 0.4, self.height);
    self.buyBtn.x = self.width * 0.6;
    
    [self.shopBtn sizeToFit];
    //获取imageView中的宽度和高度
    CGFloat imageW = self.shopBtn.imageView.width;
    CGFloat imageH = self.shopBtn.imageView.height;
    //获取titleLabel的宽度
    CGFloat labelW = self.shopBtn.titleLabel.width;
    CGFloat labelH = self.shopBtn.titleLabel.height;
    //计算移动距离
    CGFloat imageDistance = (self.shopBtn.width - imageW) * 0.5;
    //设置上内距
    CGFloat imageTop = (self.shopBtn.height - imageH - labelH) * 0.5;
    //进行移动
    self.shopBtn.imageEdgeInsets = UIEdgeInsetsMake(imageTop, imageDistance, 0, 0);
    
    //计算移动距离
    CGFloat labelDistance = - imageW + (self.shopBtn.width - labelW) *0.5;
    //上内距
    CGFloat labelTop = imageTop + imageH;
    self.shopBtn.titleEdgeInsets = UIEdgeInsetsMake(labelTop + 2.f, labelDistance, 0, 0);
    
    self.shopBtn.centerY = self.height * 0.5;
    self.shopBtn.centerX = self.serviceView.width * 0.5;
    
    [self.carBtn sizeToFit];
    {
        //获取imageView中的宽度和高度
        CGFloat imageW = self.carBtn.imageView.width;
        CGFloat imageH = self.carBtn.imageView.height;
        //获取titleLabel的宽度
        CGFloat labelW = self.carBtn.titleLabel.width;
        CGFloat labelH = self.carBtn.titleLabel.height;
        //计算移动距离
        CGFloat imageDistance = (self.carBtn.width - imageW) * 0.5;
        //设置上内距
        CGFloat imageTop = (self.carBtn.height - imageH - labelH) * 0.5;
        //进行移动
        self.carBtn.imageEdgeInsets = UIEdgeInsetsMake(imageTop, imageDistance, 0, 0);
        
        //计算移动距离
        CGFloat labelDistance = - imageW + (self.carBtn.width - labelW) *0.5;
        //上内距
        CGFloat labelTop = imageTop + imageH;
        self.carBtn.titleEdgeInsets = UIEdgeInsetsMake(labelTop + 2.f, labelDistance, 0, 0);
        
        self.carBtn.centerY = self.height * 0.5;
        self.carBtn.centerX = self.carView.width * 0.5;
    }
    
    self.lineView.frame = CGRectMake(0, -0.5, self.width, 0.5);
    
    
}
//- (void)layoutSubviews {
//    [super layoutSubviews];
//    
//    self.serviceView.size = CGSizeMake(self.width * 0.2, self.height);
//    self.serviceView.x = 0;
//    
//    self.carView.size = self.serviceView.size;
//    self.carView.x = self.width * 0.2;
//    
//    self.joinBtn.size = CGSizeMake(self.width * 0.3, self.height);
//    self.joinBtn.x = self.width * 0.4;
//    
//    self.buyBtn.size = CGSizeMake(self.width * 0.3, self.height);
//    self.buyBtn.x = self.width * 0.7;
//    
//    [self.shopBtn sizeToFit];
//    //获取imageView中的宽度和高度
//    CGFloat imageW = self.shopBtn.imageView.width;
//    CGFloat imageH = self.shopBtn.imageView.height;
//    //获取titleLabel的宽度
//    CGFloat labelW = self.shopBtn.titleLabel.width;
//    CGFloat labelH = self.shopBtn.titleLabel.height;
//    //计算移动距离
//    CGFloat imageDistance = (self.shopBtn.width - imageW) * 0.5;
//    //设置上内距
//    CGFloat imageTop = (self.shopBtn.height - imageH - labelH) * 0.5;
//    //进行移动
//    self.shopBtn.imageEdgeInsets = UIEdgeInsetsMake(imageTop, imageDistance, 0, 0);
//    
//    //计算移动距离
//    CGFloat labelDistance = - imageW + (self.shopBtn.width - labelW) *0.5;
//    //上内距
//    CGFloat labelTop = imageTop + imageH;
//    self.shopBtn.titleEdgeInsets = UIEdgeInsetsMake(labelTop + 2.f, labelDistance, 0, 0);
//    
//    self.shopBtn.centerY = self.height * 0.5;
//    self.shopBtn.centerX = self.serviceView.width * 0.5;
//    
//    [self.carBtn sizeToFit];
//    {
//        //获取imageView中的宽度和高度
//        CGFloat imageW = self.carBtn.imageView.width;
//        CGFloat imageH = self.carBtn.imageView.height;
//        //获取titleLabel的宽度
//        CGFloat labelW = self.carBtn.titleLabel.width;
//        CGFloat labelH = self.carBtn.titleLabel.height;
//        //计算移动距离
//        CGFloat imageDistance = (self.carBtn.width - imageW) * 0.5;
//        //设置上内距
//        CGFloat imageTop = (self.carBtn.height - imageH - labelH) * 0.5;
//        //进行移动
//        self.carBtn.imageEdgeInsets = UIEdgeInsetsMake(imageTop, imageDistance, 0, 0);
//        
//        //计算移动距离
//        CGFloat labelDistance = - imageW + (self.carBtn.width - labelW) *0.5;
//        //上内距
//        CGFloat labelTop = imageTop + imageH;
//        self.carBtn.titleEdgeInsets = UIEdgeInsetsMake(labelTop + 2.f, labelDistance, 0, 0);
//        
//        self.carBtn.centerY = self.height * 0.5;
//        self.carBtn.centerX = self.carView.width * 0.5;
//    }
//    
//    self.lineView.frame = CGRectMake(0, -0.5, self.width, 0.5);
//    
//    
//}

@end
