//
//  FlightSearchLayout.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/6.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "FlightSearchLayout.h"

@implementation FlightSearchLayout
//布局的细节处理
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{
    //获取当前偏移量
    CGPoint targetProposed = [super targetContentOffsetForProposedContentOffset:proposedContentOffset withScrollingVelocity:velocity];
    //获取当前范围内显示的cell
    NSArray *attributeArray = [super layoutAttributesForElementsInRect:CGRectMake(targetProposed.x, 0, self.collectionView.bounds.size.width, MAXFLOAT)];
//    //寻找距离中心点最近的图片
    CGFloat minDis = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attr in attributeArray) {
        CGFloat disWithCenter = (attr.center.x - targetProposed.x) -
        self.collectionView.bounds.size.width * 0.5;

        if(fabs(disWithCenter) < fabs(minDis)){
            minDis = disWithCenter;
        }
    }
    //停止滚动后可能没有图片在中间，所以我们要计算距离中间最近的图片，然后偏移过去
    targetProposed.x += minDis;
    if(targetProposed.x < 0){
        targetProposed.x = 0;
    }
    
    
    
    return targetProposed;
}
@end
