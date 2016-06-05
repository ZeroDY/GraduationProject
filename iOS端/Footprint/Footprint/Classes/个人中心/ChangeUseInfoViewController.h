//
//  ChangeUseInfoViewController.h
//  Footprint
//
//  Created by 张浩 on 15/5/26.
//  Copyright (c) 2015年 周德艺. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserObject.h"

@interface ChangeUseInfoViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UserObject *user;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UITextField *infoField;
@property (nonatomic,strong) NSString *infoStr;
@property (nonatomic,strong) NSString *titleStr;
@property (nonatomic) BOOL isTrueName;
@property (nonatomic) BOOL isSex;
@property (nonatomic) BOOL isAge;
@property (nonatomic) BOOL isTel;

@property (nonatomic,strong) NSArray *sexArr;
@property(nonatomic) int index;
@end
