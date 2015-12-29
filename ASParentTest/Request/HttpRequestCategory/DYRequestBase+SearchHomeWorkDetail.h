//
//  DYRequestBase+SearchHomeWorkDetail.h
//  ASParentTest
//
//  Created by 张浩 on 15/12/19.
//  Copyright © 2015年 周德艺. All rights reserved.
//  查询作业详情接口

#import "DYRequestBase.h"

@interface DYRequestBase (SearchHomeWorkDetail)
+ (void)SearchHomeWorkDetailByUserId:(NSString *)userId HomeWorkId:(NSString *)homeworkId requestStartBlock:(requestStartBlock)startBlock  responseBlock:(responseBlock)responseBlock;

@end
