//
//  ZcdcQuestionObject.h
//  ASParentTest
//
//  Created by 张浩 on 15/11/29.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZcdcOptionalObject.h"
@interface ZcdcQuestionObject : NSObject

//wenjuan: "2c430e4b0fed44e39c3933c32bf86b62",
//isshow: 1,
//idcode: "64eed420888543228ecb046156d4c58f",
//scontent: "问题1",
//isdeleted: 0,
//xuanxiang: [],
//xuanxiangtype: 0

@property (nonatomic , copy) NSString *wenjuan;
@property (nonatomic , strong) NSNumber *isshow;
@property (nonatomic , copy) NSString *idcode;
@property (nonatomic , copy) NSString *scontent;
@property (nonatomic , strong) NSNumber *isdeleted;
@property (nonatomic , strong) NSArray<ZcdcOptionalObject *> *xuanxiang;
@property (nonatomic , copy) NSString *xuanxiangtype;

@end
