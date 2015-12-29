//
//  ZcdcObject.h
//  ASParentTest
//
//  Created by 张浩 on 15/11/29.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZcdcObject : NSObject

//"modifytime": "2016-01-29 11:19:27",
//"addtime": "2015-12-17 11:19:26",
//"isshow": 1,
//"idcode": "1",
//"stype": "0",
//"zcstyle": "1",
//"isfenzu": 0,
//"userid": null,
//"zname": "调查类型1",
//"jianjie": "简介",
//"sheader": "调查问卷111"

@property (nonatomic , copy) NSString *modifytime;
@property (nonatomic , copy) NSString *addtime;
@property (nonatomic , strong) NSNumber *isshow;
@property (nonatomic , copy) NSString *idcode;
@property (nonatomic , copy) NSString *stype;
@property (nonatomic , copy) NSString *zcstyle;
@property (nonatomic , strong) NSNumber *isfenzu;
@property (nonatomic , copy) NSString *userid;
@property (nonatomic , copy) NSString *zname;
@property (nonatomic , copy) NSString *jianjie;
@property (nonatomic , copy) NSString *sheader;

@end
