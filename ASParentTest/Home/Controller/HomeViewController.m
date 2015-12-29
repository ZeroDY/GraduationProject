//
//  HomeViewController.m
//  ASParentTest
//
//  Created by 周德艺 on 15/11/17.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeTableViewCell.h"
#import "ChengJiViewController.h"
#import "ZhiYanViewController.h"
#import "AdvertScrollView.h"
#import "TeacherViewController.h"
#import "LoginViewController.h"
#import "NewsDetailViewController.h"
#import "NoticeViewController.h"
@interface HomeViewController ()<adScrollViewDelegate>

@property (nonatomic, strong) UIButton *scoreBtn;
@property (nonatomic, strong) UIButton *wishBtn;

@end

@implementation HomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"主页";
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_tableView setTableFooterView:[[UIView alloc]init]];
    [_tableView setSeparatorColor:[UIColor clearColor]];
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.estimatedRowHeight = 60;
    
    //通知按钮
    UIButton* rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,30,30)];
    [rightButton setImage:[UIImage imageNamed:@"identification_studentCommunication.png"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(presentRightVC) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem= rightItem;
}
//通知
-(void)presentRightVC{
    NoticeViewController *noticeVC = [[NoticeViewController alloc]initWithNibName:@"NoticeViewController" bundle:nil];
    noticeVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:noticeVC animated:YES];

}
#pragma mark - tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row != 0) {
        return UITableViewAutomaticDimension;
    }else{
        return 180;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    static NSString *cellIdentifier = @"HomeTableViewCell";
    static NSString *headCellIdentifier = @"HeadCell";
    static NSString *toolCellIdentifier = @"ToolCell";
    if (row == 0) {
        UITableViewCell *headCell = [tableView dequeueReusableCellWithIdentifier:headCellIdentifier];
        if (headCell == nil) {
            headCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:headCellIdentifier];
            [headCell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
            //创建adScrollView
            AdvertScrollView* adScrollView=[[AdvertScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180)];
            adScrollView.layer.cornerRadius = 5;
            adScrollView.adScrollViewDelegate = self;
            [headCell addSubview:adScrollView];
            //假数据(轮播图片的假数据)
            NSDictionary *dic1 = [[NSDictionary alloc]initWithObjectsAndKeys:@"lab1",@"titleName",@"pic-21.png",@"picUrl", nil];
            NSDictionary *dic2 = [[NSDictionary alloc]initWithObjectsAndKeys:@"lab1",@"titleName",@"pic-22.png",@"picUrl", nil];
            NSDictionary *dic3 = [[NSDictionary alloc]initWithObjectsAndKeys:@"lab1",@"titleName",@"pic-20.png",@"picUrl", nil];
            
            [adScrollView.topNewsArray addObject:dic1];
            [adScrollView.topNewsArray addObject:dic2];
            [adScrollView.topNewsArray addObject:dic3];
            
            //            [headCell mas_makeConstraints:^(MASConstraintMaker *make) {
            //                make.height.mas_equalTo(180.0);
            //                make.edges.mas_equalTo(0.0);
            //            }];
            //            [adScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            //                make.edges.mas_equalTo(0);
            //            }];
            
            [adScrollView setUpBigView];
        }
        return headCell;
    }else if (row == 1){
        UITableViewCell *toolCell = [tableView dequeueReusableCellWithIdentifier:toolCellIdentifier];
        if (toolCell == nil) {
            toolCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:toolCellIdentifier];
            [toolCell setSelectionStyle:UITableViewCellSelectionStyleNone];
            [toolCell addSubview:self.wishBtn];
            [toolCell addSubview:self.scoreBtn];
            //志愿查询
            [self.wishBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            [self.wishBtn setBackgroundColor:[UIColor whiteColor]];
            [self.wishBtn setImage:[UIImage imageNamed:@"search_dark.png"] forState:UIControlStateNormal];
            self.wishBtn.imageEdgeInsets = UIEdgeInsetsMake(self.wishBtn.frame.size.height/2, self.wishBtn.frame.size.width-self.wishBtn.titleLabel.bounds.size.width-20, 0, 0);//设置image在button上的位置 上左下右
            //成绩查询
            [self.scoreBtn setImage:[UIImage imageNamed:@"search_white.png"] forState:UIControlStateNormal];
            self.scoreBtn.imageEdgeInsets = UIEdgeInsetsMake(self.scoreBtn.frame.size.height/2, self.scoreBtn.frame.size.width-self.scoreBtn.titleLabel.bounds.size.width-20, 0, 0);//设置image在button上的位置 上左下右

            
            [self.scoreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.left.mas_equalTo(0.5);
                make.bottom.mas_equalTo(0.5);
                make.height.mas_equalTo(44.0);
                make.width.equalTo(self.wishBtn.mas_width);
            }];
            [self.wishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(0.5);
                make.left.mas_equalTo(self.scoreBtn.mas_right).offset(0.5f);
                make.height.mas_equalTo(44.0);
                make.right.mas_equalTo(-0.5);
            }];
            
        }
        return toolCell;
    }
    
    else{
        HomeTableViewCell *cell = (HomeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            NSBundle *bundle = [NSBundle mainBundle];
            NSArray *nibArray = [bundle loadNibNamed:cellIdentifier owner:nil options:nil];
            cell = (HomeTableViewCell *)[nibArray objectAtIndex:0];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        cell.delegate = self;
        return cell;
    }
}
-(void)showNewsView{
    [self.tabBarController setSelectedIndex:1];
}
-(void)showNewsDetail{
    NewsDetailViewController *newsDetailVC = [[NewsDetailViewController alloc]initWithNibName:@"NewsDetailViewController" bundle:nil];
    newsDetailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:newsDetailVC animated:YES];
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
    kLastSelectedIndex = 0;
    
    TeacherViewController *pVC = [[TeacherViewController alloc]init];
    pVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:pVC animated:YES];
}
/**
 *	成绩查询
 */
- (IBAction)selectScore:(id)sender{
    
    ChengJiViewController *pVC = [[ChengJiViewController alloc]init];
    pVC.title = @"成绩查询";
    [self.navigationController pushViewController:pVC animated:YES];
}
/**
 *	志愿查询
 */
- (IBAction)selectWish:(id)sender{
    
    ChengJiViewController *pVC = [[ChengJiViewController alloc]init];
    pVC.title = @"志愿查询";
    [self.navigationController pushViewController:pVC animated:YES];
    
    //    ZhiYanViewController *newVC = [[ZhiYanViewController alloc]initWithNibName:@"ZhiYanViewController" bundle:nil];
    //    [self.navigationController pushViewController:newVC animated:YES];
}

#pragma mark - getter and setter
- (UIButton *)scoreBtn{
    if (_scoreBtn == nil) {
        _scoreBtn = [[UIButton alloc]init];
        [_scoreBtn setBackgroundColor:MainColor];
        [_scoreBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_scoreBtn setTitle:@"成绩查询" forState: UIControlStateNormal];
        [_scoreBtn addTarget:self action:@selector(selectScore:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _scoreBtn;
}
- (UIButton *)wishBtn{
    if (_wishBtn == nil) {
        _wishBtn = [[UIButton alloc]init];
        [_wishBtn setBackgroundColor:MainColor];
        [_wishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_wishBtn setTitle:@"志愿查询" forState: UIControlStateNormal];
        [_wishBtn addTarget:self action:@selector(selectWish:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _wishBtn;
}


@end
