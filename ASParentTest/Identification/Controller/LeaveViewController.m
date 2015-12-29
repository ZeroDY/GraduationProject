//
//  LeaveViewController.m
//  ASParentTest
//
//  Created by 张浩 on 15/11/21.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "LeaveViewController.h"
#import "LeaveTableViewCell.h"
#import "LeaveDetailViewController.h"
#import "LeaveObject.h"
#import "LeaveDeatilShowViewController.h"
#import "LeaveDetailViewController.h"
//接口
#import "DYRequestBase+SearchLeaveList.h"
@interface LeaveViewController ()

@end

@implementation LeaveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"请假记录";
    
    UIButton* rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,60,30)];
    [rightButton setTitle:@"申请" forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize: 16];
    [rightButton addTarget:self action:@selector(presentRightVC) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem= rightItem;
    
    //隐藏tableView分割线
    self.tableView.backgroundColor = BackGroundColor;
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    //下拉刷新
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.currentPage = 1;
        [self getLeaveListWithCurrentPage:self.currentPage andRowOfPage:@"10"];
    }];
    // 上拉刷新方法1
    self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        if (self.currentPage == self.allPages) {
            [PublicObject showHUDView:self.view title:@"已经是最后一页" content:@"" time:1 andCodes:^{
                [self.tableView.footer endRefreshing];
            }];
        }else{
            self.currentPage++;
        [self getLeaveListWithCurrentPage:self.currentPage andRowOfPage:@"10"];
        }
    }];
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.tableView.header beginRefreshing];
}
-(void)getLeaveListWithCurrentPage:(NSInteger)currentPage andRowOfPage:(NSString *)rowOfPage{
    {
        [DYRequestBase SearchLeaveListByXuejiNum:self.stuObj.schoolcensus CurrentPageNum:[NSString stringWithFormat:@"%ld",(long)currentPage] RowOfPage:rowOfPage requestStartBlock:^{
            [PublicObject showHUDBegain:self.view title:@"正在获取……"];
        } responseBlock:^(id dataObj, NSError *error) {
            [PublicObject dissMissHUDEnd];
            [self.tableView.header endRefreshing];
            [self.tableView.footer endRefreshing];
            if (dataObj) {
                int status = [[dataObj objectForKey:@"status"] intValue];
                NSString *msg = [PublicObject convertNullString:[dataObj objectForKey:@"msg"]];
                if (status == 0) {
                    self.allPages = [[[dataObj objectForKey:@"pageInfo"] objectForKey:@"allPageNum"] intValue];
                    self.dataArr = [[NSMutableArray alloc]init];
                    NSArray *objArr = [dataObj objectForKey:@"list"];
                    NSLog(@"%@",objArr);
                    //json转对象
                    for (int i = 0; i < objArr.count; i++) {
                        NSDictionary *dic = [objArr objectAtIndex:i];
                        LeaveObject *leaveObj = [LeaveObject mj_objectWithKeyValues:dic];
                        [self.dataArr addObject:leaveObj];
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
}
- (void)presentRightVC{
    LeaveDetailViewController *addLeaveVC = [[LeaveDetailViewController alloc]initWithNibName:@"LeaveDetailViewController" bundle:nil];
    addLeaveVC.stuObj = self.stuObj;
    [self.navigationController pushViewController:addLeaveVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"%lu",(unsigned long)self.dataArr.count);
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //1.加载xib
    static NSString *CellIdentifier = @"LeaveTableViewCell";
    LeaveTableViewCell *cell = (LeaveTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        NSBundle *bundle = [NSBundle mainBundle];
        NSArray *nibArray = [bundle loadNibNamed:CellIdentifier owner:self options:nil];
        cell = (LeaveTableViewCell *)[nibArray objectAtIndex:0];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    LeaveObject *leaveObj = [self.dataArr objectAtIndex:indexPath.row];
    //
    cell.titleImg.layer.cornerRadius = cell.titleImg.frame.size.width/2;
    cell.titleImg.layer.masksToBounds = YES;
    
    if ([leaveObj.ltype intValue] == 0) {//允许
        cell.titleImg.backgroundColor = [UIColor greenColor];
        cell.statusLab.text = @"允许";
    }
    else if ([leaveObj.ltype intValue] == 1){//拒绝
        cell.titleImg.backgroundColor = [UIColor redColor];
        cell.statusLab.text = @"拒绝";
    }
    else{//审批中
        cell.titleImg.backgroundColor = [UIColor blueColor];
        cell.statusLab.text = @"审批中";
    }
    cell.timeLab.text = leaveObj.addtime;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LeaveDeatilShowViewController *leaveDetailVC = [[LeaveDeatilShowViewController alloc]initWithNibName:@"LeaveDeatilShowViewController" bundle:nil];
    LeaveObject *leaveObj = [self.dataArr objectAtIndex:indexPath.row];
    leaveDetailVC.leaveObj = leaveObj;
    [self.navigationController pushViewController:leaveDetailVC animated:YES];
}
@end

