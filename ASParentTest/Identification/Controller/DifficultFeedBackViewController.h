//
//  DifficultFeedBackViewController.h
//  ASParentTest
//
//  Created by 张浩 on 15/11/21.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DifficultFeedBackViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic ,strong)NSMutableArray *dataArr;
@end
