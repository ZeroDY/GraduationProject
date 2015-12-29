//
//  JyxcViewController.m
//  ASParentTest
//
//  Created by 张浩 on 15/11/20.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "JyxcViewController.h"
#import "JyxcTableViewCell.h"
#import "AddJyxcViewController.h"
#import "JyxcDetailViewController.h"
#import "JyxcObject.h"
//接口
#import "DYRequestBase+GetSuggestionList.h"
@interface JyxcViewController ()

@end

@implementation JyxcViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"建言献策";
    //导航栏右侧按钮
    UIButton* rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,60,30)];
    [rightButton setTitle:@"添加" forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize: 14];
    [rightButton addTarget:self action:@selector(presentRightVC) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem= rightItem;
    
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.backgroundColor = BackGroundColor;
    
    //下拉刷新
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.currentPage = 1;
        [self getJyxcListWithCurrentPage:self.currentPage andRowOfPage:@"10"];
    }];
    // 上拉刷新方法1
    self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        if (self.currentPage == self.allPages) {
            [PublicObject showHUDView:self.view title:@"已经是最后一页" content:@"" time:1 andCodes:^{
                [self.tableView.footer endRefreshing];
            }];
        }else{
            self.currentPage++;
            [self getJyxcListWithCurrentPage:self.currentPage andRowOfPage:@"10"];
        }
    }];
    
}
-(void)getJyxcListWithCurrentPage:(NSInteger)currentPage andRowOfPage:(NSString *)rowOfPage{
    
    AccoutObject *userObj = [PublicObject getUserInfoDefault];
    [DYRequestBase getSuggestionListByUserId:userObj.idcode CurrentPageNum:[NSString stringWithFormat:@"%ld",(long)currentPage] RowOfPage:rowOfPage requestStartBlock:^{
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
                NSArray *objArr = [dataObj objectForKey:@"list"];
                NSLog(@"%@",objArr);
                //json转对象
                for (int i = 0; i < objArr.count; i++) {
                    NSDictionary *dic = [objArr objectAtIndex:i];
                    JyxcObject *jyxcObj = [JyxcObject mj_objectWithKeyValues:dic];
                    [self.dataArr addObject:jyxcObj];
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

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.dataArr = [[NSMutableArray alloc]init];
    [self.tableView.header beginRefreshing];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)presentRightVC{
    AddJyxcViewController *addJyxcVC = [[AddJyxcViewController alloc]initWithNibName:@"AddJyxcViewController" bundle:nil];
    [self.navigationController pushViewController:addJyxcVC animated:YES];
}

#pragma tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //1.加载xib
    static NSString *CellIdentifier = @"JyxcTableViewCell";
    JyxcTableViewCell *cell = (JyxcTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        NSBundle *bundle = [NSBundle mainBundle];
        NSArray *nibArray = [bundle loadNibNamed:CellIdentifier owner:self options:nil];
        cell = (JyxcTableViewCell *)[nibArray objectAtIndex:0];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    //数据
        JyxcObject *jyxcObj = [self.dataArr objectAtIndex:indexPath.row];
        cell.titleLab.text = [PublicObject convertNullString:jyxcObj.sheader];
        cell.objectLab.text = [NSString stringWithFormat:@"建言对象:%@",[PublicObject convertNullString:jyxcObj.getpeoplestyle]];
        cell.titleLab.text = [PublicObject convertNullString:jyxcObj.addtime];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    JyxcObject *jyxcObj = [self.dataArr objectAtIndex:indexPath.row];
    JyxcDetailViewController *jyxcDetailVC = [[JyxcDetailViewController alloc]initWithNibName:@"JyxcDetailViewController" bundle:nil];
    jyxcDetailVC.idCode = jyxcObj.idcode;
    [self.navigationController pushViewController:jyxcDetailVC animated:YES];
}

@end
