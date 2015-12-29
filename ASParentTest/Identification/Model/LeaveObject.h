//
//  LeaveObject.h
//  ASParentTest
//
//  Created by 张浩 on 15/11/29.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LeaveObject : NSObject
//ltype: 2,
//addtime: null,
//teachercode: "1",
//lasttime: null,
//leavestyle: null,
//idcode: "2",
//subjectline: null,
//lbeizu: null,
//ltime: null,
//schoolcensus: "2011370181180120307",
//firsttime: null

@property (nonatomic , strong) NSNumber *ltype;
@property (nonatomic , copy) NSString *addtime;
@property (nonatomic , copy) NSString *teachercode;
@property (nonatomic , copy) NSString *lasttime;
@property (nonatomic , copy) NSString *leavestyle;
@property (nonatomic , copy) NSString *idcode;
@property (nonatomic , copy) NSString *subjectline;
@property (nonatomic , copy) NSString *lbeizu;
@property (nonatomic , copy) NSString *ltime;
@property (nonatomic , copy) NSString *schoolcensus;
@property (nonatomic , copy) NSString *firsttime;

@end
