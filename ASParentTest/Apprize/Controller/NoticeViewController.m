//
//  NoticeViewController.m
//  ASTeacher
//
//  Created by 周德艺 on 15/11/24.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "NoticeViewController.h"
#import "NoticeViewCell.h"
#import "NoticeInfoViewController.h"
#import "NoticeObject.h"
//接口
#import "DYRequestBase+GetUserMessageList.h"
@interface NoticeViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) UIBarButtonItem *saveNoticeItem;
@property (nonatomic, strong) NSMutableArray *sendNoticeArray;
@property (nonatomic, strong) NSMutableArray *receiveNoticeArray;

@end

@implementation NoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"通知";
    self.navigationItem.rightBarButtonItem = self.saveNoticeItem;
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_tableView setTableFooterView:[[UIView alloc]init]];
    //[_tableView setSeparatorColor:[UIColor clearColor]];
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.estimatedRowHeight = 52;
    
    //下拉刷新
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.currentPage = 1;
        [self getAllNoticeWithCurrentPage:self.currentPage andRowOfPage:@"10"];
    }];
    // 上拉刷新方法1
    self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        if (self.currentPage == self.allPages) {
            [PublicObject showHUDView:self.view title:@"已经是最后一页" content:@"" time:1 andCodes:^{
                [self.tableView.footer endRefreshing];
            }];
        }else{
            self.currentPage++;

        [self getAllNoticeWithCurrentPage:self.currentPage andRowOfPage:@"10"];
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.receiveNoticeArray = [[NSMutableArray alloc]init];
    [self.tableView.header beginRefreshing];
    
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
}
- (void)getAllNoticeWithCurrentPage:(NSInteger)currentPage andRowOfPage:(NSString *)rowOfPage{
    AccoutObject *userObj = [PublicObject getUserInfoDefault];
    
    [DYRequestBase getUserMessageListByUserId:userObj.idcode CurrentPageNum:[NSString stringWithFormat:@"%ld",(long)currentPage] RowOfPage:rowOfPage requestStartBlock:^{
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
                self.receiveNoticeArray = [NoticeObject mj_objectArrayWithKeyValuesArray:objArr];
                [self.tableView reloadData];
            }
            else {
                [PublicObject showHUDView:self.view title:msg content:@"" time:kHUDTime andCodes:^{
                }];
            }
        }else{
            [PublicObject showHUDView:self.view title:@"请求失败" content:@"" time:kHUDTime andCodes:^{
            }];
        }    }];
}

#pragma mark - tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.receiveNoticeArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (IS_IOS8_OR_ABOVE) {
        return UITableViewAutomaticDimension;
    }else{
        return 52;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    NoticeObject *notice;
    notice = self.receiveNoticeArray[row];
    static NSString *cellIdentifier = @"NoticeViewCell";
    NoticeViewCell *cell = (NoticeViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        NSBundle *bundle = [NSBundle mainBundle];
        NSArray *nibArray = [bundle loadNibNamed:cellIdentifier owner:nil options:nil];
        cell = (NoticeViewCell *)[nibArray objectAtIndex:0];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    cell.isNew_view.hidden = NO;
    [cell loadData:notice];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NoticeInfoViewController *newVC = [[NoticeInfoViewController alloc]initWithNibName:@"NoticeInfoViewController" bundle:nil];
    NoticeObject *notice = self.receiveNoticeArray[indexPath.row];
    newVC.noticeid = notice.idcode;
    [self.navigationController pushViewController:newVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
