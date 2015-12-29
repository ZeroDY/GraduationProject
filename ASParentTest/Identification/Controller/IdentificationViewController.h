//
//  IdentificationViewController.h
//  ASParentTest
//
//  Created by 周德艺 on 15/11/17.
//  Copyright © 2015年 周德艺. All rights reserved.
//
/**
 *	认证用户
 */

#import <UIKit/UIKit.h>
#import "IdentificationTableViewCell.h"
#import "StatusView.h"

@interface IdentificationViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,IdentificationTableViewCellDelegate,StatusViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic ,strong) StatusView *statusView;

@property (nonatomic ,strong) NSMutableArray *dataArr;
@end
