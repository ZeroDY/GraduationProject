//
//  NearWallTableViewCell.m
//  Footprint
//
//  Created by 周德艺 on 15/5/2.
//  Copyright (c) 2015年 周德艺. All rights reserved.
//

#import "NearWallTableViewCell.h"

@implementation NearWallTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



- (IBAction)tapImage:(id)sender {
    self.bigImage = self.wallImage.image;
    if (self.bigImage != nil) {
        [self showImage:self.bigImage];
    }
    
}
//呈现图片
- (void)showImage:(UIImage *)image {
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.backView.backgroundColor = [UIColor blackColor];
    [delegate.window addSubview:self.backView];
    
    self.backScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.backScrollView.delegate = self;
    self.backScrollView.bounces = YES;
    self.backScrollView.bouncesZoom = YES;
    self.backScrollView.scrollEnabled = YES;
    self.backScrollView.minimumZoomScale = 0.5;
    self.backScrollView.maximumZoomScale = 4.0;
    [self.backScrollView setZoomScale:1];
    [UIView animateWithDuration:0.5f animations:^{
        CGPoint newPoint = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
        self.backScrollView.center = newPoint;
    }];
    [self.backView addSubview:self.backScrollView];
    
    self.bigImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.backScrollView addSubview:self.bigImageView];
    
    float imgStartWidth = image.size.width;
    float imgStartHeight = image.size.height;
    float wh = imgStartWidth/imgStartHeight;
    if (wh >= 1) {//宽图，压缩宽度
        if (imgStartWidth > SCREEN_WIDTH) {
            imgStartWidth = SCREEN_WIDTH;
            imgStartHeight = imgStartWidth/wh;
        }
        //二次判断，判断压缩宽度以后的高度
        if (imgStartHeight > SCREEN_HEIGHT) {
            imgStartHeight = SCREEN_HEIGHT;
            imgStartWidth = imgStartHeight*wh;
        }
    } else {//长图，压缩高度
        if (imgStartHeight > SCREEN_HEIGHT) {
            imgStartHeight = SCREEN_HEIGHT;
            imgStartWidth = imgStartHeight*wh;
        }
        //二次判断，判断压缩高度以后的宽度
        if (imgStartWidth > SCREEN_WIDTH) {
            imgStartWidth = SCREEN_WIDTH;
            imgStartHeight = imgStartWidth/wh;
        }
    }
    [UIView animateWithDuration:kAnimaTime animations:^{
        [self.bigImageView setImage:image];
        self.bigImageView.frame = CGRectMake((SCREEN_WIDTH-imgStartWidth)/2 , (SCREEN_HEIGHT-imgStartHeight)/2, imgStartWidth, imgStartHeight);
    } completion:^(BOOL finished) {
    }];
    
    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleViewTap:)];
    [self.backView addGestureRecognizer:singleTap];
}

//移除图片查看视图
- (void)handleSingleViewTap:(UITapGestureRecognizer *)sender {
    if (self.backView.superview != nil) {
        [self.backView removeFromSuperview];
    }
}
// 设置UIScrollView中要缩放的视图
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.bigImageView;
}

// 让UIImageView在UIScrollView缩放后居中显示
- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
    (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
    (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    self.bigImageView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                                           scrollView.contentSize.height * 0.5 + offsetY);
}

@end
