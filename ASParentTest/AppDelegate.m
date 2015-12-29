//
//  AppDelegate.m
//  ASParentTest
//
//  Created by 周德艺 on 15/11/17.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "APService.h"
#import "NoticeInfoViewController.h"
@interface AppDelegate ()

@property (nonatomic, strong) MainViewController *mainVC;


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.mainVC = [[MainViewController alloc]init];
    self.window.rootViewController = self.mainVC;
    [self.window makeKeyAndVisible];
    
    /**
     *	极光推送
     */
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [APService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                       UIUserNotificationTypeSound |
                                                       UIUserNotificationTypeAlert)
                                           categories:nil];
    } else {
        //categories 必须为nil
        [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                       UIRemoteNotificationTypeSound |
                                                       UIRemoteNotificationTypeAlert)
                                           categories:nil];
    }
    
    // Required
    [APService setupWithOption:launchOptions];
    
    
    //    //注册推送通知（注意iOS8注册方法发生了变化）
    //    if (IS_IOS8_OR_ABOVE) {
    //        [application registerForRemoteNotifications];
    //        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes: (UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIUserNotificationTypeSound) categories:nil];
    //        [application registerUserNotificationSettings:settings];
    //    } else {
    //        [application registerForRemoteNotificationTypes:
    //         UIUserNotificationTypeBadge |
    //         UIUserNotificationTypeAlert |
    //         UIUserNotificationTypeSound];
    //    }
    //
    //判断是否由远程消息通知触发应用程序启动
    if ([launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey]!=nil) {
        //获取应用程序消息通知标记数（即小红圈中的数字）
        NSInteger badge = [UIApplication sharedApplication].applicationIconBadgeNumber;
        if (badge>0) {
            //如果应用程序消息通知标记数（即小红圈中的数字）大于0，清除标记。
            badge--;
            //清除标记。清除小红圈中数字，小红圈中数字为0，小红圈才会消除。
            [UIApplication sharedApplication].applicationIconBadgeNumber = badge;
        }
    }
    //    //判断程序是不是第一次加载
    //    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstStart"]){
    //        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstStart"];
    //        NSLog(@"第一次启动");
    //        [self getRegionInfo:0];
    //    }else{
    //        NSLog(@"不是第一次启动");
    //    }
    //    self.regionArr = [[NSMutableArray alloc]init];
    //    [self getRegionInfo:@"227" andFatherArr:self.regionArr];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/**
 *	极光推送
 *
 */
//发送令牌
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    NSLog(@"%@", [NSString stringWithFormat:@"Device Token: %@", deviceToken]);
    // Required
    [APService registerDeviceToken:deviceToken];
}
//令牌发送失败
- (void)application:(UIApplication *)application
didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}
//如果 App状态为正在前台或者后台运行，那么此函数将被调用，并且可通过AppDelegate的applicationState是否为UIApplicationStateActive判断程序是否在前台运行
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    // 取得 APNs 标准信息内容
    NSDictionary *aps = [userInfo valueForKey:@"aps"];
    NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容
    NSInteger badge = [[aps valueForKey:@"badge"] integerValue]; //badge数量
    NSString *sound = [aps valueForKey:@"sound"]; //播放的声音
    // 取得自定义字段内容
    NSString *customizeField1 = [userInfo valueForKey:@"customizeField1"]; //自定义参数，key是自己定义的
    NSLog(@"content =[%@], badge=[%d], sound=[%@], customize field  =[%@]",content,badge,sound,customizeField1);
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:[[userInfo objectForKey:@"aps"] objectForKey:@"alert"] delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil];
    [alert show];
    // Required
    [APService handleRemoteNotification:userInfo];
}
//如果是使用 iOS 7 的 Remote Notification 特性那么处理函数需要使用
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    NSLog(@"this is iOS7 Remote Notification");
    NSLog(@"收到通知1:%@", userInfo);
    [self push:userInfo];
    [self.mainVC addNotificationCount];
    
    [APService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}


- (void)application:(UIApplication *)application
didReceiveLocalNotification:(UILocalNotification *)notification {
    [APService showLocalNotificationAtFront:notification identifierKey:nil];
}

// log NSSet with UTF8
// if not ,log will be \Uxxx
- (void)push:(NSDictionary *)dic {
    if (![dic count]) {
        return;
    }
    
    // 取得 APNs 标准信息内容
    NSDictionary *aps = [dic valueForKey:@"aps"];
    NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容
    NSInteger badge = [[aps valueForKey:@"badge"] integerValue]; //badge数量
    NSString *sound = [aps valueForKey:@"sound"]; //播放的声音
    NSInteger sendType = [[dic valueForKey:@"sendType"] intValue];//
    NSString *sendId = [dic valueForKey:@"sendId"]; //id
    
    switch (sendType) {
        case 0://政策
            
            break;
        case 1://新闻
            
            break;
        case 2:{//通知
            NoticeInfoViewController *newVC = [[NoticeInfoViewController alloc]initWithNibName:@"NoticeInfoViewController" bundle:nil];
            newVC.noticeid = sendId;
            // 获取导航控制器
            UITabBarController *tabVC = (UITabBarController *)self.window.rootViewController;
            UINavigationController *pushClassStance = (UINavigationController *)tabVC.viewControllers[4];
            // 跳转到对应的控制器
            tabVC.selectedIndex = 4;
            newVC.hidesBottomBarWhenPushed = YES;
            [pushClassStance pushViewController:newVC animated:YES];
            
        }
            break;
            
        case 3:{//请假
            
//            QingjiaShenPiViewController *newVC = [[QingjiaShenPiViewController alloc]initWithNibName:@"QingjiaShenPiViewController" bundle:nil];
//            newVC.qingjiaId = sendId;
//            newVC.isShen = NO;
//            // 获取导航控制器
//            UITabBarController *tabVC = (UITabBarController *)self.window.rootViewController;
//            UINavigationController *pushClassStance = (UINavigationController *)tabVC.viewControllers[4];
//            // 跳转到对应的控制器
//            tabVC.selectedIndex = 4;
//            newVC.hidesBottomBarWhenPushed = YES;
//            [pushClassStance pushViewController:newVC animated:YES];
        }
            break;
            
        case 4://作业
            
            break;
            
            
        default:
            break;
    }
    
    
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    [NSPropertyListSerialization propertyListFromData:tempData
                                     mutabilityOption:NSPropertyListImmutable
                                               format:NULL
                                     errorDescription:NULL];
}
@end
