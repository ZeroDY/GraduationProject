//
//  AtdWallObject.h
//  Footprint
//
//  Created by 周德艺 on 15/6/10.
//  Copyright (c) 2015年 周德艺. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AtdWallObject : NSObject

@property (nonatomic, strong) NSString *atdwallid;
@property (nonatomic, strong) NSString *atdwallname;
@property (nonatomic, strong) NSString *atdwallcreattime;
@property(nonatomic) int atdwallstatus;
@property(nonatomic) double atdxcoordinate;
@property(nonatomic) double atdycoordinate;
@property(nonatomic, strong) UserObject *user;

@end
