//
//  AtdWallViewController.h
//  Footprint
//
//  Created by 周德艺 on 15/6/10.
//  Copyright (c) 2015年 周德艺. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMTagListView.h"
#import "MZTimerLabel.h"
#import "AtdWallObject.h"
#import "AtdObject.h"

@interface AtdWallViewController : UIViewController

@property (weak, nonatomic) IBOutlet AMTagListView	*tagListView;
@property (nonatomic, strong) AMTagView             *selection;
@property (weak, nonatomic) IBOutlet UILabel *label;

@property (nonatomic,strong) UserObject *user;
@property (nonatomic,strong) AtdWallObject *atdWall;
@property (nonatomic,strong) NSMutableArray *atdArray;
@property (nonatomic,strong) MZTimerLabel *timer;

@end
