//
//  DYRequestBase+GetMessageSummary.m
//  ASParentTest
//
//  Created by 张浩 on 15/12/20.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "DYRequestBase+GetMessageSummary.h"

@implementation DYRequestBase (GetMessageSummary)
+ (void)getMessageSummaryByMessageId:(NSString *)messageId requestStartBlock:(requestStartBlock)startBlock  responseBlock:(responseBlock)responseBlock
{
    NSDictionary *param = @{
                            @"messageId":messageId,
                            };
    [self getWithMethodName:@"api.message.messageSummary.do" param:param responseBlock:responseBlock];
    if (startBlock) {
        startBlock();
    }
}
@end
