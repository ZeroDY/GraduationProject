//
//  MyIdentificationStudentViewController.h
//  ASParentTest
//
//  Created by 张浩 on 15/11/25.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyIdentificationStudentViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic ,strong) NSMutableArray *dataArr;
@end
