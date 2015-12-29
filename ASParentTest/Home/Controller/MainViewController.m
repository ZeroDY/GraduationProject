//
//  MainViewController.m
//  ASParentTest
//
//  Created by 周德艺 on 15/11/17.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "MainViewController.h"
#import "HomeViewController.h"
#import "IdentificationViewController.h"
#import "InvestigationViewController.h"
#import "NewsViewController.h"
#import "RecommendViewController.h"
@interface MainViewController ()

//@property (nonatomic, strong) HomeViewController *homeVC;
//@property (nonatomic, strong) NewsViewController *newsVC;
//@property (nonatomic, strong) IdentificationViewController *identificationVC;
//@property (nonatomic, strong) RecommendViewController *recommendVC;
//@property (nonatomic, strong) InvestigationViewController *investigationVC;

@property (nonatomic, strong) UINavigationController *homeNVC;
@property (nonatomic, strong) UINavigationController *newsNVC;
@property (nonatomic, strong) UINavigationController *recommendNVC;
@property (nonatomic, strong) UINavigationController *investigationNVC;
@property (nonatomic, strong) UINavigationController *identificationNVC;



@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /**
     *	设置tabbar选中背景、navigationbar背景、navigationbar下边框
     */

    [[UITabBar appearance]setSelectionIndicatorImage:[UIImage imageNamed:@"tabbar"]];
    self.viewControllers = @[self.homeNVC,self.newsNVC,self.recommendNVC,self.investigationNVC,self.identificationNVC];
    self.selectedIndex = 0;
    [self.tabBar setTintColor:MainColor];
//    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"cpxx-7"] forBarMetrics:UIBarMetricsDefault ];
//    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
//    [[UINavigationBar appearance] setShadowImage:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

///**
// *	跳转 PersonalVC
// */
//- (IBAction)goPersonalVC:(id)sender{
//    PersonalViewController *pVC = [[PersonalViewController alloc]initWithNibName:@"PersonalViewController" bundle:nil];
//    [self.navigationController pushViewController:pVC animated:YES];
//}

#pragma mark - getter and setter
- (UINavigationController *)homeNVC{
    if (_homeNVC == nil) {
        HomeViewController *homeVC = [[HomeViewController alloc]initWithNibName:@"HomeViewController" bundle:nil];
        _homeNVC = [[UINavigationController alloc]initWithRootViewController:homeVC];
        _homeNVC.tabBarItem.title=@"首页";
        _homeNVC.tabBarItem.image=[UIImage imageNamed:@"tabBar_home_off.png"];
        _homeNVC.tabBarItem.selectedImage=[UIImage imageNamed:@"tabBar_home_on.png"];
    }
    return [self changeNVC:_homeNVC];
}
- (UINavigationController *)newsNVC{
    if (_newsNVC == nil) {
        NewsViewController *newVC = [[NewsViewController alloc]initWithNibName:@"NewsViewController" bundle:nil];
        _newsNVC = [[UINavigationController alloc]initWithRootViewController:newVC];
        _newsNVC.tabBarItem.title=@"新闻";
        _newsNVC.tabBarItem.image=[UIImage imageNamed:@"tabBar_news_off.png"];
        _newsNVC.tabBarItem.selectedImage=[UIImage imageNamed:@"tabBar_news_on.png"];
    }
    return [self changeNVC:_newsNVC];
}
- (UINavigationController *)recommendNVC{
    if (_recommendNVC == nil) {
        RecommendViewController *reVC = [[RecommendViewController alloc]initWithNibName:@"RecommendViewController" bundle:nil];
        _recommendNVC = [[UINavigationController alloc]initWithRootViewController:reVC];
        _recommendNVC.tabBarItem.title = @"推荐";
        _recommendNVC.tabBarItem.image = [UIImage imageNamed:@"tabBar_recommend_off.png"];
        _recommendNVC.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_recommend_on.png"];
    }
    return [self changeNVC:_recommendNVC];
}
- (UINavigationController *)investigationNVC{
    if (_investigationNVC == nil) {
        InvestigationViewController *investigationVC = [[InvestigationViewController alloc]initWithNibName:@"InvestigationViewController" bundle:nil];
        _investigationNVC = [[UINavigationController alloc]initWithRootViewController:investigationVC];
        _investigationNVC.tabBarItem.title = @"调查征询";
        _investigationNVC.tabBarItem.image = [UIImage imageNamed:@"tabBar_investigation_off.png"];
        _investigationNVC.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_investigation_on.png"];
        //    _investigationNVC.tabBarItem.badgeValue=@"6";tabBarItem.badgeValue = [NSString stringWithFormat:@"%ld",(long)[UIApplication sharedApplication].applicationIconBadgeNumber];
    }
    return [self changeNVC:_investigationNVC];
}
- (UINavigationController *)identificationNVC{
    if (_identificationNVC == nil) {
        IdentificationViewController *identVC = [[IdentificationViewController alloc]initWithNibName:@"IdentificationViewController" bundle:nil];
        _identificationNVC = [[UINavigationController alloc]initWithRootViewController:identVC];
        _identificationNVC.tabBarItem.title = @"认证用户";
        _identificationNVC.tabBarItem.image = [UIImage imageNamed:@"tabBar_identification_off.png"];
        _identificationNVC.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_identification_off.png"];
    }
    return [self changeNVC:_identificationNVC];
}

- (void)addNotificationCount {
    _notificationCount++;
    NSString *count;
    if (self.notificationCount != 0) {
        count = [NSString stringWithFormat:@"%d",self.notificationCount];
    }
    self.identificationNVC.tabBarItem.badgeValue = count;
}

/**
 *	统一修改样式
 */
- (UINavigationController *)changeNVC:(UINavigationController *)navigationController{
    
    //删除导航栏下边的黑线
    [navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    navigationController.navigationBar.shadowImage = [[UIImage alloc] init];

    
    navigationController.view.backgroundColor=[UIColor grayColor];
    navigationController.navigationBar.translucent =  NO;//透明
    //导航栏颜色
    navigationController.navigationBar.barTintColor = MainColor;
    //修改UINavigationController title 的颜色和大小
    UIColor * titleColor = [UIColor whiteColor];
    UIFont * font = [UIFont boldSystemFontOfSize:20];
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:titleColor,NSForegroundColorAttributeName,font,NSFontAttributeName, nil];
    navigationController.navigationBar.titleTextAttributes = dic;
    //返回按钮
    navigationController.navigationBar.tintColor = [UIColor whiteColor];
    UIViewController *viewController = navigationController.viewControllers[0];
    UIButton *personalBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [personalBtn setImage:[UIImage imageNamed:@"personal_white.png"] forState:UIControlStateNormal];
    [personalBtn addTarget:viewController action:@selector(goPersonalVC:) forControlEvents:UIControlEventTouchUpInside];
    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:personalBtn];
    viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:viewController action:nil];
//    navigation栏的图片
//    [navigationController setBackgroundImage:[UIImage imageNamed:@"cpxx-7"] forBarMetrics:UIBarMetricsDefault ];
//    修改navigation下边框
//    [navigationController setShadowImage:[UIImage imageNamed:@"cpxx-8"]];
    
    return navigationController;
}

@end
