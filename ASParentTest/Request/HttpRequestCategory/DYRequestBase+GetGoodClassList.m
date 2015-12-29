//
//  DYRequestBase+GetGoodClassList.m
//  ASParentTest
//
//  Created by 张浩 on 15/12/21.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "DYRequestBase+GetGoodClassList.h"

@implementation DYRequestBase (GetGoodClassList)
+ (void)getGoodClassListByCurrentPageNum:(NSString *)currentPageNum RowOfPage:(NSString *)rowOfPage requestStartBlock:(requestStartBlock)startBlock  responseBlock:(responseBlock)responseBlock
{
    NSDictionary *param = @{
                            @"curPageNum":currentPageNum,
                            @"rowOfPage":rowOfPage,
                            };
    [self getWithMethodName:@"api.recommend.goodKeTangList.do" param:param responseBlock:responseBlock];
    if (startBlock) {
        startBlock();
    }
}
@end
