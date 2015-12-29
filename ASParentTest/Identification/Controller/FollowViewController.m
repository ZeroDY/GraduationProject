//
//  FollowViewController.m
//  ASParentTest
//
//  Created by 张浩 on 15/11/21.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "FollowViewController.h"
#import "LocationObject.h"
//接口
#import "DYRequestBase+GetStudentLocation.h"
@interface FollowViewController ()

@end

@implementation FollowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"学生行踪";
    
    //下拉刷新
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.currentPage = 1;
        [self getLocationListWithCurrentPage:self.currentPage andRowOfPage:@"10"];
    }];
    // 上拉刷新方法1
    self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        if (self.currentPage == self.allPages) {
            [PublicObject showHUDView:self.view title:@"已经是最后一页" content:@"" time:1 andCodes:^{
                [self.tableView.footer endRefreshing];
            }];
        }else{
            self.currentPage++;
            [self getLocationListWithCurrentPage:self.currentPage andRowOfPage:@"10"];
        }
    }];
    
}
-(void)viewWillAppear:(BOOL)animated{
    self.dataArr = [[NSMutableArray alloc]init];
    [super viewWillAppear:YES];
    [self.tableView.header beginRefreshing];
}
-(void)getLocationListWithCurrentPage:(NSInteger)currentPage andRowOfPage:(NSString *)rowOfPage{
    {
        [DYRequestBase getStudentLocationByStudentId:self.stuObj.schoolcensus CurrentPageNum:[NSString stringWithFormat:@"%ld",(long)currentPage] RowOfPage:rowOfPage requestStartBlock:^{
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
                        LocationObject *locationObj = [LocationObject mj_objectWithKeyValues:dic];
                        [self.dataArr addObject:locationObj];
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
    //2.手写
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell.textLabel setTextColor:[UIColor blackColor]];
        cell.textLabel.font = [UIFont systemFontOfSize:18];
    }
    LocationObject *locationObj = [self.dataArr objectAtIndex:indexPath.row];
    
    NSString *place = [PublicObject convertNullString:locationObj.weizhiname];
    NSString *time = [PublicObject convertNullString:locationObj.addtime];
    
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:12]};
    CGSize labelSize = [time boundingRectWithSize:CGSizeMake(0, 21) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    UILabel *timeLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-40-labelSize.width, 12, labelSize.width, 21)];
    timeLab.font = [UIFont systemFontOfSize:12];
    timeLab.textColor = [UIColor darkGrayColor];
    
    UILabel *placeLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 12, SCREEN_WIDTH-16-labelSize.width, 21)];
    placeLab.font = [UIFont systemFontOfSize:14];
    placeLab.textColor = [UIColor darkGrayColor];
    
    
    placeLab.text = place;
    timeLab.text = time;
    
    [cell.contentView addSubview:placeLab];
    [cell.contentView addSubview:timeLab];
    
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

@end
