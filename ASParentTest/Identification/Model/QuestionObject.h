//
//  QuestionObject.h
//  ASParentTest
//
//  Created by 张浩 on 15/12/4.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OptionalObject.h"
@interface QuestionObject : NSObject
//nsarray
//queId = 1;
//status = 0;
//title = "\U4eca\U5929\U7684\U4f5c\U4e1a\U662f\U4e0d\U662f\U592a\U591a\U4e86\Uff1f";

@property (nonatomic , copy) NSString *queId;
@property (nonatomic , copy) NSString *status;
@property (nonatomic , copy) NSString *title;
@property (nonatomic , strong) NSArray<OptionalObject *> *optArr;
@end
