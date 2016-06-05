//
//  MenuViewController.h
//  Footprint
//
//  Created by 张浩 on 15/5/26.
//  Copyright (c) 2015年 周德艺. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+MMDrawerController.h"

typedef NS_ENUM(NSInteger, MMDrawerSection){
    MMDrawerSectionViewSelection,
    MMDrawerSectionDrawerWidth,
    MMDrawerSectionShadowToggle,
    MMDrawerSectionOpenDrawerGestures,
    MMDrawerSectionCloseDrawerGestures,
    MMDrawerSectionCenterHiddenInteraction,
    MMDrawerSectionStretchDrawer,
};

@interface MenuViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UserObject *user;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UILabel *label;

-(void)contentSizeDidChange:(NSString*)size;
-(void)addTableHeader;

@end
