//
//  DYRequestBase+SearchLeaveList.h
//  ASParentTest
//
//  Created by 张浩 on 15/12/18.
//  Copyright © 2015年 周德艺. All rights reserved.
//  查询请假列表接口

#import "DYRequestBase.h"

@interface DYRequestBase (SearchLeaveList)
+ (void)SearchLeaveListByXuejiNum:(NSString *)xuejiNum CurrentPageNum:(NSString *)currentPageNum RowOfPage:(NSString *)rowOfPage requestStartBlock:(requestStartBlock)startBlock  responseBlock:(responseBlock)responseBlock;

@end
