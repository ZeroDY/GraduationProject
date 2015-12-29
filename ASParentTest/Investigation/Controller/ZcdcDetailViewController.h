//
//  ZcdcDetailViewController.h
//  ASParentTest
//
//  Created by 张浩 on 15/11/20.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZcdcObject.h"
#import "ZcdcDetailTableViewCell.h"
@interface ZcdcDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,ZcdcDetailTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet UIView *titleBackView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *bottomBackView;

@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *infoLab;

@property (weak, nonatomic) IBOutlet UIButton *lastQuestionBtn;
@property (weak, nonatomic) IBOutlet UIButton *nextQuestionBtn;


@property (nonatomic , strong) ZcdcObject *zcdcObj;
@property (nonatomic , strong) NSMutableArray *dataArr;
@property (nonatomic , assign) int questionIndex;
@property (nonatomic , strong) NSMutableArray *resultArr;//提交的结果数组
- (IBAction)lastQuestionClick:(id)sender;
- (IBAction)nextQuestionClick:(id)sender;
@end
