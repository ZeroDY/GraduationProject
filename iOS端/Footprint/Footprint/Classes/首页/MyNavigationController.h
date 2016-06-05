//
//  DEMONavigationController.h
//  REFrostedViewControllerExample
//
//  Created by Roman Efimov on 9/18/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyNavigationController : UINavigationController

@property (nonatomic, strong)UIViewController *rootVC;

- (void)showMenuRootVC:(UIViewController*) rootVC;
- (void)showMenu;

@end
