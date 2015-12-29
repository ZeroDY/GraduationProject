//
//  JsgyDetailViewController.h
//  ASParentTest
//
//  Created by 张浩 on 15/11/20.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JsgyObject.h"
#import "JsgyDetailObject.h"
@interface JsgyDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic ,strong) NSMutableArray *dataArr;
@property (nonatomic ,strong) NSDictionary *dataDic;
@property (weak, nonatomic) IBOutlet UIView *tabView;
@property (weak, nonatomic) IBOutlet UITextField *contentTextField;
@property (weak, nonatomic) IBOutlet UIButton *publishBtn;

@property (nonatomic , strong)JsgyObject *jsgyObj;
@property (nonatomic , strong)JsgyDetailObject *jsgyDetailObj;

- (IBAction)publishClick:(id)sender;
@end
