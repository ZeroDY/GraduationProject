//
//  DYRequestBase+SearchHomeWork.m
//  ASParentTest
//
//  Created by 张浩 on 15/12/18.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "DYRequestBase+SearchHomeWork.h"

@implementation DYRequestBase (SearchHomeWork)
+ (void)SearchHomeWorkByUserId:(NSString *)userId StudentId:(NSString *)studentId CurrentPageNum:(NSString *)currentPageNum RowOfPage:(NSString *)rowOfPage requestStartBlock:(requestStartBlock)startBlock  responseBlock:(responseBlock)responseBlock;
{
    NSDictionary *param = @{
                            @"userId":userId,
                            @"studentId":studentId,
                            @"curPageNum":currentPageNum,
                            @"rowOfPage":rowOfPage,
                            };
    [self getWithMethodName:@"api.homework.studentHomeWork.do" param:param responseBlock:responseBlock];
    if (startBlock) {
        startBlock();
    }
}
@end
