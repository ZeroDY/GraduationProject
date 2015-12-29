//
//  WorkPushViewController.m
//  ASParentTest
//
//  Created by 张浩 on 15/11/21.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "WorkPushViewController.h"
#import "WorkPushObject.h"
#import "WorkPushDetailViewController.h"
#import "WorkPushTableViewCell.h"
#import "AddHomeworkViewController.h"
//接口
#import "DYRequestBase+SearchHomeWork.h"
@interface WorkPushViewController ()

@end

@implementation WorkPushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"作业推送";
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    //下拉刷新
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.currentPage = 1;
        [self getHomeWorkWithCurrentPage:self.currentPage andRowOfPage:@"10"];
    }];
    // 上拉刷新方法1
    self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        if (self.currentPage == self.allPages) {
            [PublicObject showHUDView:self.view title:@"已经是最后一页" content:@"" time:1 andCodes:^{
                [self.tableView.footer endRefreshing];
            }];
        }else{
            self.currentPage++;
        [self getHomeWorkWithCurrentPage:self.currentPage andRowOfPage:@"10"];
        }
    }];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.tableView.header beginRefreshing];
}
-(void)getHomeWorkWithCurrentPage:(NSInteger)currentPage andRowOfPage:(NSString *)rowOfPage{
    AccoutObject *userObj = [PublicObject getUserInfoDefault];
    [DYRequestBase SearchHomeWorkByUserId:userObj.idcode StudentId:self.stuObj.schoolcensus CurrentPageNum:[NSString stringWithFormat:@"%ld",(long)currentPage] RowOfPage:rowOfPage requestStartBlock:^{
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
                //遍历objArr,转为对象，并且按照时间进行重新分组
                NSMutableArray *array = [[NSMutableArray alloc]init];
                NSArray *thomeworkArray = [WorkPushObject mj_objectArrayWithKeyValuesArray:objArr];
                
                for (WorkPushObject *workObj in thomeworkArray) {
                    NSString *timeStr = [workObj.addtime componentsSeparatedByString:@" "][0];
                    BOOL isHave = NO;
                    for (NSDictionary *dic in array) {
                        if ([dic.allKeys[0] isEqualToString:timeStr]) {
                            NSMutableArray *oneDayArray = dic[timeStr];
                            [oneDayArray addObject:workObj];
                            [dic setValue:oneDayArray forKey:timeStr];
                            isHave = YES;
                            break;
                        }
                    }
                    if (!isHave) {
                        NSMutableDictionary *oneDayDic = [[NSMutableDictionary alloc]init];
                        NSMutableArray *oneDayArray = [[NSMutableArray alloc]init];
                        [oneDayArray addObject:workObj];
                        [oneDayDic setObject:oneDayArray forKey:timeStr];
                        [array addObject:oneDayDic];
                    }
                }
                self.dataArr = array;
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
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSDictionary *oneDayDic = [self.dataArr objectAtIndex:section];
    NSString *oneDayDicKeyStr = [oneDayDic allKeys][0];
    NSArray *arr = [oneDayDic objectForKey:oneDayDicKeyStr];
    return arr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH , 30)];
    headView.backgroundColor = BackGroundColor;
    
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_HEIGHT, 20)];
    backView.backgroundColor = MainColor;
    [headView addSubview:backView];
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(8, 0, SCREEN_WIDTH, 20)];
    titleLab.font = [UIFont systemFontOfSize:14];
    titleLab.backgroundColor = [UIColor clearColor];
    titleLab.textColor = [UIColor whiteColor];
    [backView addSubview:titleLab];
    
    NSDictionary *oneDayDic = [self.dataArr objectAtIndex:section];
    NSString *oneDayDicKeyStr = [oneDayDic allKeys][0];
    //设置每组的的标题
    titleLab.text = oneDayDicKeyStr;
    return headView;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //1.加载xib
    static NSString *CellIdentifier = @"WorkPushTableViewCell";
    WorkPushTableViewCell *cell = (WorkPushTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        NSBundle *bundle = [NSBundle mainBundle];
        NSArray *nibArray = [bundle loadNibNamed:CellIdentifier owner:self options:nil];
        cell = (WorkPushTableViewCell *)[nibArray objectAtIndex:0];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    //样式
    cell.titlebackView.layer.masksToBounds = YES;
    cell.titlebackView.layer.cornerRadius = cell.titlebackView.frame.size.width/2;
    
    cell.statusBackView.layer.masksToBounds = YES;
    cell.statusBackView.layer.cornerRadius = cell.statusBackView.frame.size.width/2;
    cell.statusView.layer.masksToBounds = YES;
    cell.statusView.layer.cornerRadius = cell.statusView.frame.size.width/2;
    //数据
    NSDictionary *oneDayDic = [self.dataArr objectAtIndex:indexPath.section];
    NSString *oneDayDicKeyStr = [oneDayDic allKeys][0];
    NSArray *arr = [oneDayDic objectForKey:oneDayDicKeyStr];
    WorkPushObject *workObj = [arr objectAtIndex:indexPath.row];
    if (indexPath.row % 2 == 0) {
        cell.titleLab.text = @"已";
        cell.titlebackView.backgroundColor = MainColor;
    }else{
        cell.titleLab.text = @"未";
        cell.titlebackView.backgroundColor = [UIColor redColor];
    }
    
    cell.infoLab1.text = workObj.header;
    cell.infoLab2.text = workObj.stcont;
    
    cell.timeLab.text = [workObj.addtime substringFromIndex:11];
    if (indexPath.row % 2 == 0) {
        cell.statusLab.text = @"已截止";
        
        cell.statusView.backgroundColor = [UIColor clearColor];
        cell.statusLab.textColor = [UIColor redColor];
        
    }else{
        cell.statusLab.text = @"解答";
        cell.statusView.backgroundColor = MainColor;
    }
    
    //接口暂时没有该字段，隐藏处理
    cell.questionNumLab.hidden = YES;
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *oneDayDic = [self.dataArr objectAtIndex:indexPath.section];
    NSString *oneDayDicKeyStr = [oneDayDic allKeys][0];
    NSArray *arr = [oneDayDic objectForKey:oneDayDicKeyStr];
    WorkPushObject *workObj = [arr objectAtIndex:indexPath.row]; 
    AddHomeworkViewController *addHomeWorkVC = [[AddHomeworkViewController alloc]initWithNibName:@"AddHomeworkViewController" bundle:nil];
    addHomeWorkVC.homeworkId = workObj.idcode;
    [self.navigationController pushViewController:addHomeWorkVC animated:YES];
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
@end
