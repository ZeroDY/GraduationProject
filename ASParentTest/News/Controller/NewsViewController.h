//
//  NewsViewController.h
//  ASParentTest
//
//  Created by 周德艺 on 15/11/17.
//  Copyright © 2015年 周德艺. All rights reserved.
//
/**
 *	新闻
 */
#import <UIKit/UIKit.h>
#import "LjjUISegmentedControl.h"
#import "AdvertScrollView.h"
@interface NewsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,LjjUISegmentedControlDelegate,adScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tablewView;

@property (nonatomic ,strong) NSArray *tempImgArr;//假图片数据
@property (nonatomic) int newsType;
@property (nonatomic) int hotNewsType;
@property (nonatomic ,strong) NSMutableArray *dataArr;

@property (nonatomic ,strong) NSMutableArray *tempNormalArr;//假普通新闻
@property (nonatomic ,strong) NSMutableArray *tempHotArr;//假热点新闻

@end
