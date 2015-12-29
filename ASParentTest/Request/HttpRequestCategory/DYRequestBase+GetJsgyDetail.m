//
//  DYRequestBase+GetJsgyDetail.m
//  ASParentTest
//
//  Created by 张浩 on 15/12/18.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "DYRequestBase+GetJsgyDetail.h"

@implementation DYRequestBase (GetJsgyDetail)
+ (void)GetJsgyDetailJsgyId:(NSString *)jsgyId requestStartBlock:(requestStartBlock)startBlock  responseBlock:(responseBlock)responseBlock
{
    NSDictionary *param = @{
                            @"brainStormId":jsgyId,
                            };
    [self getWithMethodName:@"api.jsgy.jsgysummary.do" param:param responseBlock:responseBlock];
    if (startBlock) {
        startBlock();
    }
}
@end
