//
//  GBCollectionViewCell.m
//  DemoCollection
//
//  Created by gb on 2018/4/17.
//  Copyright © 2018年 GB. All rights reserved.
//

#import "GBCollectionViewCell.h"
#define kRZCTEditingButtonWidth       70
#define kRZCTEditStateAnimDuration    0.3
#define KactionCount 1

@interface GBCollectionViewCell () <UIGestureRecognizerDelegate>
@property (nonatomic, weak) UIPanGestureRecognizer *panGesture;

@end
@implementation GBCollectionViewCell 
- (void)awakeFromNib {
    [super awakeFromNib];
    [self configureGestures];
    [self makeCustomView];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configureGestures];
        [self makeCustomView];
    }
    return self;
}
- (void)configureGestures
{
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self.contentView addGestureRecognizer:panGesture];
    panGesture.delegate = self;
    panGesture.enabled  = YES;
    
    self.panGesture     = panGesture;
}

- (void)makeCustomView {
    _deleteCellBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    _deleteCellBtn.frame = CGRectMake(SCREEN_WIDTH-kRZCTEditingButtonWidth, 0, kRZCTEditingButtonWidth,90);
    _deleteCellBtn.backgroundColor = [UIColor redColor];
    [_deleteCellBtn setTitle:@"删除" forState:UIControlStateNormal];
    [_deleteCellBtn setTintColor:[UIColor whiteColor]];
    _deleteCellBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.contentView.superview insertSubview:_deleteCellBtn belowSubview:self.contentView];
}

#pragma mark - Pan Gesture handlers
- (void)handlePan:(UIPanGestureRecognizer *)panGesture
{
    static CGFloat initialTranslationX = 0;
    
    CGPoint           translation      = [panGesture translationInView:self];
    CGAffineTransform currentTransform =  self.contentView.transform;
    CGFloat           maxTransX        = -kRZCTEditingButtonWidth * KactionCount;
    
    switch ( panGesture.state ) {
        case UIGestureRecognizerStateBegan:
            
            initialTranslationX = currentTransform.tx;
            
        case UIGestureRecognizerStateChanged: {
            CGFloat targetTranslationX = initialTranslationX + translation.x;
            targetTranslationX = MIN(0, targetTranslationX); // must be negative (left)
            
            if ( targetTranslationX < maxTransX ) {
                CGFloat overshoot = maxTransX - targetTranslationX;
                targetTranslationX = maxTransX - overshoot * 0.3333;
            }
            
            self.contentView.transform = CGAffineTransformMakeTranslation(targetTranslationX, 0);
        }
            break;
            
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateFailed:
        case UIGestureRecognizerStateCancelled: {
            if ( currentTransform.tx < maxTransX ) {
                [self setEditing:YES animated:YES];
            }
            else {
                [self setEditing:NO animated:YES];
            }
        }
            break;
        default:
            break;
    }
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    _isEditing = editing;
    
    self.contentView.userInteractionEnabled = !editing;
    
    CGFloat stopTarget = editing ? ( -kRZCTEditingButtonWidth * KactionCount ) : 0;
    if ( animated ) {
        [UIView animateWithDuration:kRZCTEditStateAnimDuration
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             self.contentView.transform = CGAffineTransformMakeTranslation(stopTarget, 0);
                             NSLog(@"%@",NSStringFromCGRect(self.contentView.frame));
                             
                         } completion:nil];
    }
    else {
        self.contentView.transform = CGAffineTransformMakeTranslation(stopTarget, 0);
    }
    [self.collectionView editingStateChangedForCell:self];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    BOOL shouldBegin = NO;
    if (gestureRecognizer == self.panGesture ) {
        UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)gestureRecognizer;
        CGPoint                vel  = [pan velocityInView:self];
        if ( fabs(vel.x) > fabs(vel.y) ) {
            shouldBegin = YES;
        }
    }
    else if ( [super respondsToSelector:@selector(gestureRecognizerShouldBegin:)] ) {
        shouldBegin = [super gestureRecognizerShouldBegin:gestureRecognizer];

    }
    return shouldBegin;
}

//不加这个方法 contentView 侧滑会有问题
//- (void)layoutSubviews {
//
//
//}
@end
