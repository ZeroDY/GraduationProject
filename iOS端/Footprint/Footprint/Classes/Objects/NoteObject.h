//
//  NoteObject.h
//  Footprint
//
//  Created by 周德艺 on 15/5/4.
//  Copyright (c) 2015年 周德艺. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WallObject.h"

@interface NoteObject : NSObject

@property (nonatomic, strong) NSString *msgid;
@property (nonatomic, strong) NSString *msgcontent;
@property (nonatomic, strong) NSString *msgcreattime;
@property (nonatomic, strong) NSString *msgstatus;
@property (nonatomic, strong) NSString *msgtype;
@property (nonatomic, strong) NSString *msgimage;

@property(nonatomic, strong) UserObject *user;
@property(nonatomic, strong) WallObject *wall;

-(void)dateFormat;

@end
