//
//  WorkPushObject.h
//  ASParentTest
//
//  Created by 张浩 on 15/11/29.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WorkPushObject : NSObject
//"teaname": "李建功",
//"addtime": "2015-12-17 20:20:23",
//"zongdian": "qwdsadas",
//"teachercode": "04010002",
//"idcode": "1",
//"name": "数学",
//"stcont": "一班",
//"miaoshu": "maioshu",
//"header": "作业测试111"

@property (nonatomic , copy) NSString *teaname;
@property (nonatomic , copy) NSString *addtime;
@property (nonatomic , copy) NSString *zongdian;
@property (nonatomic , copy) NSString *teachercode;
@property (nonatomic , copy) NSString *idcode;
@property (nonatomic , copy) NSString *name;
@property (nonatomic , copy) NSString *stcont;
@property (nonatomic , copy) NSString *miaoshu;
@property (nonatomic , copy) NSString *header;

@end
