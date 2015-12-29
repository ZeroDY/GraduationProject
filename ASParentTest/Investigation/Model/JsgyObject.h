//
//  JsgyObject.h
//  ASParentTest
//
//  Created by 张浩 on 15/12/2.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsgyObject : NSObject
//"ishost": 1,
//"addtime": "2015-11-29 22:16:38",
//"idcode": "34844dd2428c45df96dfb9fdf70fc33d",
//"stype": 1,
//"scontent": "",
//"bsender": "000000005152e74e015152ec24d50002",
//"senderip": "10.8.64.57"


@property (nonatomic , strong) NSNumber *ishost;
@property (nonatomic , copy) NSString *addtime;
@property (nonatomic , copy) NSString *idcode;
@property (nonatomic , strong) NSNumber *stype;
@property (nonatomic , copy) NSString *scontent;
@property (nonatomic , copy) NSString *bsender;
@property (nonatomic , copy) NSString *senderip;

@end
