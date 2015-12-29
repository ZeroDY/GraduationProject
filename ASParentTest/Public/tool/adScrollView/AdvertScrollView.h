//
//  AdvertScrollView.h
//  ASParentTest
//
//  Created by 张浩 on 15/11/18.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol adScrollViewDelegate
-(void)getNewsDataQueue:(int)page;
-(void)showTopNewsDetail:(id)sender;
@end
@interface AdvertScrollView : UIView<UIScrollViewDelegate>
// view
@property(nonatomic ,strong)UIView *topNewsView;
@property(nonatomic ,strong)UILabel *titleLab;
@property(nonatomic ,strong)UIPageControl *pageControl;
@property(nonatomic ,strong)UIScrollView *bigImgScroll;
@property(nonatomic ,strong)NSTimer *timer;

// data
@property(nonatomic,strong) NSMutableArray *topNewsArray;
@property(nonatomic,assign) BOOL lastPage;
@property(nonatomic,assign) int currentPage;
@property(nonatomic,assign) BOOL isHeader;
@property(nonatomic,assign) id<adScrollViewDelegate> adScrollViewDelegate;

@property(nonatomic ,assign) int bigImageCurrentPage;

- (void)setUpBigView;
@end
