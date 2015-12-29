//
//  StudentCommunicationViewController.h
//  ASParentTest
//
//  Created by 张浩 on 15/11/22.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddStudentCommunicationView.h"
@interface StudentCommunicationViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,AddStudentCommunicationViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic ,strong)AddStudentCommunicationView *addCommunicationView;
@property (nonatomic ,strong) NSMutableArray *dataArr;
@end
