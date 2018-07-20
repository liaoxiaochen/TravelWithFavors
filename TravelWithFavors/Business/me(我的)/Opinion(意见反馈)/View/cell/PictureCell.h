//
//  PictureCell.h
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/3.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^closeBlock)(void);
@interface PictureCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *pictreImageView;
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;
@property (nonatomic, copy) closeBlock close;
@end
