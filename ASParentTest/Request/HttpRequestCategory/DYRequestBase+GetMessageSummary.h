//
//  DYRequestBase+GetMessageSummary.h
//  ASParentTest
//
//  Created by 张浩 on 15/12/20.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "DYRequestBase.h"

@interface DYRequestBase (GetMessageSummary)
+ (void)getMessageSummaryByMessageId:(NSString *)messageId requestStartBlock:(requestStartBlock)startBlock  responseBlock:(responseBlock)responseBlock;

@end
