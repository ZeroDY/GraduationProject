//
//  ZcdcOptionalObject.h
//  ASParentTest
//
//  Created by 张浩 on 15/11/29.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZcdcOptionalObject : NSObject

//zhengce: "64eed420888543228ecb046156d4c58f",
//isshow: 1,
//idcode: "3923d5ef189c46f58136c28c7208c33f",
//scontent: "选项2",
//isqita: null,
//sheader: "B"

@property (nonatomic , copy) NSString *zhengce;
@property (nonatomic , strong) NSNumber *isshow;
@property (nonatomic , copy) NSString *idcode;
@property (nonatomic , copy) NSString *scontent;
@property (nonatomic , copy) NSString *isqita;
@property (nonatomic , copy) NSString *sheader;

@end
