//
//  MenuViewController.m
//  Footprint
//
//  Created by 张浩 on 15/5/26.
//  Copyright (c) 2015年 周德艺. All rights reserved.
//

#import "MenuViewController.h"
#import "PersonalTableViewCell.h"
#import "NearViewController.h"
#import "MMNavigationController.h"
#import "MapViewController.h"
#import "NearViewController.h"
#import "SetUpViewController.h"
#import "ReportViewController.h"
#import "AboutViewController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "AtdWallObject.h"

@interface MenuViewController ()

@end

@implementation MenuViewController
-(id)init{
    self = [super init];
    if(self){
        [self setRestorationIdentifier:@"MMExampleLeftSideDrawerController"];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self setTitle:@"个人中心"];
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    [rightBtn setTitle:@"地图" forState:UIControlStateNormal];
    [rightBtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [rightBtn addTarget:self action:@selector(mapVC) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    self.tableView.separatorColor = [UIColor colorWithRed:150/255.0f green:161/255.0f blue:177/255.0f alpha:1.0f];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.opaque = NO;
    self.tableView.backgroundColor = [UIColor clearColor];

}


#pragma mark - 获取数据 - 用户信息
-(void)getUserInfoByUserName :(NSString *)userName{
    NSString *parameters = [NSString stringWithFormat:@"%@",userName];
    [FtService GETmethod:kFinduserbyname andParameters:parameters andHandle:^(NSDictionary *myresult) {
        NSDictionary *result = myresult;
        int status = [[result objectForKey:@"status"]intValue];
        if (status == 1) {
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSDictionary *userDic = [result objectForKey:@"result"];
            self.user = [UserObject objectWithKeyValues:userDic];
            NSDictionary *userInfo = self.user.keyValues;
            [defaults setObject:userInfo forKey:USERINFO];
            [defaults synchronize];
            NSLog(@"%@",self.user);
        }
        else{
            NSLog(@"失败");
        }
    }];
}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *userDic = [defaults objectForKey:USERINFO];
    self.user = [UserObject objectWithKeyValues:userDic];
    [self getUserInfoByUserName:self.user.username];
    
    [self addTableHeader];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)contentSizeDidChangeNotification:(NSNotification*)notification{
    [self contentSizeDidChange:notification.userInfo[UIContentSizeCategoryNewValueKey]];
}

-(void)contentSizeDidChange:(NSString *)size{
    //Implement in subclass
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]
     removeObserver:self];
}


-(void)addTableHeader{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 160.0f)];
    self.button = [[UIButton alloc]initWithFrame:CGRectMake(0, 16, 100, 100)];
    self.button.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    self.button.layer.masksToBounds = YES;
    self.button.layer.cornerRadius = 50.0;
    self.button.layer.borderColor = [UIColor whiteColor].CGColor;
    self.button.layer.borderWidth = 3.0f;
    self.button.layer.rasterizationScale = [UIScreen mainScreen].scale;
    self.button.layer.shouldRasterize = YES;
    self.button.clipsToBounds = YES;
    NSString *imgurl = [NSString stringWithFormat:@"%@%@",KGetImage_URL,self.user.photourl];
    [self.button sd_setImageWithURL:[NSURL URLWithString:imgurl] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"userphoto"]];
    self.button.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [self.button addTarget:self action:@selector(goPerInfoVC) forControlEvents:UIControlEventTouchUpInside];
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 125, 0, 24)];
    self.label.text = self.user.truename;
    self.label.font = [UIFont systemFontOfSize:21];
    self.label.backgroundColor = [UIColor clearColor];
    self.label.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];
    [self.label sizeToFit];
    self.label.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    
    [view addSubview:self.label];
    [view addSubview:self.button];
    
    UIView *fview =[ [UIView alloc]init];
    fview.backgroundColor = [UIColor clearColor];
    
    [self.tableView setTableFooterView:fview];
    [self.tableView setTableHeaderView:view];
}


#pragma mark - 个人中心
-(void)goPerInfoVC{
    NSLog(@"----->>>>>>goperinfoVC");
    [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
        UINavigationController *naVC = (UINavigationController*)self.mm_drawerController.centerViewController;
        SetUpViewController *setVC = [[SetUpViewController alloc] initWithNibName:@"SetUpViewController" bundle:nil];
        [naVC pushViewController:setVC animated:NO];

        }];
}
#pragma mark - 地图
-(void)mapVC{
    [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
        UINavigationController *naVC = (UINavigationController*)self.mm_drawerController.centerViewController;
        NSArray *viewControllers = naVC.viewControllers;
        for (UIViewController *VC in viewControllers) {
            if ([VC.class isSubclassOfClass:[NearViewController class]]) {
                NearViewController *nearVC = (NearViewController *)VC;
                MapViewController *mapVC = [[MapViewController alloc]initWithNibName:@"MapViewController" bundle:nil];
                
                if ([[nearVC.tableArr objectAtIndex:0] isKindOfClass:[AtdWallObject class]]) {
                    [PublicObject showHUDView:self.parentViewController.view title:nil content:@"无地图模式" time:kHUDTime];
                }else{
                    mapVC.wallArr = nearVC.tableArr;
                    mapVC.user = nearVC.user;
                    [naVC pushViewController:mapVC animated:NO];
                }
            }
        }
    }];
}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)sectionIndex
{
    if (sectionIndex == 0)
        return nil;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 34)];
    view.backgroundColor = [UIColor colorWithRed:167/255.0f green:167/255.0f blue:167/255.0f alpha:0.6f];
 
    return view;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",(long)indexPath.row);
    switch (indexPath.section) {
        case MMDrawerSectionViewSelection:{
           
            if(indexPath.row==0){
                NearViewController * center = [[NearViewController alloc]initWithNibName:@"NearViewController" bundle:nil];
                
                UINavigationController * centernav = [[MMNavigationController alloc] initWithRootViewController:center];
                [self.mm_drawerController
                 setCenterViewController:centernav
                 withCloseAnimation:YES
                 completion:nil];
            }
            if(indexPath.row==1){
                [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
                    UINavigationController *naVC = (UINavigationController*)self.mm_drawerController.centerViewController;
                    NSArray *viewControllers = naVC.viewControllers;
                    for (UIViewController *VC in viewControllers) {
                        if ([VC.class isSubclassOfClass:[NearViewController class]]) {
                            NearViewController *nearVC = (NearViewController *)VC;
                            [nearVC getMyAllCollectWallArr];
                            nearVC.isCollect = YES;
                            nearVC.isMyWall = NO;
                            [nearVC.tableView setTableHeaderView:nil];
                            nearVC.title = @"我的收藏";
                        }
                    }
                }];
            }
            if(indexPath.row==2){
                ReportViewController *center = [[ReportViewController alloc]initWithNibName:@"ReportViewController" bundle:nil];
                
                UINavigationController * centernav = [[MMNavigationController alloc] initWithRootViewController:center];
                [self.mm_drawerController
                 setCenterViewController:centernav
                 withCloseAnimation:YES
                 completion:nil];
            }
            if(indexPath.row==3){
                AboutViewController *center = [[AboutViewController alloc]initWithNibName:@"AboutViewController" bundle:nil];
                
                UINavigationController * centernav = [[MMNavigationController alloc] initWithRootViewController:center];
                [self.mm_drawerController
                 setCenterViewController:centernav
                 withCloseAnimation:YES
                 completion:nil];
            }
            if(indexPath.row==4){
                //退出
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults removeObjectForKey:USERINFO];
                [defaults removeObjectForKey:PASSWORD];
                [defaults synchronize];
                [PublicObject showHUDView:self.view title:@"退出帐号成功" content:@"" time:kHUDTime];
                [self performSelector:@selector(backFucntion:) withObject:nil afterDelay:kHUDTime];
                
            }
            break;
        }
            
        default:
            break;
    }
    [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(IBAction)backFucntion:(id)sender{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    LoginViewController *loginVC = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    UINavigationController *loginNavi = [[UINavigationController alloc] initWithRootViewController:loginVC];

    
    appDelegate.window.rootViewController = loginNavi;

}
#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *titles = @[@"首页",@"我收藏的墙",@"举报",@"关于",@"退出"];
    NSArray *tableImageArray = @[@"favorite.png",@"xgzl.png",@"jcbb.png",@"zddl.png",@"about.png",@"tczh.png"];
    
    PersonalTableViewCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"PersonalTableViewCell" owner:self options:nil]firstObject];
    NSUInteger row = [indexPath row];
    cell.menuLabel.text = titles[indexPath.row];
    cell.menuImage.image = [UIImage imageNamed:tableImageArray[indexPath.row]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.rightImageView.hidden = YES;
    cell.menuSwitch.hidden = YES;
    if (row == 0) {
        cell.rightImageView.hidden = NO;
    } else if (row == 1) {
        cell.rightImageView.hidden = NO;
    } else if (row == 2) {
        cell.rightImageView.hidden = NO;
    } else if (row == 3) {
    } else if (row == 4) {
        cell.rightImageView.hidden = YES;
    }
    return cell;
    
}


@end
