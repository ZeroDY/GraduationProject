//
//  IdentificationDetailViewController.m
//  ASParentTest
//
//  Created by 张浩 on 15/11/19.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "IdentificationDetailViewController.h"
#import "LeaveViewController.h"
#import "StatusView.h"
#import "FollowViewController.h"
#import "WorkPushViewController.h"
#import "TodaySubjectViewController.h"
#import "DifficultFeedBackViewController.h"
#import "StudentCommunicationViewController.h"
@interface IdentificationDetailViewController ()

@end

@implementation IdentificationDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"认证用户";
    //获得nib视图数组
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"StatusView" owner:self options:nil];
    //得到第一个UIView
    self.statusView = [nib objectAtIndex:0];
    self.statusView.center = self.view.center;
    self.statusView.delegate = self;
    self.statusView.backView.backgroundColor = MainColor;
    self.statusView.submitBtn.backgroundColor = MainColor;
    self.statusView.backgroundColor = RGB(237, 237, 237, 0.7);
    //添加视图
    [self.view addSubview:self.statusView];
    self.statusView.hidden = YES;

//颜色

    self.titleView.backgroundColor = MainColor;
//    self.titleBtnView.backgroundColor = ;
    self.leaveBtn.backgroundColor = MainColor;
    self.statusBtn.backgroundColor = MainColor;
    self.followBtn.backgroundColor = MainColor;
}
-(void)viewWillAppear:(BOOL)animated{
//加载数据
    self.nameLab.text = self.studentObj.stuname;
    self.infoLab.text = [NSString stringWithFormat:@"%@ %@",self.studentObj.schoolname,self.studentObj.classname];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)leaveClick:(id)sender {
    LeaveViewController *leaveVC = [[LeaveViewController alloc]initWithNibName:@"LeaveViewController" bundle:nil];
    leaveVC.hidesBottomBarWhenPushed = YES;
    leaveVC.stuObj = self.studentObj;
    [self.navigationController pushViewController:leaveVC animated:YES];
}

- (IBAction)statusClick:(id)sender {
    self.statusView.hidden = NO;
    self.statusView.stuStatus = self.studentObj.stutype;
    [self.statusView showStuStatus];
}

- (IBAction)followClick:(id)sender {
    FollowViewController *followVC = [[FollowViewController alloc]initWithNibName:@"FollowViewController" bundle:nil];
    followVC.hidesBottomBarWhenPushed = YES;
    followVC.stuObj = self.studentObj;
    [self.navigationController pushViewController:followVC animated:YES];
    
}
//代理方法
-(void)cancelClick{
    self.statusView.hidden = YES;
}
-(void)submitClick{
    self.statusView.hidden = YES;
}
- (IBAction)studentCommunicationClick:(id)sender {
    StudentCommunicationViewController *studentCommunicationVC = [[StudentCommunicationViewController alloc]initWithNibName:@"StudentCommunicationViewController" bundle:nil];
    [self.navigationController pushViewController:studentCommunicationVC animated:YES];
}

- (IBAction)workPushClick:(id)sender {
    WorkPushViewController *workPushVC = [[WorkPushViewController alloc]initWithNibName:@"WorkPushViewController" bundle:nil];
    workPushVC.stuObj = self.studentObj;
    [self.navigationController pushViewController:workPushVC animated:YES];
}

- (IBAction)todaySubjectClick:(id)sender {
    TodaySubjectViewController *todaySubjectVC = [[TodaySubjectViewController alloc]initWithNibName:@"TodaySubjectViewController" bundle:nil];
    [self.navigationController pushViewController:todaySubjectVC animated:YES];
}

- (IBAction)difficultFeedbackClick:(id)sender {
    DifficultFeedBackViewController *difficultFeedBackVC = [[DifficultFeedBackViewController alloc]initWithNibName:@"DifficultFeedBackViewController" bundle:nil];
    [self.navigationController pushViewController:difficultFeedBackVC animated:YES];
}
@end
