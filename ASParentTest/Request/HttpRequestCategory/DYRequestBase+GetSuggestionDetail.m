//
//  DYRequestBase+GetSuggestionDetail.m
//  ASParentTest
//
//  Created by 张浩 on 15/12/22.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "DYRequestBase+GetSuggestionDetail.h"

@implementation DYRequestBase (GetSuggestionDetail)
+ (void)getSuggestionDetailBySuggestId:(NSString *)suggestId requestStartBlock:(requestStartBlock)startBlock  responseBlock:(responseBlock)responseBlock
{
    NSDictionary *param = @{
                            @"sid":suggestId,
                            };
    [self getWithMethodName:@"api.suggestion.getSuggestionDetail.do" param:param responseBlock:responseBlock];
    if (startBlock) {
        startBlock();
    }
}
@end
