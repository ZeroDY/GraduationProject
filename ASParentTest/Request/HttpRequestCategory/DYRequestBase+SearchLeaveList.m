//
//  DYRequestBase+SearchLeaveList.m
//  ASParentTest
//
//  Created by 张浩 on 15/12/18.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "DYRequestBase+SearchLeaveList.h"

@implementation DYRequestBase (SearchLeaveList)
+ (void)SearchLeaveListByXuejiNum:(NSString *)xuejiNum CurrentPageNum:(NSString *)currentPageNum RowOfPage:(NSString *)rowOfPage requestStartBlock:(requestStartBlock)startBlock  responseBlock:(responseBlock)responseBlock
{
    NSDictionary *param = @{
                            @"census":xuejiNum,
                            @"curPageNum":currentPageNum,
                            @"rowOfPage":rowOfPage,
                            };
    [self getWithMethodName:@"api.leave.getStudentLeaveList.do" param:param responseBlock:responseBlock];
    if (startBlock) {
        startBlock();
    }

}
@end
