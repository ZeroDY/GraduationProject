//
//  MessageViewController.h
//  Footprint
//
//  Created by 周德艺 on 15/5/4.
//  Copyright (c) 2015年 周德艺. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WallObject.h"

@interface MessageViewController : UIViewController

@property(nonatomic, strong) UserObject *user;
@property(nonatomic, strong) WallObject *wall;
@property(nonatomic, strong) UIButton * cancelBtn;
@property(nonatomic, strong) NSString *msgId;
@property(nonatomic, strong) NSMutableArray *msgArr;
@property(nonatomic, strong) NSMutableArray *collectMsgArr;

@property(nonatomic, strong) NSMutableArray * photos;

-(void)getCollectMsgArr;
-(void)reloadCollectMsgArr;

@end
