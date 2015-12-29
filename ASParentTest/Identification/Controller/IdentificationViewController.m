//
//  IdentificationViewController.m
//  ASParentTest
//
//  Created by 周德艺 on 15/11/17.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "IdentificationViewController.h"
#import "IdentificationTableViewCell.h"
#import "IdentificationDetailViewController.h"
#import "LeaveViewController.h"
#import "FollowViewController.h"
#import "TeacherViewController.h"
#import "LoginViewController.h"
#import "StudentObject.h"
#import "LeaveDeatilShowViewController.h"
//接口
#import "DYRequestBase+SearchBindStudentsRequest.h"

@interface IdentificationViewController ()

@end

@implementation IdentificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"认证用户";
    
    //    UIButton* rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,30,30)];
    //    [rightButton setImage:[UIImage imageNamed:@"add_white.png"] forState:UIControlStateNormal];
    //    rightButton.titleLabel.font = [UIFont systemFontOfSize: 14];
    //    [rightButton addTarget:self action:@selector(presentRightVC) forControlEvents:UIControlEventTouchUpInside];
    //    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    //    self.navigationItem.rightBarButtonItem = rightItem;
    
    //隐藏tableView分割线
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.backgroundColor = BackGroundColor;
    
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
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    self.dataArr = [[NSMutableArray alloc]init];
    AccoutObject *userObj = [PublicObject getUserInfoDefault];
    if(userObj == nil)
    {
        [PublicObject showHUDView:self.view title:@"未登录" content:@"" time:kHUDTime andCodes:^{
            [self.tableView reloadData];
        }];
    }else{
        [self getBindStudents];
    }
    
}
-(void)getBindStudents{
    AccoutObject *userObj = [PublicObject getUserInfoDefault];
    [DYRequestBase SearchBindStudentsByUserId:userObj.idcode requestStartBlock:^{
        [PublicObject showHUDBegain:self.view title:@"正在获取……"];
    } responseBlock:^(id dataObj, NSError *error) {
        [PublicObject dissMissHUDEnd];
        if (dataObj) {
            int status = [[dataObj objectForKey:@"status"] intValue];
            NSString *msg = [PublicObject convertNullString:[dataObj objectForKey:@"msg"]];
            if (status == 0) {
                NSArray *objArr = [dataObj objectForKey:@"list"];
                NSLog(@"%@",objArr);
                //json转对象
                for (int i = 0; i < objArr.count; i++) {
                    NSDictionary *dic = [objArr objectAtIndex:i];
                    StudentObject *studentObj = [StudentObject mj_objectWithKeyValues:dic];
                    [self.dataArr addObject:studentObj];
                }
                [self.tableView reloadData];
            } else {
                [PublicObject showHUDView:self.view title:msg content:@"" time:kHUDTime andCodes:^{
                }];
            }

        }else{
            [PublicObject showHUDView:self.view title:@"请求失败" content:@"" time:kHUDTime andCodes:^{
            }];
        }
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 *	个人中心
 */
- (IBAction)goPersonalVC:(id)sender{
    //设置最近一次变更
    kLastSelectedIndex = 4;
    
    TeacherViewController *pVC = [[TeacherViewController alloc]init];
    pVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:pVC animated:YES];
}
-(void)presentRightVC{
    NSLog(@"点击了导航栏右侧的按钮");
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 8)];
    backView.backgroundColor = [UIColor whiteColor];
    return backView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 8;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //1.加载xib
    static NSString *CellIdentifier = @"IdentificationTableViewCell";
    IdentificationTableViewCell *cell = (IdentificationTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        NSBundle *bundle = [NSBundle mainBundle];
        NSArray *nibArray = [bundle loadNibNamed:CellIdentifier owner:self options:nil];
        cell = (IdentificationTableViewCell *)[nibArray objectAtIndex:0];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    cell.delegate = self;
    cell.detailBtn.tag = indexPath.row;//跳转详情用
    cell.infoView.tag = indexPath.row;//跳转详情用
    cell.leaveBtn.tag = indexPath.row;
    cell.statusBtn.tag = indexPath.row;
    cell.followBtn.tag = indexPath.row;
    //背景色
    cell.infoView.backgroundColor = MainColor;
    cell.leaveBtn.backgroundColor = MainColor;
    cell.statusBtn.backgroundColor = MainColor;
    cell.followBtn.backgroundColor = MainColor;
    cell.lab1.textColor = [UIColor whiteColor];
    cell.lab2.textColor = [UIColor whiteColor];
    cell.lab3.textColor = [UIColor whiteColor];
    //获取数据
    StudentObject *stuObj = [self.dataArr objectAtIndex:indexPath.row];
    cell.lab1.text = stuObj.stuname;
    cell.lab2.text = stuObj.classname;
    cell.lab3.text = stuObj.schoolname;
    
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 137;
}
//代理方法的实现
-(void)leaveClick:(UIButton *)leaveBtn{
    LeaveViewController *leaveVC = [[LeaveViewController alloc]initWithNibName:@"LeaveViewController" bundle:nil];
    leaveVC.hidesBottomBarWhenPushed = YES;
    leaveVC.stuObj = [self.dataArr objectAtIndex:leaveBtn.tag];
    [self.navigationController pushViewController:leaveVC animated:YES];
}
-(void)statusClick:(UIButton *)statusBtn{
    StudentObject *stuObj = [self.dataArr objectAtIndex:statusBtn.tag];
    self.statusView.hidden = NO;
    self.statusView.stuStatus = stuObj.stutype;
    [self.statusView showStuStatus];
}
-(void)followClick:(UIButton *)followBtn{
    FollowViewController *followVC = [[FollowViewController alloc]initWithNibName:@"FollowViewController" bundle:nil];
    followVC.hidesBottomBarWhenPushed = YES;
    followVC.stuObj = [self.dataArr objectAtIndex:followBtn.tag];
    [self.navigationController pushViewController:followVC animated:YES];
}
-(void)detailClick:(UIButton *)detailBtn{
    int indexNum = (int)detailBtn.tag;
    IdentificationDetailViewController *identificationDetailVC = [[IdentificationDetailViewController alloc]initWithNibName:@"IdentificationDetailViewController" bundle:nil];
    identificationDetailVC.hidesBottomBarWhenPushed = YES;
    identificationDetailVC.studentObj = [self.dataArr objectAtIndex:indexNum];
    [self.navigationController pushViewController:identificationDetailVC animated:YES];
}
-(void)showDetailClick:(UIView *)infoView{
    int indexNum = (int)infoView.tag;
    IdentificationDetailViewController *identificationDetailVC = [[IdentificationDetailViewController alloc]initWithNibName:@"IdentificationDetailViewController" bundle:nil];
    identificationDetailVC.hidesBottomBarWhenPushed = YES;
    identificationDetailVC.studentObj = [self.dataArr objectAtIndex:indexNum];
    [self.navigationController pushViewController:identificationDetailVC animated:YES];
    
}
//目前状态按钮的代理方法
-(void)cancelClick{
    self.statusView.hidden = YES;
}
-(void)submitClick{
    self.statusView.hidden = YES;
}
@end
