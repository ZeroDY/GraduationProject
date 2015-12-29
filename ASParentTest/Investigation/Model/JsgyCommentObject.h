//
//  JsgyCommentObject.h
//  ASParentTest
//
//  Created by 张浩 on 15/12/5.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsgyCommentObject : NSObject
//addtime = "2015-12-04 23:25:30";
//brainidcard = a;
//csender = 8a237785514cecbd01514d8ec2ec001b;
//idcode = a;
//isaudit = 1;
//isdeleted = 0;
//scontent = "\U52aa\U529b\U5b66\U4e60\U3002";
//senderip = "131.11.2.1";
//stype = 1;

@property (nonatomic , copy) NSString *addtime;
@property (nonatomic , copy) NSString *brainidcard;
@property (nonatomic , copy) NSString *csender;
@property (nonatomic , copy) NSString *idcode;
@property (nonatomic , copy) NSNumber *isaudit;
@property (nonatomic , copy) NSNumber *isdeleted;
@property (nonatomic , copy) NSString *scontent;
@property (nonatomic , copy) NSString *senderip;
@property (nonatomic , copy) NSNumber *stype;
@end
