//
//  JsgyDetailObject.h
//  ASParentTest
//
//  Created by 张浩 on 15/12/5.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsgyDetailObject : NSObject
//addtime = "2015-12-04 23:24:04";
//bsender = 000000005152e74e015152ec24d50002;
//idcode = a;
//ishost = 1;
//scontent = "\U5982\U4f55\U66f4\U597d\U7684\U5efa\U8bbe\U6211\U4eec\U7684\U56fd\U5bb6\U3002";
//senderip = "127.0.0.1";
//stype = 1;

@property (nonatomic , copy) NSString *addtime;
@property (nonatomic , copy) NSString *bsender;
@property (nonatomic , strong) NSNumber *ishost;
@property (nonatomic , copy) NSString *idcode;
@property (nonatomic , copy) NSString *scontent;
@property (nonatomic , copy) NSString *senderip;
@property (nonatomic , strong) NSNumber *stype;

@end
