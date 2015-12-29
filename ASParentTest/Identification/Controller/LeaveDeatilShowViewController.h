//
//  LeaveDeatilShowViewController.h
//  ASParentTest
//
//  Created by 张浩 on 15/11/29.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeaveObject.h"
@interface LeaveDeatilShowViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic , strong)LeaveObject *leaveObj;
@end
