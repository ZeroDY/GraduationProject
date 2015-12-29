//
//  DYRequestBase+SearchHomeWorkDetail.m
//  ASParentTest
//
//  Created by 张浩 on 15/12/19.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "DYRequestBase+SearchHomeWorkDetail.h"

@implementation DYRequestBase (SearchHomeWorkDetail)
+ (void)SearchHomeWorkDetailByUserId:(NSString *)userId HomeWorkId:(NSString *)homeworkId requestStartBlock:(requestStartBlock)startBlock  responseBlock:(responseBlock)responseBlock
{
    NSDictionary *param = @{
                            @"userId":userId,
                            @"workId":homeworkId,
                            };
    [self getWithMethodName:@"api.homework.homeWorkSummary.do" param:param responseBlock:responseBlock];
    if (startBlock) {
        startBlock();
    }
}
@end
