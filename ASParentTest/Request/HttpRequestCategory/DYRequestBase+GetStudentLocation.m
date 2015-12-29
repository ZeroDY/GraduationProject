//
//  DYRequestBase+GetStudentLocation.m
//  ASParentTest
//
//  Created by 张浩 on 15/12/21.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "DYRequestBase+GetStudentLocation.h"

@implementation DYRequestBase (GetStudentLocation)
+ (void)getStudentLocationByStudentId:(NSString *)studentId CurrentPageNum:(NSString *)currentPageNum RowOfPage:(NSString *)rowOfPage requestStartBlock:(requestStartBlock)startBlock  responseBlock:(responseBlock)responseBlock
{
    NSDictionary *param = @{
                            @"studentId":studentId,
                            @"curPageNum":currentPageNum,
                            @"rowOfPage":rowOfPage,
                            };
    [self getWithMethodName:@"api.student.studentLocation.do" param:param responseBlock:responseBlock];
    if (startBlock) {
        startBlock();
    }
}
@end
