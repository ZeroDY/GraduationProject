//
//  DYRequestBase+GetSuggestionList.m
//  ASParentTest
//
//  Created by 张浩 on 15/12/22.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "DYRequestBase+GetSuggestionList.h"

@implementation DYRequestBase (GetSuggestionList)
+ (void)getSuggestionListByUserId:(NSString *)userId CurrentPageNum:(NSString *)currentPageNum RowOfPage:(NSString *)rowOfPage requestStartBlock:(requestStartBlock)startBlock  responseBlock:(responseBlock)responseBlock
{
    NSLog(@"%@",userId);
    NSDictionary *param = @{
                            @"uid":userId,
                            @"curPageNum":currentPageNum,
                            @"rowOfPage":rowOfPage,
                            };
    [self getWithMethodName:@"api.suggestion.getSuggestionListByParent.do" param:param responseBlock:responseBlock];
    if (startBlock) {
        startBlock();
    }
}
@end
