//
//  JsgyDetailViewController.m
//  ASParentTest
//
//  Created by 张浩 on 15/11/20.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "JsgyDetailViewController.h"
#import "JsgyDetailTitleTableViewCell.h"
#import "JsgyDetailContentTableViewCell.h"
#import "JsgyCommentObject.h"
//接口
#import "DYRequestBase+GetJsgyDetail.h"
#import "DYRequestBase+GetJsgyCommentList.h"
#import "DYRequestBase+PublishJsgy.h"
@interface JsgyDetailViewController ()

@end

@implementation JsgyDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"我的热点";
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.backgroundColor = BackGroundColor;
    
    // handleSwipeFrom 是偵測到手势，所要呼叫的方法
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidenKeyboard)];
    gesture.numberOfTapsRequired = 1;
    [self.tableView addGestureRecognizer:gesture];
}
-(void)viewWillAppear:(BOOL)animated{
    
    [self getJsgyDetail];
    self.dataArr = [[NSMutableArray alloc]init];
    
    // 列表的下拉刷新
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self getJsgyDetail];
    }];
    
}
-(void)getJsgyDetail{
//    AccoutObject *userObj = [PublicObject getUserInfoDefault];
    [DYRequestBase GetJsgyDetailByJsgyId:self.jsgyObj.idcode requestStartBlock:^{
        [PublicObject showHUDBegain:self.view title:@"正在获取……"];
    } responseBlock:^(id dataObj, NSError *error) {
        [PublicObject dissMissHUDEnd];
        if (dataObj) {
            int status = [[dataObj objectForKey:@"status"] intValue];
            NSString *msg = [PublicObject convertNullString:[dataObj objectForKey:@"msg"]];
            if (status == 0) {
                NSDictionary *objDic = [dataObj objectForKey:@"obj"];
                NSLog(@"%@",objDic);
                [self getCommentList];
                self.jsgyDetailObj = [JsgyDetailObject mj_objectWithKeyValues:objDic];
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
-(void)getCommentList{
    AccoutObject *userObj = [PublicObject getUserInfoDefault];
    
    [DYRequestBase GetJsgyCommentListByUserId:userObj.idcode JsgyId:self.jsgyObj.idcode requestStartBlock:^{
        [PublicObject showHUDBegain:self.view title:@"正在获取……"];
    } responseBlock:^(id dataObj, NSError *error) {
        [PublicObject dissMissHUDEnd];
        if (dataObj) {
            int status = [[dataObj objectForKey:@"status"] intValue];
            NSString *msg = [PublicObject convertNullString:[dataObj objectForKey:@"msg"]];
            if (status == 0) {
                NSArray *objArr = [dataObj objectForKey:@"list"];
                NSLog(@"%@",objArr);
                self.dataArr = [JsgyCommentObject mj_objectArrayWithKeyValuesArray:objArr];
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
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return self.dataArr.count;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.1;
    }else{
        return 44;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH , 44)];
        headView.backgroundColor = MainColor;
        
        UIImageView *titleImg = [[UIImageView alloc] initWithFrame:CGRectMake(8, 7, 30, 30)];
        [titleImg setImage:[UIImage imageNamed:@"pic-touxiang2.png"]];
        titleImg.layer.masksToBounds = YES;
        titleImg.layer.cornerRadius = titleImg.frame.size.height/2;
        [headView addSubview:titleImg];
        
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(46, 12, 70, 20)];
        titleLab.textColor = [UIColor whiteColor];
        titleLab.font = [UIFont systemFontOfSize:14];
        
        //设置每组的的标题
        titleLab.text = @"我的想法";
        [headView addSubview:titleLab];//将标题v_headerLab添加到创建的视图（v_headerView）中
        return headView;
    }else{
        return nil;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //1.加载xib
    static NSString *CellIdentifier1 = @"JsgyDetailTitleTableViewCell";
    static NSString *CellIdentifier2 = @"JsgyDetailContentTableViewCell";
    if (indexPath.section == 0) {
        JsgyDetailTitleTableViewCell *cell = (JsgyDetailTitleTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
        if (cell == nil) {
            NSBundle *bundle = [NSBundle mainBundle];
            NSArray *nibArray = [bundle loadNibNamed:CellIdentifier1 owner:self options:nil];
            cell = (JsgyDetailTitleTableViewCell *)[nibArray objectAtIndex:0];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        cell.pointImg.layer.masksToBounds = YES;
        cell.pointImg.layer.cornerRadius = cell.pointImg.frame.size.height/2;
        cell.titleImg.image = [UIImage imageNamed:@"pic-touxiang.png"];
        cell.titleBackView.backgroundColor = MainColor;
        cell.titleLab.textColor = [UIColor whiteColor];
        
        cell.titleLab.text = @"发布者";
        cell.timeLab.text = self.jsgyDetailObj.addtime;
        cell.timeLab.textColor = [UIColor darkGrayColor];
        cell.contentLab.text = self.jsgyDetailObj.scontent;
        cell.contentLab.textColor = [UIColor darkGrayColor];
        return cell;
    }else{
        JsgyDetailContentTableViewCell *cell = (JsgyDetailContentTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
        if (cell == nil) {
            NSBundle *bundle = [NSBundle mainBundle];
            NSArray *nibArray = [bundle loadNibNamed:CellIdentifier2 owner:self options:nil];
            cell = (JsgyDetailContentTableViewCell *)[nibArray objectAtIndex:0];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        cell.pointImg.layer.masksToBounds = YES;
        cell.pointImg.layer.cornerRadius = cell.pointImg.frame.size.height/2;
        JsgyCommentObject *commentObj = [self.dataArr objectAtIndex:indexPath.row];
        cell.contentLab.text = commentObj.scontent;
        cell.contentLab.textColor = [UIColor darkGrayColor];
        cell.timeLab.text = commentObj.addtime;
        cell.timeLab.textColor = [UIColor darkGrayColor];
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return [JsgyDetailTitleTableViewCell calculateCellHeightWithContentStr:self.jsgyDetailObj.scontent];
    }else{
        JsgyCommentObject *commentObj = [self.dataArr objectAtIndex:indexPath.row];
        NSString *content = commentObj.scontent;
        return [JsgyDetailContentTableViewCell calculateCellHeightWithContentStr:content];
    }
}
//去掉UItableview headerview黏性
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.tableView)
    {
        CGFloat sectionHeaderHeight = 8;
        if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
    }
}
- (IBAction)publishClick:(id)sender {
    
    NSString *content = self.contentTextField.text;
    
    //中文转码
    content = [content stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    AccoutObject *userObj = [PublicObject getUserInfoDefault];
    [DYRequestBase PublishJsgyByUserId:userObj.idcode JsgyId:self.jsgyObj.idcode CommentContent:content requestStartBlock:^{
        [PublicObject showHUDBegain:self.view title:@"正在发布……"];
    } responseBlock:^(id dataObj, NSError *error) {
        [PublicObject dissMissHUDEnd];
        if (dataObj) {
            int status = [[dataObj objectForKey:@"status"] intValue];
            NSString *msg = [PublicObject convertNullString:[dataObj objectForKey:@"msg"]];
            if (status == 0) {
                [PublicObject showHUDView:self.view title:@"发布成功" content:@"" time:kHUDTime andCodes:^{
                    [self getCommentList];
                }];
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


//隐藏键盘的方法
- (void)hidenKeyboard {
    [self.contentTextField resignFirstResponder];
}
@end
