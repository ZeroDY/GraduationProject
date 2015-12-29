//
//  DYRequestBase+GetUserMessageList.m
//  ASParentTest
//
//  Created by 张浩 on 15/12/20.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "DYRequestBase+GetUserMessageList.h"

@implementation DYRequestBase (GetUserMessageList)
+ (void)getUserMessageListByUserId:(NSString *)userId CurrentPageNum:(NSString *)currentPageNum RowOfPage:(NSString *)rowOfPage requestStartBlock:(requestStartBlock)startBlock  responseBlock:(responseBlock)responseBlock
{
    NSDictionary *param = @{
                            @"studentId":userId,
                            @"curPageNum":currentPageNum,
                            @"rowOfPage":rowOfPage,
                            };
    [self getWithMethodName:@"api.message.userMessageList.do" param:param responseBlock:responseBlock];
    if (startBlock) {
        startBlock();
    }
}
@end
