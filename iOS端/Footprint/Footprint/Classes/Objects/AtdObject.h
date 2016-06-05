//
//  AtdObject.h
//  Footprint
//
//  Created by 周德艺 on 15/6/10.
//  Copyright (c) 2015年 周德艺. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AtdWallObject.h"

@interface AtdObject : NSObject

@property (nonatomic, strong) NSString *atdid;
@property (nonatomic, strong) NSString *atdwallname;
@property (nonatomic, strong) NSString *atdinfo;
@property (nonatomic, strong) NSString *atdidentifier;
@property (nonatomic, strong) AtdWallObject *atdwall;
@property(nonatomic, strong) UserObject *atduser;

@end
