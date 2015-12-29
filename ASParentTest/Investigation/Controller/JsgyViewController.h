//
//  JsgyViewController.h
//  ASParentTest
//
//  Created by 张浩 on 15/11/20.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JsgyViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic ,strong) NSMutableArray *dataArr;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic , assign)NSInteger allPages;

@end
