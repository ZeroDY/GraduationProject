//
//  StudentObject.h
//  ASParentTest
//
//  Created by 张浩 on 15/11/29.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StudentObject : NSObject
//classname = "2011\U7ea76\U73ed";
//idcode = 8a237785514cecbd01514d8ec2ec001b;
//schoolcensus = 2011370181180120311;
//schoolname = "\U5916\U5730\U8fd4\U6d4e\U5386\U4e0b";
//studentsex = "\U7537";
//stuname = "\U5f20\U4e00\U6d69";
//stutype = "";
@property (nonatomic , copy) NSString *classname;
@property (nonatomic , copy) NSString *idcode;
@property (nonatomic , copy) NSString *schoolcensus;
@property (nonatomic , copy) NSString *schoolname;
@property (nonatomic , copy) NSString *studentsex;
@property (nonatomic , copy) NSString *stuname;
@property (nonatomic , copy) NSString *stutype;

@end
