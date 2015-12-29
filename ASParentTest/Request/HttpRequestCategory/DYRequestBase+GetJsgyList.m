//
//  DYRequestBase+GetJsgyList.m
//  ASParentTest
//
//  Created by 张浩 on 15/12/18.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "DYRequestBase+GetJsgyList.h"

@implementation DYRequestBase (GetJsgyList)
+ (void)GetJsgyListByUserId:(NSString *)userId CurrentPageNum:(NSString *)currentPageNum RowOfPage:(NSString *)rowOfPage requestStartBlock:(requestStartBlock)startBlock  responseBlock:(responseBlock)responseBlock
{
    NSDictionary *param = @{
                            @"curPageNum":currentPageNum,
                            @"rowOfPage":rowOfPage,
                            };
    [self getWithMethodName:@"api.jsgy.jsgylist.do" param:param responseBlock:responseBlock];
    if (startBlock) {
        startBlock();
    }
}
@end
