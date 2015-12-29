//
//  WorkPushDetailViewController.m
//  ASParentTest
//
//  Created by 张浩 on 15/11/29.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "WorkPushDetailViewController.h"
#import "HomeWorkPointAlertViewController.h"
#import "HomeWorkOnlineViewController.h"
@interface WorkPushDetailViewController ()

@end

@implementation WorkPushDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"作业详情";
    
    self.view.backgroundColor = BackGroundColor;
    
    //一个点击事件
    self.pointAlertView.userInteractionEnabled = YES;
    UITapGestureRecognizer *click = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showPointAlertView:)];
    [self.pointAlertView addGestureRecognizer:click];

    
}
-(void)viewWillAppear:(BOOL)animated{
}
//重点难点详情
- (IBAction)showPointAlertView:(id)sender {
    HomeWorkPointAlertViewController *homeWorkPointAlertVC = [[HomeWorkPointAlertViewController alloc]initWithNibName:@"HomeWorkPointAlertViewController" bundle:nil];
    [self.navigationController pushViewController:homeWorkPointAlertVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)onlineClick:(id)sender {
    HomeWorkOnlineViewController *homeWorkOnlineVC = [[HomeWorkOnlineViewController alloc]initWithNibName:@"HomeWorkOnlineViewController" bundle:nil];
    [self.navigationController pushViewController:homeWorkOnlineVC animated:YES];

}
@end
