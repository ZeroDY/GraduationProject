//
//  DYRequestBase+SearchHomeWork.h
//  ASParentTest
//
//  Created by 张浩 on 15/12/18.
//  Copyright © 2015年 周德艺. All rights reserved.
//  查询作业列表接口

#import "DYRequestBase.h"

@interface DYRequestBase (SearchHomeWork)
+ (void)SearchHomeWorkByUserId:(NSString *)userId StudentId:(NSString *)studentId CurrentPageNum:(NSString *)currentPageNum RowOfPage:(NSString *)rowOfPage requestStartBlock:(requestStartBlock)startBlock  responseBlock:(responseBlock)responseBlock;

@end
