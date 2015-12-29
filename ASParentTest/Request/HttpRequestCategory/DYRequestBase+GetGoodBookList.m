//
//  DYRequestBase+GetGoodBookList.m
//  ASParentTest
//
//  Created by 张浩 on 15/12/21.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "DYRequestBase+GetGoodBookList.h"

@implementation DYRequestBase (GetGoodBookList)
+ (void)getGoodBookListByCurrentPageNum:(NSString *)currentPageNum RowOfPage:(NSString *)rowOfPage requestStartBlock:(requestStartBlock)startBlock  responseBlock:(responseBlock)responseBlock
{
    NSDictionary *param = @{
                            @"curPageNum":currentPageNum,
                            @"rowOfPage":rowOfPage,
                            };
    [self getWithMethodName:@"api.recommend.goodBookList.do" param:param responseBlock:responseBlock];
    if (startBlock) {
        startBlock();
    }

}
@end
