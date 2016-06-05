//
//  NearViewController.m
//  FootprintWall
//
//  Created by 张浩 on 15/4/15.
//  Copyright (c) 2015年 张浩. All rights reserved.
//

#import "NearViewController.h"
#import "MapViewController.h"
#import "WallObject.h"
#import "NearWallTableViewCell.h"
#import "MessageViewController.h"
#import "CollectWallObject.h"
#import "MessageCollectionViewController.h"
#import <MapKit/MapKit.h>
#import "UIViewController+MMDrawerController.h"
#import "MenuViewController.h"
#import "MMNavigationController.h"
#import "BuildViewController.h"
#import "AtdWallObject.h"
#import "AtdTableViewCell.h"
#import "MZTimerLabel.h"
#import "AtdWallViewController.h"

typedef NS_ENUM(NSInteger, MMCenterViewControllerSection){
    MMCenterViewControllerSectionLeftViewState,
    MMCenterViewControllerSectionLeftDrawerAnimation,
    MMCenterViewControllerSectionRightViewState,
    MMCenterViewControllerSectionRightDrawerAnimation,
};
@interface NearViewController ()<UIScrollViewDelegate>
@end

@implementation NearViewController
- (id)init
{
    self = [super init];
    if (self) {
        [self setRestorationIdentifier:@"MMExampleCenterControllerRestorationKey"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"附近";
    //数组初始化
    self.isCollect = NO;
    self.collectArr = [[NSMutableArray alloc]init];
    //导航栏右侧的新建按钮
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    [rightBtn setTitle:@"新建" forState:UIControlStateNormal];
    [rightBtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [rightBtn addTarget:self action:@selector(buildNewWall) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 38, 38)];
    NSString *imgurl = [NSString stringWithFormat:@"%@%@",KGetImage_URL,self.user.photourl];
    [leftBtn sd_setImageWithURL:[NSURL URLWithString:imgurl] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"userphoto"]];
    leftBtn.clipsToBounds = YES;
    leftBtn.layer.masksToBounds = YES;
    leftBtn.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    leftBtn.layer.borderWidth = 2.0f;
    leftBtn.layer.cornerRadius = leftBtn.frame.size.width / 2;
    [leftBtn addTarget:self action:@selector(leftDrawerButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    
    [self.tableView setSeparatorColor:[UIColor clearColor]];
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    self.boxView.frame = CGRectMake(self.boxView.frame.origin.x, self.boxView.frame.origin.y, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.tableView.frame = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.boxView];
}

-(void)viewWillAppear:(BOOL)animated{
    [self reloadData];
    [[RefreshLocation shareInstance]RefreshLocationLable:self.location_Label andBlock:^{
        [self reloadData];
    }];
    
}

#pragma mark - Button Handlers
-(void)leftDrawerButtonPress:(id)sender{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}
#pragma mark - 新建墙
-(void)buildNewWall{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"选择新建留言墙类型" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"公 开 墙" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"公开");
        BuildViewController *buildVC = [[BuildViewController alloc] initWithNibName:@"BuildViewController" bundle:nil];
        buildVC.wallType = 1;
        [self presentViewController:buildVC animated:YES completion:^{ }];
    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"私 密 墙" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"私密留言墙");
        BuildViewController *buildVC = [[BuildViewController alloc] initWithNibName:@"BuildViewController" bundle:nil];
        buildVC.wallType = 0;
        [self presentViewController:buildVC animated:YES completion:^{        }];
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"签 到 墙" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"签到留言墙");
        BuildViewController *buildVC = [[BuildViewController alloc] initWithNibName:@"BuildViewController" bundle:nil];
        buildVC.wallType = 3;
        [self presentViewController:buildVC animated:YES completion:^{}];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取 消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"取 消");
    }];
    
    [alertController addAction:action1];
    [alertController addAction:action2];
    [alertController addAction:action3];
    [alertController addAction:cancelAction];
    
    
    [self presentViewController:alertController animated:YES completion:nil];
}


-(void)buildTableHeader{
    self.headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].applicationFrame.size.width, 40)];
    [self.headerView setBackgroundColor:[UIColor clearColor]];
    if (self.isMyWall) {
        self.segment = [[UISegmentedControl alloc]initWithItems:[NSArray arrayWithObjects:@"公开墙",@"私密墙",@"签到墙",nil]];
    }else{
        self.segment = [[UISegmentedControl alloc]initWithItems:[NSArray arrayWithObjects:@"公开墙",@"签到墙",nil]];
    }
    [self.segment setFrame:self.headerView.frame];
    [self.segment setBackgroundColor:[UIColor whiteColor]];
    [self.segment setTintColor:[UIColor groupTableViewBackgroundColor]];
    [self.segment setSelectedSegmentIndex:0];
    [self.segment addTarget:self action:@selector(changeTable) forControlEvents:UIControlEventValueChanged];
    NSDictionary *dicNormal = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor darkGrayColor],UITextAttributeTextColor,  [UIFont systemFontOfSize:15],UITextAttributeFont,[UIColor darkGrayColor],UITextAttributeTextShadowColor ,nil];
    
    NSDictionary *dicSelected = [NSDictionary dictionaryWithObjectsAndKeys:NavigationColor,UITextAttributeTextColor,  [UIFont systemFontOfSize:16.f],UITextAttributeFont ,[UIColor whiteColor],UITextAttributeTextShadowColor ,nil];
    
    [self.segment setTitleTextAttributes:dicNormal forState:UIControlStateNormal];
    [self.segment setTitleTextAttributes:dicSelected forState:UIControlStateSelected];
    
    [self.headerView addSubview:self.segment];
    [self.tableView setTableHeaderView:self.headerView];
}
-(void)changeTable{
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
#pragma mark - 获取数据
-(void)reloadData{
    [self getNearWallArr:KLongitude andy:KLatitude];
    [self getNearAtdWallArr:KLongitude andy:KLatitude];
    [self getMyAllWallArr:self.user.username];
    [self getMyAtdAllWallArr:self.user.username];
    [self getCollectWallArr];
}

#pragma mark - 获取数据 - 附近的墙
-(void)getNearWallArr:(double)x andy:(double)y{
    NSString *parameters = [NSString stringWithFormat:@"%f,%f",x,y];
    [FtService GETmethod:KFindWallsByXY andParameters:parameters andHandle:^(NSDictionary *myresult) {
        NSDictionary *result = myresult;
        int status = [[result objectForKey:@"status"]intValue];
        if (status == 1) {
            self.nearWallArr = [[NSMutableArray alloc]init];
            NSArray *wallDic = [result objectForKey:@"result"];
            NSArray *walls = [WallObject objectArrayWithKeyValuesArray:wallDic];
            self.nearWallArr = [[NSMutableArray alloc]initWithArray:walls];
            for (WallObject *w in self.nearWallArr) {
                [w dateFormat];
                w.isCollect = NO;
                for (CollectWallObject *collectWll in self.collectArr) {
                    if ([w.wallid isEqualToString:collectWll.wallid]) {
                        w.isCollect = YES;
                        break;
                    }
                }
            }
            [self.tableView reloadData];
        }
        else{
            NSLog(@"失败");
        }
    }];
}
#pragma mark - 获取数据 - 附近的签到墙
-(void)getNearAtdWallArr:(double)x andy:(double)y{
    NSString *parameters = [NSString stringWithFormat:@"%f,%f",x,y];
    [FtService GETmethod:KFindAtdWallsByXY andParameters:parameters andHandle:^(NSDictionary *myresult) {
        NSDictionary *result = myresult;
        int status = [[result objectForKey:@"status"]intValue];
        self.nearAtdWallArr  =  [[NSMutableArray alloc]init];
        if (status == 1) {
            NSArray *wallDic = [result objectForKey:@"result"];
            NSArray *walls = [AtdWallObject objectArrayWithKeyValuesArray:wallDic];
            self.nearAtdWallArr = [[NSMutableArray alloc]initWithArray:walls];
            [self.tableView reloadData];
        }
        else{
            NSLog(@"失败");
        }
    }];
}
#pragma mark - 获取数据 - 我的所有墙
-(void)getMyAllWallArr:(NSString *)username{
    [FtService GETmethod:KFindSetWallsByUN andParameters:self.user.username andHandle:^(NSDictionary *myresult) {
        NSDictionary *result = myresult;
        int status = [[result objectForKey:@"status"]intValue];
        self.myAllWallArr = [[NSMutableArray alloc]init];
        self.myPublicWallArr = [[NSMutableArray alloc]init];
        self.myPrivateWallArr = [[NSMutableArray alloc]init];
        if (status == 1) {
            NSArray *wallDic = [result objectForKey:@"result"];
            NSArray *walls = [WallObject objectArrayWithKeyValuesArray:wallDic];
            self.myAllWallArr = [[NSMutableArray alloc]initWithArray:walls];
            for (WallObject *w in self.myAllWallArr) {
                [w dateFormat];
                switch (w.walltype.intValue) {
                    case 1:
                        [self.myPublicWallArr addObject:w];
                        break;
                    case 0:
                        [self.myPrivateWallArr addObject:w];
                        break;
                    default:
                        break;
                }
            }
            [self.tableView reloadData];
        }
        else{
            NSLog(@"失败");
        }
    }];
}
#pragma mark - 获取数据 - 所有收藏墙
-(void)getMyAllCollectWallArr{
    [FtService GETmethod:KFindCollectWallsByUN andParameters:self.user.username andHandle:^(NSDictionary *myresult) {
        NSDictionary *result = myresult;
        int status = [[result objectForKey:@"status"]intValue];
        self.myCollectWallArr = [[NSMutableArray alloc]init];
        if (status == 1) {
            NSArray *wallDic = [result objectForKey:@"result"];
            NSArray *walls = [WallObject objectArrayWithKeyValuesArray:wallDic];
            self.myCollectWallArr = [[NSMutableArray alloc]initWithArray:walls];
            for (WallObject *w in self.myCollectWallArr) {
                [w dateFormat];
                w.isCollect = YES;
            }
            [self.tableView reloadData];
        }
        else{
            NSLog(@"失败");
        }
    }];
}
#pragma mark - 获取数据 - 我的签到墙
-(void)getMyAtdAllWallArr:(NSString *)username{
    [FtService GETmethod:KFindAtdWallsByUN andParameters:self.user.username andHandle:^(NSDictionary *myresult) {
        NSDictionary *result = myresult;
        int status = [[result objectForKey:@"status"]intValue];
        self.myAtdWallArr  =  [[NSMutableArray alloc]init];
        if (status == 1) {
            NSArray *wallDic = [result objectForKey:@"result"];
            NSArray *walls = [AtdWallObject objectArrayWithKeyValuesArray:wallDic];
            self.myAtdWallArr = [[NSMutableArray alloc]initWithArray:walls];
            [self.tableView reloadData];
        }
        else{
            NSLog(@"失败");
        }
    }];
}
#pragma mark - 获取数据 - 收藏信息
-(void)getCollectWallArr{
    [FtService GETmethod:KFindCollectByUN andParameters:self.user.username andHandle:^(NSDictionary *myresult) {
        NSDictionary *result = myresult;
        int status = [[result objectForKey:@"status"]intValue];
        self.collectArr  =  [[NSMutableArray alloc]init];
        if (status == 1) {
            NSArray *wallDic = [result objectForKey:@"result"];
            NSArray *conllectWalls = [CollectWallObject objectArrayWithKeyValuesArray:wallDic];
            self.collectArr = [[NSMutableArray alloc]initWithArray:conllectWalls];
            for (WallObject *w in self.nearWallArr) {
                w.isCollect = NO;
                for (CollectWallObject *collectWll in self.collectArr) {
                    if ([w.wallid isEqualToString:collectWll.wallid]) {
                        w.isCollect = YES;
                        break;
                    }
                }
            }
            [self.tableView reloadData];
        }
        else{
            NSLog(@"失败");
        }
    }];
}
#pragma  mark - 收藏
- (IBAction)collect:(id)sender {
    UIButton *button = (UIButton *)sender;
    WallObject *wall = [self.nearWallArr objectAtIndex:button.tag];
    NSString *params = [NSString stringWithFormat:@"%@,%@",self.user.username,wall.wallid];
    
    [FtService GETmethod:KCollectWall andParameters:params andHandle:^(NSDictionary *myresult) {
        NSDictionary *result = myresult;
        int status = [[result objectForKey:@"status"]intValue];
        if (status == 1) {
            [self reloadData];
        }
        else{
            NSLog(@"失败");
        }
    }];
}


#pragma mark UITableView Datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.isCollect) {
        self.tableArr = self.myCollectWallArr;
    }else{
        if (self.isMyWall) {
            switch (self.segment.selectedSegmentIndex) {
                case 0:
                    self.tableArr = self.myPublicWallArr;
                    break;
                case 1:
                    self.tableArr = self.myPrivateWallArr;
                    break;
                case 2:
                    self.tableArr = self.myAtdWallArr;
                    break;
                default:
                    return 0;
                    break;
            }
        }else{
            switch (self.segment.selectedSegmentIndex) {
                case 0:
                    self.tableArr = self.nearWallArr;
                    break;
                case 1:
                    self.tableArr = self.nearAtdWallArr;
                    break;
                default:
                    return 0;
                    break;
            }
        }
    }
    
    if(self.tableArr.count == 0){
        return 1;
    }
    return self.tableArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger i = indexPath.row;
    UITableViewCell *cell = [[UITableViewCell alloc]initWithFrame:self.view.frame];
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:self.view.frame];
    imageview.image = [UIImage imageNamed:@"def"];
    [cell addSubview:imageview];
    if(self.tableArr.count == 0){
        return cell;
    }else{
        NSObject *obj = [self.tableArr objectAtIndex:0];
        if ([obj isKindOfClass:[WallObject class]]) {
            WallObject *wall = [self.tableArr objectAtIndex:i];
            static NSString *cellIdentifier = @"NearWallTableViewCell";
            NearWallTableViewCell *cell = (NearWallTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                NSBundle *bundle = [NSBundle mainBundle];
                NSArray *nibArray = [bundle loadNibNamed:@"NearWallTableViewCell" owner:self options:nil];
                cell = (NearWallTableViewCell *)[nibArray objectAtIndex:0];
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                cell.wallName_Label.text = wall.wallname;
                cell.wallInfo_Label.text = wall.wallsignature;
                cell.wallLocation_Label.text = wall.walladress;
                cell.wallTime_Label.text = wall.wallcreattime;
                NSString *imgName = [NSString stringWithFormat:@"%@%@",KGetImage_URL,wall.wallimage];
                [cell.wallImage sd_setImageWithURL:[NSURL URLWithString:imgName] placeholderImage:[UIImage imageNamed:@"wall_image01"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    
                }];
                if (self.isMyWall) {
                    cell.collect_btn.hidden = YES;
                }else{
                    cell.collect_btn.tag = i;
                    [cell.collect_btn addTarget:self action:@selector(collect:) forControlEvents:UIControlEventTouchUpInside];
                    if (wall.isCollect) {
                        [cell.collect_btn setImage:[UIImage imageNamed:@"shoucang1"] forState:UIControlStateNormal];

                    }
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            return cell;
        }else{
            AtdWallObject *wall = [self.tableArr objectAtIndex:i];
            static NSString *cellIdentifier = @"AtdTableViewCell";
            AtdTableViewCell *cell = (AtdTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                NSBundle *bundle = [NSBundle mainBundle];
                NSArray *nibArray = [bundle loadNibNamed:@"AtdTableViewCell" owner:self options:nil];
                cell = (AtdTableViewCell *)[nibArray objectAtIndex:0];
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                cell.nameLab.text = wall.atdwallname;
                if (wall.atdwallstatus) {
                    NSDate *date=[NSDate date];
                    NSTimeInterval interval = [date timeIntervalSince1970];
                    NSInteger nowTime = interval;
                    MZTimerLabel *timer = [[MZTimerLabel alloc] initWithLabel:cell.dateLab andTimerType:MZTimerLabelTypeTimer];
                    [timer setCountDownTime:(wall.atdwallcreattime.longLongValue/1000+3600-nowTime)];
                    [timer start];
                }else{
                    cell.dateLab.text = @"已结束";
                }
                
            }
            return cell;
        }
        return cell;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.tableArr.count!=0) {
        NSObject *obj = [self.tableArr objectAtIndex:0];
        if ([obj isKindOfClass:[WallObject class]]) {
            MessageCollectionViewController *msgVC = [[MessageCollectionViewController alloc]initWithNibName:@"MessageCollectionViewController" bundle:nil];
            msgVC.wall = self.tableArr[indexPath.row];
            msgVC.user = self.user;
            self.isTable = YES;
            [self.navigationController pushViewController:msgVC animated:YES];
        }else{
            AtdWallViewController *atdVC = [[AtdWallViewController alloc]initWithNibName:@"AtdWallViewController" bundle:nil];
            atdVC.user = self.user;
            atdVC.atdWall = self.tableArr[indexPath.row];
            self.isTable = YES;
            [self.navigationController pushViewController:atdVC animated:YES];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(self.tableArr.count == 0){
        return self.view.frame.size.height;
    }else{
        NSObject *obj = [self.tableArr objectAtIndex:0];
        if ([obj isKindOfClass:[WallObject class]]) {
            return 120;
        }else{
            return 100;
        }
    }
}

#pragma mark 左划删除
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isMyWall) {
        return YES;
    }else{
        return NO;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger index = indexPath.row;
    if (self.segment.selectedSegmentIndex == 2) {
        AtdWallObject *atdwall = [self.tableArr objectAtIndex:index];
        NSString *parm = [NSString stringWithFormat:@"%@,%@",atdwall.atdwallid,self.user.username];
        [FtService GETmethod:KDeleteAtdWall andParameters:parm andHandle:^(NSDictionary *myresult) {
            NSDictionary *result = myresult;
            int status = [[result objectForKey:@"status"]intValue];
            if (status == 1) {
                [self.tableArr removeObjectAtIndex:index];
                [self.tableView reloadData];
            }
            else{
                NSLog(@"失败");
                [self.tableView reloadData];
            }
        }];
    }else{
        WallObject *wall = [self.tableArr objectAtIndex:index];
        if ( ((wall.xcoordinate-0.01) < KLongitude) && (KLongitude< (wall.xcoordinate+0.01)) && ((wall.ycoordinate-0.01) < KLatitude) && (KLatitude < (wall.ycoordinate+0.01))) {
            NSString *parm = [NSString stringWithFormat:@"%@,%@",wall.wallid,self.user.username];
            [FtService GETmethod:KDeleteWall andParameters:parm andHandle:^(NSDictionary *myresult) {
                NSDictionary *result = myresult;
                int status = [[result objectForKey:@"status"]intValue];
                if (status == 1) {
                    [self.tableArr removeObjectAtIndex:index];
                    [self.tableView reloadData];
                }
                else{
                    NSLog(@"失败");
                    [self.tableView reloadData];
                }
            }];
        }else{
            [PublicObject showHUDView:self.view title:@"不在此墙附近，无法删除" content:@"" time:kHUDTime];
        }
        
    }
    
}
- (UITableViewCellEditingStyle)tableView: (UITableView *)tableView editingStyleForRowAtIndexPath: (NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}


- (IBAction)getLocation:(id)sender {
    self.location_Label.text = @"正在重新定位……";
    [[RefreshLocation shareInstance]RefreshLocationLable:self.location_Label andBlock:^{
        [self reloadData];
    }];
}
- (IBAction)clickBtn1:(id)sender {
    self.isMyWall = NO;
    self.isCollect = NO;
    [UIView beginAnimations:@"boxview" context:(__bridge void *)(self.boxView)];
    [UIView setAnimationDuration:.5f];
    [UIView setAnimationDelegate:self];
    self.boxView.frame = CGRectMake(0, -self.boxView.frame.size.height, self.boxView.frame.size.width, self.boxView.frame.size.height);
    [UIView commitAnimations];
    [self buildTableHeader];
    [self.tableView reloadData];
    self.title = @"附近";
}
- (IBAction)clickBtn2:(id)sender {
    self.isMyWall = YES;
    self.isCollect = NO;
    [UIView beginAnimations:@"boxview" context:(__bridge void *)(self.boxView)];
    [UIView setAnimationDuration:.5f];
    [UIView setAnimationDelegate:self];
    self.boxView.frame = CGRectMake(0, -self.boxView.frame.size.height, self.boxView.frame.size.width, self.boxView.frame.size.height);
    [UIView commitAnimations];
    [self buildTableHeader];
    [self.tableView reloadData];
    self.title = @"我的留言墙";
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.tableView) {
        if (self.tableView.contentOffset.y<-180) {
            NSLog(@"==========>begin refreshing");
            [UIView beginAnimations:@"boxview1" context:(__bridge void *)(self.boxView)];
            [UIView setAnimationDuration:0.5f];
            [UIView setAnimationDelegate:self];
            [self.boxView setFrame:self.view.frame];
            [UIView commitAnimations];
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.tableView.contentOffset.y<-120) {
        [self reloadData];
    }
}


@end
