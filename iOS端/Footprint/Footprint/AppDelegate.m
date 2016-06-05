//
//  AppDelegate.m
//  Footprint
//
//  Created by 周德艺 on 15/4/25.
//  Copyright (c) 2015年 周德艺. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "ZWIntroductionViewController.h"

#import "MMDrawerController.h"
#import "NearViewController.h"
#import "MenuViewController.h"
#import "MMDrawerVisualState.h"
#import "MMExampleDrawerVisualStateManager.h"
#import "MMNavigationController.h"

@interface AppDelegate ()

@property (nonatomic, strong) ZWIntroductionViewController *introductionView;
@property (nonatomic,strong) MMDrawerController * drawerController;

@end

@implementation AppDelegate

-(BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    //
    //    UIViewController * leftSideDrawerViewController = [[MenuViewController alloc] init];
    //
    //    UIViewController * centerViewController = [[NearViewController alloc] init];
    //
    //    UINavigationController * navigationController = [[MMNavigationController alloc] initWithRootViewController:centerViewController];
    //    [navigationController setRestorationIdentifier:@"MMExampleCenterNavigationControllerRestorationKey"];
    //    if(OSVersionIsAtLeastiOS7()){
    //        UINavigationController * leftSideNavController = [[MMNavigationController alloc] initWithRootViewController:leftSideDrawerViewController];
    //        [leftSideNavController setRestorationIdentifier:@"MMExampleLeftNavigationControllerRestorationKey"];
    //        self.drawerController = [[MMDrawerController alloc]
    //                                 initWithCenterViewController:navigationController
    //                                 leftDrawerViewController:leftSideNavController
    //                                 rightDrawerViewController:nil];
    //        [self.drawerController setShowsShadow:NO];
    //    }
    //    else{
    //        self.drawerController = [[MMDrawerController alloc]
    //                                 initWithCenterViewController:navigationController
    //                                 leftDrawerViewController:leftSideDrawerViewController
    //                                 rightDrawerViewController:nil];
    //    }
    //    [self.drawerController setRestorationIdentifier:@"MMDrawer"];
    //    [self.drawerController setMaximumRightDrawerWidth:200.0];
    //    [self.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    //    [self.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    //
    //    [self.drawerController
    //     setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
    //         MMDrawerControllerDrawerVisualStateBlock block;
    //         block = [[MMExampleDrawerVisualStateManager sharedManager]
    //                  drawerVisualStateBlockForDrawerSide:drawerSide];
    //         if(block){
    //             block(drawerController, drawerSide, percentVisible);
    //         }
    //     }];
    //    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    //    if(OSVersionIsAtLeastiOS7()){
    //        UIColor * tintColor = [UIColor colorWithRed:29.0/255.0
    //                                              green:173.0/255.0
    //                                               blue:234.0/255.0
    //                                              alpha:1.0];
    //        [self.window setTintColor:tintColor];
    //    }
    //    [self.window setRootViewController:self.drawerController];
    //
    return YES;
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstStart"]){
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstStart"];
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        self.window.backgroundColor = [UIColor clearColor];
        
        // Added Introduction View Controller
        NSArray *coverImageNames = @[@"img_index_01txt", @"img_index_02txt", @"img_index_03txt"];
        NSArray *backgroundImageNames = @[@"img_index_01bg", @"img_index_02bg", @"img_index_03bg"];
        self.introductionView = [[ZWIntroductionViewController alloc] initWithCoverImageNames:coverImageNames backgroundImageNames:backgroundImageNames];
        
        
        [self.window addSubview:self.introductionView.view];
        
        __weak AppDelegate *weakSelf = self;
        self.introductionView.didSelectedEnter = ^() {
            [weakSelf.introductionView.view removeFromSuperview];
            weakSelf.introductionView = nil;
            
            LoginViewController *loginVC = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
            UINavigationController *loginNavi = [[UINavigationController alloc] initWithRootViewController:loginVC];
            weakSelf.window.rootViewController = loginNavi;
        };
    }else{
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if ([defaults objectForKey:USERINFO]) {
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSDictionary *userDic = [defaults objectForKey:USERINFO];
            
            NearViewController *nearViewController = [[NearViewController alloc] initWithNibName:@"NearViewController" bundle:nil];
            nearViewController.user = [UserObject objectWithKeyValues:userDic];
            UINavigationController * navigationController = [[MMNavigationController alloc] initWithRootViewController:nearViewController];
            
            MenuViewController * leftViewController = [[MenuViewController alloc] init];
            [leftViewController addTableHeader];
            UINavigationController * leftSideNavController = [[MMNavigationController alloc] initWithRootViewController:leftViewController];
            
            self.drawerController = [[MMDrawerController alloc]
                                     initWithCenterViewController:navigationController
                                     leftDrawerViewController:leftSideNavController
                                     rightDrawerViewController:nil];
            [self.drawerController setShowsShadow:NO];
            
            [self.drawerController setMaximumRightDrawerWidth:200.0];
            [self.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
            [self.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
            
            [self.drawerController
             setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
                 MMDrawerControllerDrawerVisualStateBlock block;
                 block = [[MMExampleDrawerVisualStateManager sharedManager]
                          drawerVisualStateBlockForDrawerSide:drawerSide];
                 if(block){
                     block(drawerController, drawerSide, percentVisible);
                 }
             }];
            [self.window setRootViewController:self.drawerController];
        }else{
            LoginViewController *loginVC = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
            self.window.rootViewController = loginVC;
        }
        
    }
    return YES;
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
