//
//  RecommendViewController.h
//  ASParentTest
//
//  Created by 周德艺 on 15/11/17.
//  Copyright © 2015年 周德艺. All rights reserved.
//
/**
 *	推荐
 */

#import <UIKit/UIKit.h>
#import "LjjUISegmentedControl.h"

@interface RecommendViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,LjjUISegmentedControlDelegate>

@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) UIView *listTableBackView;
@property (nonatomic ,strong) UITableView *listTableView;
@property (nonatomic ,strong) UIButton *listBtn;
@property (nonatomic ,strong) NSMutableArray *listTypeArr;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic) int recommendType;
@property (nonatomic , strong) NSString *teacherType;

@property (nonatomic , assign)NSInteger bookAllPages;
@property (nonatomic , assign)NSInteger teacherAllPages;
@property (nonatomic , assign)NSInteger classAllPages;
@property (nonatomic , assign)NSInteger jsyrAllPages;


@end
