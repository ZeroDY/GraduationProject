//
//  DYRequestBase+AddLeaveReport.h
//  ASParentTest
//
//  Created by 张浩 on 15/12/18.
//  Copyright © 2015年 周德艺. All rights reserved.
//  请假申请提交接口

#import "DYRequestBase.h"

@interface DYRequestBase (AddLeaveReport)
+ (void)AddLeaveReportByXuejiNum:(NSString *)xuejiNum LeaveType:(NSString *)leaveType StartTime:(NSString *)startTime FinishTime:(NSString *)finishTime LeaveReason:(NSString *)leaveReason leaveRemark:(NSString *)leaveRemark requestStartBlock:(requestStartBlock)startBlock  responseBlock:(responseBlock)responseBlock;
@end
