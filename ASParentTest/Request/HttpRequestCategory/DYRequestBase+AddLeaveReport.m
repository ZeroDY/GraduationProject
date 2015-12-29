//
//  DYRequestBase+AddLeaveReport.m
//  ASParentTest
//
//  Created by 张浩 on 15/12/18.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "DYRequestBase+AddLeaveReport.h"

@implementation DYRequestBase (AddLeaveReport)
+ (void)AddLeaveReportByXuejiNum:(NSString *)xuejiNum LeaveType:(NSString *)leaveType StartTime:(NSString *)startTime FinishTime:(NSString *)finishTime LeaveReason:(NSString *)leaveReason leaveRemark:(NSString *)leaveRemark requestStartBlock:(requestStartBlock)startBlock  responseBlock:(responseBlock)responseBlock
{
    NSDictionary *param = @{
                            @"census":xuejiNum,
                            @"style":leaveType,
                            @"firsttime":startTime,
                            @"lasttime":finishTime,
                            @"reason":leaveReason,
                            @"beizhu":leaveRemark,
                            };
    [self getWithMethodName:@"api.leave.addLeave.do" param:param responseBlock:responseBlock];
    if (startBlock) {
        startBlock();
    }
}
@end