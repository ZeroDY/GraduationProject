//
//  AdvertScrollView.m
//  ASParentTest
//
//  Created by 张浩 on 15/11/18.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "AdvertScrollView.h"

@implementation AdvertScrollView

@synthesize topNewsView;
@synthesize titleLab;
@synthesize pageControl;
@synthesize bigImgScroll;
@synthesize timer;
@synthesize topNewsArray;
@synthesize currentPage;
@synthesize isHeader;
@synthesize adScrollViewDelegate;
@synthesize lastPage;
@synthesize bigImageCurrentPage;

#pragma mark - 自由指定广告所占的frame
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        // Initialization code
        self.topNewsArray = [[NSMutableArray alloc] init];
        currentPage = 1;
        lastPage = NO;
        
        self.topNewsView = [[UIView alloc] initWithFrame:CGRectMake(5, 5, self.frame.size.width-10, 170-5)];
        self.topNewsView.backgroundColor = BackGroundColor;
        [self addSubview:self.topNewsView];
        
        bigImgScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.topNewsView.frame.size.width, self.topNewsView.frame.size.height)];
        bigImgScroll.delegate = self;
        bigImgScroll.pagingEnabled = YES;
        [self.topNewsView addSubview:bigImgScroll];
        
        UILabel *backGroundLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 137, self.topNewsView.frame.size.width, 28)];
        [backGroundLabel setBackgroundColor:[UIColor darkGrayColor]];
        backGroundLabel.alpha = 0.7f;
        [self.topNewsView addSubview:backGroundLabel];
        
        pageControl = [[UIPageControl alloc] init];
        pageControl.frame = CGRectMake(self.topNewsView.frame.size.width - 70, 133, 67, 37);
        [pageControl setCurrentPageIndicatorTintColor:MainColor];
        [pageControl addTarget:self action:@selector(pageTurn:) forControlEvents:UIControlEventTouchUpInside];
        [self.topNewsView addSubview:pageControl];
        
        titleLab = [[UILabel alloc] initWithFrame:CGRectMake(9, 137, pageControl.frame.origin.x - titleLab.frame.origin.x, 28)];
        titleLab.font = [UIFont systemFontOfSize:12];
        titleLab.backgroundColor = [UIColor clearColor];
        [titleLab setTextColor:[UIColor whiteColor]];
        [self.topNewsView addSubview:titleLab];
        
        //        self.topNewsView.hidden = YES;
        
    }
    return self;
}
//设置滚动Image
- (void)setUpBigView {
    @try {
        if (self.bigImgScroll.subviews) {
            for (UIView *aView in self.bigImgScroll.subviews) {
                if ([aView isKindOfClass:[UIButton class]]) {
                    [aView removeFromSuperview];
                } else if ([aView isKindOfClass:[UIImageView class]]) {
                    [aView removeFromSuperview];
                }
            }
            [self.titleLab setText:@""];
            
            if ([self.topNewsArray count] > 0) {
                self.topNewsView.hidden = NO;
                [pageControl setNumberOfPages:[self.topNewsArray count]];
                [pageControl addTarget:self action:@selector(pageTurn:) forControlEvents:UIControlEventValueChanged];
                
                for (int i = 0; i < [self.topNewsArray count]; i++) {
                    NSDictionary *topNews = self.topNewsArray[i];
                    UIButton *abtn = [[UIButton alloc] init];
                    NSLog(@"%@",[topNews objectForKey:@"picUrl"]);
                    if ([[topNews objectForKey:@"picUrl"] length] > 0) {
                        NSString *imgURL = [NSString stringWithFormat:@"%@",[topNews objectForKey:@"picUrl"]];
                        //
                        [abtn setBackgroundImage:[UIImage imageNamed:imgURL] forState:UIControlStateNormal];
                        //
//                        [abtn sd_setImageWithURL:[NSURL URLWithString:imgURL]
//                                        forState:UIControlStateNormal
//                                placeholderImage:[UIImage imageNamed:@"loading.png"]
//                                         options:SDWebImageRetryFailed];
                    } else {
                        [abtn setImage:[UIImage imageNamed:@"pic-22.png"] forState:UIControlStateNormal];
                    }
                    [abtn addTarget:self action:@selector(showDetail:) forControlEvents:UIControlEventTouchUpInside];
                    abtn.tag = i;
                    [self.bigImgScroll addSubview:abtn];
                    [abtn setFrame:CGRectMake(i*self.bigImgScroll.frame.size.width, 0, self.bigImgScroll.frame.size.width, self.bigImgScroll.frame.size.height)];
                    
//                    if ([topNews.newstype intValue] == 2) {
//                        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*self.bigImgScroll.frame.size.width, 0, 117, 111)];
//                        imageView.image = [UIImage imageNamed:@"xszj.png"];
//                        [self.bigImgScroll addSubview:imageView];
//                    }
                    
//                    if (i == 0) {
                        [self.titleLab setText:[topNews objectForKey:@"titleName"]];
//                    }
                    [self.bigImgScroll setContentSize:CGSizeMake(self.bigImgScroll.frame.size.width*[self.topNewsArray count], self.bigImgScroll.frame.size.height)];
                    [self.bigImgScroll setContentOffset:CGPointMake(0, 0)];
                }
                self.bigImageCurrentPage = 0;
                if (!self.timer.valid) {
                    self.timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(scrollToNextPage) userInfo:nil repeats:YES];
                    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
                    NSLog(@"轮播开始");
                }
            } else {
                self.topNewsView.hidden = YES;
            }
        }
    } @catch (NSException *exception) {
        NSArray * arr = [exception callStackSymbols];
        NSString * reason = [exception reason];
        NSString * name = [exception name];
        NSString * url = [NSString stringWithFormat:@"========异常错误报告========\nname:%@\nreason:\n%@\ncallStackSymbols:\n%@",name,reason,[arr componentsJoinedByString:@"\n"]];
        NSLog(@"%@",url);
        
    } @finally {
        
    }
}

- (void)showDetail:(id)sender {
    UIButton *btn = (UIButton *)sender;
    NSLog(@"点击了%ld",(long)btn.tag);
}

- (void)scrollToNextPage {
    if (bigImageCurrentPage == self.topNewsArray.count) {
        bigImageCurrentPage = 0;
    }
    [pageControl setCurrentPage:bigImageCurrentPage];
    NSDictionary *topNews = self.topNewsArray[bigImageCurrentPage];
    [self.titleLab setText:[topNews objectForKey:@"titleName"]];
    [self pageTurn:pageControl];
    bigImageCurrentPage++;
}


#pragma ScrollView delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGPoint offset = scrollView.contentOffset;
    CGRect bounds = scrollView.frame;
    int page = (int)offset.x / bounds.size.width;
    
    if ([self.topNewsArray count] > 0) {
        [pageControl setCurrentPage:offset.x / bounds.size.width];
        NSDictionary *topNews = self.topNewsArray[page];
        [self.titleLab setText:[topNews objectForKey:@"titleName"]];
        [self pageTurn:pageControl];
        bigImageCurrentPage = page + 1;
    }
}

//点击pagecontrol的点 跳到那一页的实现
- (void)pageTurn:(UIPageControl *)sender {
    CGSize viewsize=bigImgScroll.frame.size;
    CGRect rect=CGRectMake(sender.currentPage*viewsize.width, 0, viewsize.width, viewsize.height);
    if (sender.currentPage == 0) {
        [bigImgScroll scrollRectToVisible:rect animated:NO];
    } else {
        [bigImgScroll scrollRectToVisible:rect animated:YES];
    }
}

@end
