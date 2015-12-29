//
//  InvestigationViewController.m
//  ASParentTest
//
//  Created by 周德艺 on 15/11/17.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "InvestigationViewController.h"
#import "InvestigationTableViewCell.h"
#import <QuartzCore/QuartzCore.h>
#import "ZcdcViewController.h"
#import "ZcdcDetailViewController.h"
#import "JyxcViewController.h"
#import "JsgyDetailViewController.h"
#import "JsgyViewController.h"
#import "QzbsViewController.h"
#import "TeacherViewController.h"
#import "LoginViewController.h"
#import "ZcdcObject.h"
#import "JsgyObject.h"
//接口
#import "DYRequestBase+GetZcdcList.h"
#import "DYRequestBase+GetJsgyList.h"
@interface InvestigationViewController ()

@end

@implementation InvestigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"调查征询";
    //设置tableView没数据的空白
    self.tableView.tableFooterView = [[UIView alloc]init];
    //    self.tableView.separatorColor = [UIColor clearColor];
    //    self.tableView.backgroundColor = BackGroundColor;
    
    //下拉刷新
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        AccoutObject *userObj = [PublicObject getUserInfoDefault];
        if (userObj) {
            [self getZcdcListWithCurrentPage:1 andRowOfPage:@"3"];
            [self getJsgyListWithCurrentPage:1 andRowOfPage:@"3"];
        }else{
            [self getJsgyListWithCurrentPage:1 andRowOfPage:@"3"];
        }
    }];
}
-(void)viewWillAppear:(BOOL)animated{
    self.zcdcArr = [[NSMutableArray alloc]init];
    self.jsgyArr = [[NSMutableArray alloc]init];

    [self.tableView.header beginRefreshing];
}
/**
 *	个人中心
 */
- (IBAction)goPersonalVC:(id)sender{
    //设置最近一次变更
    kLastSelectedIndex = 3;
    
    TeacherViewController *pVC = [[TeacherViewController alloc]init];
    pVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:pVC animated:YES];
}
//政策调查
-(void)getZcdcListWithCurrentPage:(NSInteger)currentPage andRowOfPage:(NSString *)rowOfPage{
    AccoutObject *userObj = [PublicObject getUserInfoDefault];
    NSLog(@"%@",userObj.idcode);
    [DYRequestBase GetZcdcListByUserId:userObj.idcode CurrentPageNum:[NSString stringWithFormat:@"%ld",(long)currentPage] RowOfPage:rowOfPage requestStartBlock:^{
        [PublicObject showHUDBegain:self.view title:@"正在获取……"];
    } responseBlock:^(id dataObj, NSError *error) {
        [PublicObject dissMissHUDEnd];
        [self.tableView.header endRefreshing];
        if (dataObj) {
            int status = [[dataObj objectForKey:@"status"] intValue];
            NSString *msg = [PublicObject convertNullString:[dataObj objectForKey:@"msg"]];
            if (status == 0) {
                NSArray *objArr = [dataObj objectForKey:@"list"];
                self.zcdcArr = [[NSMutableArray alloc]init];
                NSLog(@"%@",objArr);
                //json转对象
                for (int i = 0; i < objArr.count; i++) {
                    NSDictionary *dic = [objArr objectAtIndex:i];
                    ZcdcObject *zcdcObj = [ZcdcObject mj_objectWithKeyValues:dic];
                    [self.zcdcArr addObject:zcdcObj];
                }
                [self.tableView reloadData];
            } else {
                [PublicObject showHUDView:self.view title:msg content:@"" time:kHUDTime andCodes:^{
                }];
            }
        }else{
            [PublicObject showHUDView:self.view title:@"调查征询请求失败" content:@"" time:kHUDTime andCodes:^{
            }];
        }
    }];
}
//集思广益
-(void)getJsgyListWithCurrentPage:(NSInteger)currentPage andRowOfPage:(NSString *)rowOfPage{
    AccoutObject *userObj = [PublicObject getUserInfoDefault];
    [DYRequestBase GetJsgyListByUserId:nil CurrentPageNum:[NSString stringWithFormat:@"%ld",(long)currentPage] RowOfPage:rowOfPage requestStartBlock:^{
        [PublicObject showHUDBegain:self.view title:@"正在获取……"];
    } responseBlock:^(id dataObj, NSError *error) {
        [PublicObject dissMissHUDEnd];
        [self.tableView.header endRefreshing];
        if (dataObj) {
            int status = [[dataObj objectForKey:@"status"] intValue];
            NSString *msg = [PublicObject convertNullString:[dataObj objectForKey:@"msg"]];
            if (status == 0) {
                NSArray *objArr = [dataObj objectForKey:@"list"];
                NSLog(@"%@",objArr);
                self.jsgyArr = [[NSMutableArray alloc]init];
                //json转对象
                for (int i = 0; i < objArr.count; i++) {
                    NSDictionary *dic = [objArr objectAtIndex:i];
                    JsgyObject *jsgyObj = [JsgyObject mj_objectWithKeyValues:dic];
                    [self.jsgyArr addObject:jsgyObj];
                }
                [self.tableView reloadData];
            } else {
                [PublicObject showHUDView:self.view title:msg content:@"" time:kHUDTime andCodes:^{
                }];
            }
        }else{
            [PublicObject showHUDView:self.view title:@"集思广益请求失败" content:@"" time:kHUDTime andCodes:^{
            }];
        }
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.zcdcArr.count;
        
    }else{
        return self.jsgyArr.count;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30+8;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH , 38)];
    headView.backgroundColor = BackGroundColor;
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 3, SCREEN_WIDTH, 35)];
    backView.backgroundColor = [UIColor whiteColor];
    [headView addSubview:backView];
    
    UIImageView *titleImg = [[UIImageView alloc] initWithFrame:CGRectMake(8, 5, 20, 20)];
    [backView addSubview:titleImg];
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 70, 30)];
    titleLab.textColor = [UIColor darkGrayColor];
    titleLab.font = [UIFont systemFontOfSize:16];
    
    UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 28, SCREEN_WIDTH, 1)];
    lineLab.backgroundColor = BackGroundColor;
    [backView addSubview:lineLab];
    //设置每组的的标题
    if (section == 0) {
        titleLab.text = @"政策调查";
        self.headType = 0;
        [titleImg setImage:[UIImage imageNamed:@"investigation_zcdc_small.png"]];
        
    }
    if (section == 1) {
        titleLab.text = @"集思广益";
        self.headType = 1;
        [titleImg setImage:[UIImage imageNamed:@"investigation_jsgy_big.png"]];
        
    }
    [backView addSubview:titleLab];//将标题v_headerLab添加到创建的视图（v_headerView）中
    
    UILabel *moreInfo = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-70, 0, 50, 30)];
    moreInfo.textColor = [UIColor darkGrayColor];
    moreInfo.font = [UIFont systemFontOfSize:16];
    moreInfo.text = @"更多";
    [backView addSubview:moreInfo];
    
    UIImageView *moreImg = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-8-20, 5, 10, 20)];
    [moreImg setImage:[UIImage imageNamed:@"arrow_gray_right.png"]];
    [backView addSubview:moreImg];
    
    //给headView一个点击事件
    headView.userInteractionEnabled = YES;
    UITapGestureRecognizer *click = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headViewMoreClick)];
    [headView addGestureRecognizer:click];
    
    return headView;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //1.加载xib
    static NSString *CellIdentifier = @"InvestigationTableViewCell";
    InvestigationTableViewCell *cell = (InvestigationTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        NSBundle *bundle = [NSBundle mainBundle];
        NSArray *nibArray = [bundle loadNibNamed:CellIdentifier owner:self options:nil];
        cell = (InvestigationTableViewCell *)[nibArray objectAtIndex:0];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.pointImg.backgroundColor = MainColor;
    //将pointImg图层的边框设置为圆脚
    cell.pointImg.layer.cornerRadius = 5;
    cell.pointImg.layer.masksToBounds = YES;
    
    if (indexPath.section == 0) {//政策调查
        ZcdcObject *zcdcObj = [self.zcdcArr objectAtIndex:indexPath.row];
        cell.infoLab.text = zcdcObj.sheader;
    }else{//集思广益
        JsgyObject *jsgyObj = [self.jsgyArr objectAtIndex:indexPath.row];
        cell.infoLab.text = jsgyObj.scontent;
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0://政策调查
        {
            [self judgeLogin];
            ZcdcDetailViewController *zcdcDetailVC = [[ZcdcDetailViewController alloc]initWithNibName:@"ZcdcDetailViewController" bundle:nil];
            zcdcDetailVC.zcdcObj = [self.zcdcArr objectAtIndex:indexPath.row];
            zcdcDetailVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:zcdcDetailVC animated:YES];
        }
            break;
        case 1://集思广益
        {
            [self judgeLogin];
            JsgyDetailViewController *jsgyDetailVC = [[JsgyDetailViewController alloc]initWithNibName:@"JsgyDetailViewController" bundle:nil];
            jsgyDetailVC.jsgyObj = [self.jsgyArr objectAtIndex:indexPath.row];
            jsgyDetailVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:jsgyDetailVC animated:YES];

        }
            break;
        default:
            break;
    }
}
-(void)headViewMoreClick{
    if (self.headType == 0) {//政策调查
        [self judgeLogin];
        ZcdcViewController *zcdcVC = [[ZcdcViewController alloc]initWithNibName:@"ZcdcViewController" bundle:nil];
        zcdcVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:zcdcVC animated:YES];
    }else{//集思广益
        [self judgeLogin];
        JsgyViewController *jsgyVC = [[JsgyViewController alloc]initWithNibName:@"JsgyViewController" bundle:nil];
        jsgyVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:jsgyVC animated:YES];
    }
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
- (IBAction)zcdcClick:(id)sender {
    [self judgeLogin];
    ZcdcViewController *zcdcVC = [[ZcdcViewController alloc]initWithNibName:@"ZcdcViewController" bundle:nil];
    zcdcVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:zcdcVC animated:YES];
}
- (IBAction)jyxcClick:(id)sender {
    [self judgeLogin];
    JyxcViewController *jyxcVC = [[JyxcViewController alloc]initWithNibName:@"JyxcViewController" bundle:nil];
    jyxcVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:jyxcVC animated:YES];
}
- (IBAction)jsgyClick:(id)sender {
    [self judgeLogin];
    JsgyViewController *jsgyVC = [[JsgyViewController alloc]initWithNibName:@"JsgyViewController" bundle:nil];
    jsgyVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:jsgyVC animated:YES];
}
- (IBAction)qzbsClick:(id)sender {
    [self judgeLogin];
    QzbsViewController *qzbsVC = [[QzbsViewController alloc]initWithNibName:@"QzbsViewController" bundle:nil];
    qzbsVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:qzbsVC animated:YES];
}
-(void)judgeLogin{
    AccoutObject *userObj = [PublicObject getUserInfoDefault];
    if(userObj == nil)
    {
        [self goToLoginVC];
    }else{
        [self.tableView reloadData];
    }
}
-(void)goToLoginVC{
    LoginViewController *loginController = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    UINavigationController *newNVC = [[UINavigationController alloc]initWithRootViewController:loginController];
    newNVC.tabBarItem.title = @"登 录";
    
    newNVC.navigationBar.translucent =  NO;//透明
    //导航栏颜色
    newNVC.navigationBar.barTintColor = MainColor;
    //修改UINavigationController title 的颜色和大小
    UIColor * titleColor = [UIColor whiteColor];
    UIFont * font = [UIFont boldSystemFontOfSize:20];
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:titleColor,NSForegroundColorAttributeName,font,NSFontAttributeName, nil];
    newNVC.navigationBar.titleTextAttributes = dic;
    
    loginController.dismissView = ^(BOOL isSuccess){
        if (isSuccess) {
            [self dismissViewControllerAnimated:YES completion:^{
            }];
        }else{
            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];
        }
    };
    
    //调用此方法显示模态窗口
    [self presentViewController:newNVC animated:YES completion:nil];
    
}
@end
