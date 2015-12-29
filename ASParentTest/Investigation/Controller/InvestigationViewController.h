//
//  InvestigationViewController.h
//  ASParentTest
//
//  Created by 周德艺 on 15/11/17.
//  Copyright © 2015年 周德艺. All rights reserved.
//
/**
 *	调查征询
 */

#import <UIKit/UIKit.h>

@interface InvestigationViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *btnView;
@property (weak, nonatomic) IBOutlet UIButton *zcdcBtn;//政策调查
@property (weak, nonatomic) IBOutlet UIButton *jyxcBtn;//建言献策
@property (weak, nonatomic) IBOutlet UIButton *jsgyBtn;//集思广益
@property (weak, nonatomic) IBOutlet UIButton *qzbsBtn;//七嘴八舌

@property (weak, nonatomic) IBOutlet UITableView *tableView;


- (IBAction)zcdcClick:(id)sender;
- (IBAction)jyxcClick:(id)sender;
- (IBAction)jsgyClick:(id)sender;
- (IBAction)qzbsClick:(id)sender;

@property (nonatomic) int headType;
@property (nonatomic , strong) NSMutableArray *zcdcArr;
@property (nonatomic , strong) NSMutableArray *jsgyArr;

@end
