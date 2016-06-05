//
//  MessageCollectionViewController.h
//  Footprint
//
//  Created by 周德艺 on 15/5/23.
//  Copyright (c) 2015年 周德艺. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSCollectionView.h"
#import "WallObject.h"

@interface MessageCollectionViewController : UIViewController<PSCollectionViewDelegate, PSCollectionViewDataSource,UIScrollViewDelegate>

@property (nonatomic,strong) PSCollectionView *collectionView;

@property(nonatomic, strong) UserObject *user;
@property(nonatomic, strong) WallObject *wall;
@property(nonatomic, strong) UIButton * cancelBtn;
@property(nonatomic, strong) NSString *msgId;
@property(nonatomic, strong) NSMutableArray *msgArr;
@property(nonatomic, strong) NSMutableArray *collectMsgArr;
@property(nonatomic, strong) UILabel *titleLab;

@property(nonatomic, strong) NSMutableArray * photos;
@property(nonatomic) BOOL isLiudong;

-(void)getMsgArr;

@end
