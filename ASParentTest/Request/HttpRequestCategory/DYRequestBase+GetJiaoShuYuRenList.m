//
//  DYRequestBase+GetJiaoShuYuRenList.m
//  ASParentTest
//
//  Created by 张浩 on 15/12/21.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "DYRequestBase+GetJiaoShuYuRenList.h"

@implementation DYRequestBase (GetJiaoShuYuRenList)
+ (void)getJiaoShuYuRenListByCurrentPageNum:(NSString *)currentPageNum RowOfPage:(NSString *)rowOfPage requestStartBlock:(requestStartBlock)startBlock  responseBlock:(responseBlock)responseBlock
{
    NSDictionary *param = @{
                            @"curPageNum":currentPageNum,
                            @"rowOfPage":rowOfPage,
                            };
    [self getWithMethodName:@"api.recommend.jiaoShuYuRenList.do" param:param responseBlock:responseBlock];
    if (startBlock) {
        startBlock();
    }
}
@end
