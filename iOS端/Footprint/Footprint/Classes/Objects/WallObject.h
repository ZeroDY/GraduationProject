//
//  WallObject.h
//  Footprint
//
//  Created by 周德艺 on 15/4/27.
//  Copyright (c) 2015年 周德艺. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserObject.h"

@interface WallObject : NSObject

@property(nonatomic, copy) NSString *wallid;
@property(nonatomic, copy) NSString *wallname;
@property(nonatomic, copy) NSString *wallsignature;
@property(nonatomic, copy) NSString *wallcreattime;
@property(nonatomic, copy) NSString *walltype;
@property(nonatomic, copy) NSString *wallstatus;
@property(nonatomic, copy) NSString *wallimage;
@property(nonatomic, copy) NSString *walladress;
@property(nonatomic) double xcoordinate;
@property(nonatomic) double ycoordinate;
@property(nonatomic) BOOL isCollect;
@property(nonatomic, strong) UserObject *user;

-(void)dateFormat;

@end
