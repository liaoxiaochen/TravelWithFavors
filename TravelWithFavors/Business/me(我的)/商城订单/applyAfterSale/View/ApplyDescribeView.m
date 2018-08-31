//
//  ApplyDescribeView.m
//  TravelWithFavors
//
//  Created by MacBook on 2018/8/25.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "ApplyDescribeView.h"


@interface ApplyDescribeView()<UITextViewDelegate, PYPhotosViewDelegate>

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIView *whitBackView;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UITextView *describeTextView;
@property (nonatomic, strong) UILabel *photoLabel;

@property (nonatomic, strong) UILabel *placeHolder;
@property (nonatomic, strong) UILabel *stirngLenghLabel;


@property(nonatomic,strong)NSMutableArray *photos;

@end

@implementation ApplyDescribeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.backView];
        [self.backView addSubview:self.whitBackView];
        [self.whitBackView addSubview:self.tipLabel];
        [self.whitBackView addSubview:self.describeTextView];
        [self.describeTextView addSubview:self.placeHolder];
        [self.describeTextView addSubview:self.stirngLenghLabel];
        [self.whitBackView addSubview:self.photoLabel];
        
 
        // 1. 常见一个发布图片时的photosView
        PYPhotosView *publishPhotosView = [PYPhotosView photosView];
        publishPhotosView.py_x = 10;
        publishPhotosView.py_y = CGRectGetMaxY(self.photoLabel.frame);
        // 2.1 设置本地图片
        publishPhotosView.images = nil;
        // 3. 设置代理
        publishPhotosView.delegate = self;
        publishPhotosView.photosMaxCol = 6;//每行显示最大图片个数
        publishPhotosView.imagesMaxCountWhenWillCompose = 6;//最多选择图片的个数
        // 4. 添加photosView
        [self.whitBackView addSubview:publishPhotosView];
        self.publishPhotosView = publishPhotosView;
        
    }
    return self;
}

#pragma mark - PYPhotosViewDelegate
- (void)photosView:(PYPhotosView *)photosView didAddImageClickedWithImages:(NSMutableArray *)images{
    // 在这里做当点击添加图片按钮时，你想做的事。
    if (self.delegate && [self.delegate respondsToSelector:@selector(describeViewGetPhoto)]) {
        [self.delegate describeViewGetPhoto];
    }
 }
// 进入预览图片时调用, 可以在此获得预览控制器，实现对导航栏的自定义
- (void)photosView:(PYPhotosView *)photosView didPreviewImagesWithPreviewControlelr:(PYPhotosPreviewController *)previewControlelr{
    NSLog(@"进入预览图片");
}


- (NSMutableArray *)photos{
    if (_photos == nil) {
        _photos = [[NSMutableArray alloc]init];
        
    }
    return _photos;
}


//正在改变

- (void)textViewDidChange:(UITextView *)textView {
    self.placeHolder.hidden = YES;
    //实时显示字数
    self.stirngLenghLabel.text = [NSString stringWithFormat:@"%lu/500", (unsigned long)textView.text.length];
    
    //字数限制操作
    if (textView.text.length >= 500) {
          textView.text = [textView.text substringToIndex:500];
        self.stirngLenghLabel.text = @"500/500";
    }
    //取消按钮点击权限，并显示提示文字
    if (textView.text.length == 0) {
      self.placeHolder.hidden = NO;
    }
}

- (UILabel *)photoLabel {
    if (!_photoLabel) {
        _photoLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.describeTextView.frame), SCREEN_WIDTH, 40)];
        _photoLabel.textColor = [UIColor hdTextColor];
        _photoLabel.font = [UIFont systemFontOfSize:14];
        _photoLabel.text = @"上传凭证";
        _photoLabel.textAlignment = NSTextAlignmentLeft;
        
    }
    return _photoLabel;
}
- (UILabel *)stirngLenghLabel {
    if (!_stirngLenghLabel) {
        _stirngLenghLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.describeTextView.frame) - 100, CGRectGetHeight(self.describeTextView.frame) - 30, 90, 20)];
        _stirngLenghLabel.textColor = [UIColor hdPlaceHolderColor];
        _stirngLenghLabel.font = [UIFont systemFontOfSize:10];
        _stirngLenghLabel.text = @"0/500";
        _stirngLenghLabel.textAlignment = NSTextAlignmentRight;
        
    }
    return _stirngLenghLabel;
}
- (UILabel *)placeHolder {
    if (!_placeHolder) {
        _placeHolder = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, CGRectGetWidth(self.describeTextView.frame) - 10, 10)];
        _placeHolder.textColor = [UIColor hdPlaceHolderColor];
        _placeHolder.font = [UIFont systemFontOfSize:10];
        _placeHolder.text = @"请您再此描述问题";
        _placeHolder.textAlignment = NSTextAlignmentLeft;
        
    }
    return _placeHolder;
}
- (UITextView *)describeTextView{
    if (!_describeTextView) {
        _describeTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.tipLabel.frame), SCREEN_WIDTH - 20, 120)];
        _describeTextView.delegate = self;
        _describeTextView.font = [UIFont systemFontOfSize:14.0f];
        _describeTextView.backgroundColor = [UIColor hdTableViewBackGoundColor];
    }
    return _describeTextView;
}

- (UILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 40)];
        _tipLabel.textColor = [UIColor hdTipTextColor];
        _tipLabel.font = [UIFont systemFontOfSize:14];
        _tipLabel.text = @"问题描述";
        _tipLabel.backgroundColor = [UIColor whiteColor];
        _tipLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _tipLabel;
}
- (UIView *)whitBackView {
    if (!_whitBackView) {
        _whitBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, SELF_HEIGHT - 20)];
        _whitBackView.backgroundColor = [UIColor whiteColor];
    }
    return _whitBackView;
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SELF_HEIGHT)];
        _backView.backgroundColor = [UIColor hdTableViewBackGoundColor];
    }
    return _backView;
}

@end
