//
//  TeacherViewController.m
//  ASTeacher
//
//  Created by 周德艺 on 15/11/21.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "TeacherViewController.h"
#import "TeacherViewHeadCell.h"
#import "TeacherViewNormalCell.h"
#import "TeacherInfoViewController.h"
#import "LoginViewController.h"
#import "IdentificationViewController.h"
@interface TeacherViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)UITableView *tableView;


@end

@implementation TeacherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人中心";
    [self.view addSubview:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    AccoutObject *userObj = [PublicObject getUserInfoDefault];
    if(userObj == nil)
    {
        [self goToLoginVC];
    }else{
        [self.tableView reloadData];
    }
}

#pragma mark - tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(section == 0 || section == 1){
        return 1;
    }else
        return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (IS_IOS8_OR_ABOVE) {
        return UITableViewAutomaticDimension;
    }else{
        return 60;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    if (indexPath.section == 0) {
        static NSString *cellIdentifier = @"TeacherViewHeadCell";
        TeacherViewHeadCell *cell = (TeacherViewHeadCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            NSBundle *bundle = [NSBundle mainBundle];
            NSArray *nibArray = [bundle loadNibNamed:cellIdentifier owner:nil options:nil];
            cell = (TeacherViewHeadCell *)[nibArray objectAtIndex:0];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        cell.contentView.backgroundColor = MainColor;
        cell.backgroundColor = MainColor;
        //加载数据
        AccoutObject *userObj = [PublicObject getUserInfoDefault];
        cell.titleLab.text = userObj.nickname;
        cell.infoLab.text = userObj.pphone;
        return cell;
    }else{
        static NSString *cellIdentifier = @"TeacherViewNormalCell";
        TeacherViewNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (cell == nil) {
            NSBundle *bundle = [NSBundle mainBundle];
            NSArray *nibArray = [bundle loadNibNamed:cellIdentifier owner:nil options:nil];
            cell = (TeacherViewNormalCell *)[nibArray objectAtIndex:0];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        if (indexPath.section == 2) {
            switch (row) {
                case 0:
                    [cell.title_label setText:@"设置"];
                    [cell.title_imageView setImage:[UIImage imageNamed:@"personal_set.png"]];
                    cell.isNew_view.hidden = YES;
                    break;
                case 1:
                {
                    UIButton *quitBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 7, SCREEN_WIDTH-40, 30)];
                    [quitBtn setBackgroundColor:[UIColor redColor]];
                    [quitBtn setTintColor:[UIColor whiteColor]];
                    [quitBtn setTitle:@"退  出" forState:UIControlStateNormal];
                    [quitBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
                    quitBtn.layer.cornerRadius = quitBtn.frame.size.height / 2;
                    [quitBtn addTarget:self action:@selector(quitClick) forControlEvents:UIControlEventTouchUpInside];
                    [cell.contentView addSubview:quitBtn];
                    
                    cell.title_label.hidden = YES;
                    cell.title_imageView.hidden = YES;
                    cell.isNew_view.hidden = YES;
                    cell.accessoryType = UITableViewCellAccessoryNone;

                }
                    break;
                default:
                    break;
            }
            
        }else{
            switch (row) {
                case 0:
                {
                    [cell.title_label setText:@"我的认证学生"];
                    [cell.title_imageView setImage:[UIImage imageNamed:@"personal_identification.png"]];
                    cell.isNew_view.hidden =YES;
                }
                    break;
                default:
                    break;
            }
            
        }
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        TeacherInfoViewController *newVC = [[TeacherInfoViewController alloc]init];
        newVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:newVC animated:YES];
        self.navigationController.navigationBarHidden = NO;
    }else if(indexPath.section == 1){
        if(indexPath.row == 0){
            IdentificationViewController *identificationVC = [[IdentificationViewController alloc]init];
            identificationVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:identificationVC animated:YES];
            self.navigationController.navigationBarHidden = NO;
        }
    }else{
        
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView setTableFooterView:[[UIView alloc]init]];
        //[_tableView setSeparatorColor:[UIColor clearColor]];
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 45;
    }
    return _tableView;
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
//退出
-(void)quitClick{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:kUserInfoDefault];
    [defaults removeObjectForKey:kPassword];
    [defaults removeObjectForKey:kPhoneNumber];
    [defaults synchronize];
    AccoutObject *userObj= [PublicObject getUserInfoDefault];
    if (userObj == nil) {
        [PublicObject showHUDView:self.view title:@"退出成功" content:@"" time:kHUDTime andCodes:^{
            [self.navigationController popToRootViewControllerAnimated:YES];
        }];
    }
    
}

@end
