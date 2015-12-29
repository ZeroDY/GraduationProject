//
//  DYRequestBase+GetGoodTeacherList.m
//  ASParentTest
//
//  Created by 张浩 on 15/12/21.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "DYRequestBase+GetGoodTeacherList.h"

@implementation DYRequestBase (GetGoodTeacherList)
+ (void)getGoodTeacherListByType:(NSString *)type CurrentPageNum:(NSString *)currentPageNum RowOfPage:(NSString *)rowOfPage requestStartBlock:(requestStartBlock)startBlock  responseBlock:(responseBlock)responseBlock
{
    NSDictionary *param = @{
                            @"courseName":type,
                            @"curPageNum":currentPageNum,
                            @"rowOfPage":rowOfPage,
                            };
    [self getWithMethodName:@"api.recommend.goodTeachersList.do" param:param responseBlock:responseBlock];
    if (startBlock) {
        startBlock();
    }
}
@end
