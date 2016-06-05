//
//  UserObject.h
//  Footprint
//
//  Created by 张浩 on 15/4/27.
//  Copyright (c) 2015年 周德艺. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserObject : NSObject

@property(nonatomic,copy) NSString *username;
@property(nonatomic) int  status;
@property(nonatomic,copy) NSString *password;
@property(nonatomic,copy) NSString *truename;
@property(nonatomic,copy) NSString *sex;
@property(nonatomic,copy) NSString *tel;
@property(nonatomic,copy) NSString *photourl;
@property(nonatomic) int  age;

@end
