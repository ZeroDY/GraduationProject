//
//  HomeViewController.h
//  ASParentTest
//
//  Created by 周德艺 on 15/11/17.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeTableViewCell.h"
@interface HomeViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,HomeTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end
