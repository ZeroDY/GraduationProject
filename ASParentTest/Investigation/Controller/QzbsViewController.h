//
//  QzbsViewController.h
//  ASParentTest
//
//  Created by 张浩 on 15/11/20.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QzbsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *tabView;
@property (weak, nonatomic) IBOutlet UITextField *contentTextField;
@property (weak, nonatomic) IBOutlet UIButton *publishBtn;

@property (nonatomic ,strong)NSMutableArray *dataArr;

@property (nonatomic , strong) NSMutableArray *qzbsTempArr;//假数据
@property (nonatomic , strong) NSMutableArray *qzbsShowArr;//假数据

- (IBAction)publishClick:(id)sender;
@end
