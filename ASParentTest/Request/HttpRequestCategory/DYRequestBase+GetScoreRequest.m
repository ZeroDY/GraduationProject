//
//  DYRequestBase+GetScoreRequest.m
//  ASParentTest
//
//  Created by 张浩 on 15/12/18.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "DYRequestBase+GetScoreRequest.h"

@implementation DYRequestBase (GetScoreRequest)
+ (void)GetScoreByName:(NSString *)name XuejiNum:(NSString *)xuejiNum ZhunkaozhengNum:(NSString *)zhunkaozhengNum requestStartBlock:(requestStartBlock)startBlock  responseBlock:(responseBlock)responseBlock
{
    NSDictionary *param = @{
                            @"stuName":name,
                            @"studentCensus":xuejiNum,
                            @"ticket":zhunkaozhengNum,
                            };
    [self getWithMethodName:@"api.student.queryGrade.do" param:param responseBlock:responseBlock];
    if (startBlock) {
        startBlock();
    }
}
@end
