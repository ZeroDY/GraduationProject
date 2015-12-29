//
//  DYRequestBase+SearchBindStudentsRequest.h
//  ASParentTest
//
//  Created by 张浩 on 15/12/18.
//  Copyright © 2015年 周德艺. All rights reserved.
//  查询绑定学生列表接口

#import "DYRequestBase.h"

@interface DYRequestBase (SearchBindStudentsRequest)
+ (void)SearchBindStudentsByUserId:(NSString *)userId requestStartBlock:(requestStartBlock)startBlock  responseBlock:(responseBlock)responseBlock;

@end
