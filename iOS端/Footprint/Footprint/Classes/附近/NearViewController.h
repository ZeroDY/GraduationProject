//
//  NearViewController.h
//  FootprintWall
//
//  Created by 张浩 on 15/4/15.
//  Copyright (c) 2015年 张浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserObject.h"

@interface NearViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong,nonatomic) NSMutableArray *nearWallArr;
@property (strong,nonatomic) NSMutableArray *nearAtdWallArr;
@property (strong,nonatomic) NSMutableArray *myAllWallArr;
@property (strong,nonatomic) NSMutableArray *myPublicWallArr;
@property (strong,nonatomic) NSMutableArray *myPrivateWallArr;
@property (strong,nonatomic) NSMutableArray *myAtdWallArr;
@property (strong,nonatomic) NSMutableArray *myCollectWallArr;
@property (strong,nonatomic) NSMutableArray *collectArr;
@property (strong,nonatomic) NSMutableArray *tableArr;
@property (strong,nonatomic) UserObject *user;
@property (strong,nonatomic) UIView *headerView;
@property (strong,nonatomic) UISegmentedControl *segment;

@property (nonatomic) BOOL isTable;
@property (nonatomic) BOOL isMyWall;
@property (nonatomic) BOOL isCollect;

@property (weak, nonatomic) IBOutlet UILabel *location_Label;
@property (weak, nonatomic) IBOutlet UIView *boxView;
- (IBAction)clickBtn1:(id)sender;
- (IBAction)clickBtn2:(id)sender;
- (IBAction)getLocation:(id)sender;

-(void)getMyAllCollectWallArr;

@end
