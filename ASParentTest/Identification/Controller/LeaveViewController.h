//
//  LeaveViewController.h
//  ASParentTest
//
//  Created by 张浩 on 15/11/21.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StudentObject.h"
@interface LeaveViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic , strong) NSMutableArray *dataArr;
@property (nonatomic , strong) StudentObject *stuObj;

@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic , assign)NSInteger allPages;

@end
