//
//  DifficultFeedBackViewController.m
//  ASParentTest
//
//  Created by 张浩 on 15/11/21.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "DifficultFeedBackViewController.h"
#import "AddDifficultFeedBackViewController.h"
#import "DifficultFeedBackDetailViewController.h"
@interface DifficultFeedBackViewController ()

@end

@implementation DifficultFeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"疑难解答";
    self.tableView.tableFooterView = [[UIView alloc]init];
    UIButton* rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,60,30)];
    [rightButton setTitle:@"添加" forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize: 14];
    [rightButton addTarget:self action:@selector(presentRightVC) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem= rightItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    
    self.dataArr = [[NSMutableArray alloc]init];
    NSArray *subjectArr1= [[NSArray alloc]initWithObjects:@"我的问题1",@"我的问题2",@"我的问题3",@"我的问题4", nil];
    NSArray *subjectArr2= [[NSArray alloc]initWithObjects:@"我的问题1",@"我的问题2",@"我的问题3", nil];
    NSArray *subjectArr3= [[NSArray alloc]initWithObjects:@"我的问题1",@"我的问题2",@"我的问题3",@"我的问题4",@"我的问题5", nil];
    
    NSDictionary *dic1= [[NSDictionary alloc]initWithObjectsAndKeys:@"2011-10-1 周三",@"time",subjectArr1,@"data", nil];
    NSDictionary *dic2= [[NSDictionary alloc]initWithObjectsAndKeys:@"2011-10-2 周四",@"time",subjectArr2,@"data", nil];
    NSDictionary *dic3= [[NSDictionary alloc]initWithObjectsAndKeys:@"2011-10-3 周五",@"time",subjectArr3,@"data", nil];
    [self.dataArr addObject:dic1];
    [self.dataArr addObject:dic2];
    [self.dataArr addObject:dic3];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        NSDictionary *tempDic = [self.dataArr objectAtIndex:section];
        NSArray *tempArr = [tempDic objectForKey:@"data"];
        return tempArr.count;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH , 30)];
    headView.backgroundColor = BackGroundColor;
    
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 20)];
    titleLab.font = [UIFont systemFontOfSize:14];
    titleLab.backgroundColor = MainColor;
    titleLab.textColor = [UIColor whiteColor];
    
    NSDictionary *tempDic = [self.dataArr objectAtIndex:section];
    
    //设置每组的的标题
    titleLab.text = [tempDic objectForKey:@"time"];
    [headView addSubview:titleLab];//将标题v_headerLab添加到创建的视图（v_headerView）中
    return headView;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //2.手写
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    NSDictionary*temp = [self.dataArr objectAtIndex:indexPath.section];
    NSArray *tempArr = [temp objectForKey:@"data"];
    
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(8, 17, 10, 10)];
    img.backgroundColor = [UIColor redColor];
    img.layer.masksToBounds = YES;
    img.layer.cornerRadius = img.frame.size.width/2;
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(30, 12, SCREEN_WIDTH-16-30, 21)];
    lab.textColor = [UIColor darkGrayColor];
    lab.font = [UIFont systemFontOfSize:12];
    
    [cell.contentView addSubview:img];
    [cell.contentView addSubview:lab];
    lab.text = [tempArr objectAtIndex:indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DifficultFeedBackDetailViewController *difficulyFeedBackDetailVC = [[DifficultFeedBackDetailViewController alloc]initWithNibName:@"DifficultFeedBackDetailViewController" bundle:nil];
    [self.navigationController pushViewController:difficulyFeedBackDetailVC animated:YES];
}
//去掉UItableview headerview黏性
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.tableView)
    {
        CGFloat sectionHeaderHeight = 30;
        if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
    }
}
-(void)presentRightVC{
    AddDifficultFeedBackViewController *addDifficultFeedBackVC = [[AddDifficultFeedBackViewController alloc]initWithNibName:@"AddDifficultFeedBackViewController" bundle:nil];
    [self.navigationController pushViewController:addDifficultFeedBackVC animated:YES];
}
@end
