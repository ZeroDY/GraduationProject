//
//  StudentCommunicationViewController.m
//  ASParentTest
//
//  Created by 张浩 on 15/11/22.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "StudentCommunicationViewController.h"
#import "StudentCommunicationLeftTableViewCell.h"
#import "StudentCommunicationRightTableViewCell.h"
#import "AddStudentCommunicationView.h"
//临时用
#import "QzbsViewController.h"
@interface StudentCommunicationViewController ()

@end

@implementation StudentCommunicationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"同窗交流";
    UIButton* rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,60,30)];
    [rightButton setTitle:@"添加" forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize: 14];
    [rightButton addTarget:self action:@selector(presentRightVC) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem= rightItem;
    
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.backgroundColor = BackGroundColor;
    
    //获得nib视图数组
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"AddStudentCommunicationView" owner:self options:nil];
    //得到第一个UIView
    self.addCommunicationView = [nib objectAtIndex:0];
    self.addCommunicationView.center = self.view.center;
    self.addCommunicationView.delegate = self;
    //添加视图
    [self.view addSubview:self.addCommunicationView];
    self.addCommunicationView.hidden = YES;
    
}
-(void)viewWillAppear:(BOOL)animated{
    
    self.dataArr = [[NSMutableArray alloc]init];
    self.dataArr = [[NSMutableArray alloc]initWithObjects:@"一寸光阴一寸金，寸金难买寸光阴",@"志不强者智不达，言不信者行不果",@"诚实是人生的命脉，是一切代价的根基",@"欺人只能一时，而诚实确实长久之事", nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //1.加载xib
    static NSString *CellIdentifier1 = @"StudentCommunicationLeftTableViewCell";
    static NSString *CellIdentifier2 = @"StudentCommunicationRightTableViewCell";
    
    if (indexPath.row % 2 == 0) {
        StudentCommunicationLeftTableViewCell *cell = (StudentCommunicationLeftTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
        
        if (cell == nil) {
            NSBundle *bundle = [NSBundle mainBundle];
            NSArray *nibArray = [bundle loadNibNamed:CellIdentifier1 owner:self options:nil];
            cell = (StudentCommunicationLeftTableViewCell *)[nibArray objectAtIndex:0];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        cell.pointImg.layer.masksToBounds = YES;
        cell.pointImg.layer.cornerRadius = cell.pointImg.frame.size.height/2;
        
        cell.titleBackView.layer.masksToBounds = YES;
        cell.titleBackView.layer.cornerRadius = cell.titleBackView.frame.size.height/2;
        
        cell.titleImg.layer.masksToBounds = YES;
        cell.titleImg.layer.cornerRadius = cell.titleImg.frame.size.height/2;
        
        cell.titleBackView.backgroundColor = BackGroundColor;
        cell.titleLab.textColor = [UIColor darkGrayColor];
        
        cell.titleLab.text = [self.dataArr objectAtIndex:indexPath.row];
        return cell;
    }else{
        StudentCommunicationRightTableViewCell *cell = (StudentCommunicationRightTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
        
        if (cell == nil) {
            NSBundle *bundle = [NSBundle mainBundle];
            NSArray *nibArray = [bundle loadNibNamed:CellIdentifier2 owner:self options:nil];
            cell = (StudentCommunicationRightTableViewCell *)[nibArray objectAtIndex:0];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        cell.pointImg.layer.masksToBounds = YES;
        cell.pointImg.layer.cornerRadius = cell.pointImg.frame.size.height/2;
        
        cell.titleBackView.layer.masksToBounds = YES;
        cell.titleBackView.layer.cornerRadius = cell.titleBackView.frame.size.height/2;
        
        cell.titleImg.layer.masksToBounds = YES;
        cell.titleImg.layer.cornerRadius = cell.titleImg.frame.size.height/2;
        
        cell.titleBackView.backgroundColor = MainColor;
        cell.titleLab.textColor = [UIColor whiteColor];
        
        cell.titleLab.text = [self.dataArr objectAtIndex:indexPath.row];
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    QzbsViewController *qzbsVC = [[QzbsViewController alloc]initWithNibName:@"QzbsViewController" bundle:nil];
    qzbsVC.title = @"同窗交流";
    [self.navigationController pushViewController:qzbsVC animated:YES];
}
-(void)presentRightVC{
    self.addCommunicationView.hidden = NO;
}
//代理方法
-(void)cancelClick{
    self.addCommunicationView.hidden = YES;
}
-(void)submitClick{
    self.addCommunicationView.hidden = YES;
}
@end
