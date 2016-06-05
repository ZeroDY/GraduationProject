//
//  CommentObject.h
//  Footprint
//
//  Created by 张浩 on 15/5/5.
//  Copyright (c) 2015年 周德艺. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NoteObject.h"
@interface CommentObject : NSObject

@property (nonatomic, strong) NSString *revid;
@property (nonatomic, strong) NSString *revtime;
@property (nonatomic, strong) NSString *revcontent;
@property (nonatomic, strong) NSString *revstatus;

@property(nonatomic, strong) UserObject *userByTouser;//接受者
@property(nonatomic, strong) UserObject *userByFromuser;//发送者
//@property(nonatomic, strong) NoteObject *message;

@end
