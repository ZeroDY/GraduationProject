//
//  DYRequestBase+PublishJsgy.m
//  ASParentTest
//
//  Created by 张浩 on 15/12/18.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "DYRequestBase+PublishJsgy.h"

@implementation DYRequestBase (PublishJsgy)
+ (void)PublishJsgyByUserId:(NSString *)userId JsgyId:(NSString *)jsgyId CommentContent:(NSString *)commentContent requestStartBlock:(requestStartBlock)startBlock  responseBlock:(responseBlock)responseBlock
{
    NSDictionary *param = @{
                            @"userId":userId,
                            @"brainStormId":jsgyId,
                            @"comment":commentContent,
                            };
    [self getWithMethodName:@"api.jsgy.saveMycomment.do" param:param responseBlock:responseBlock];
    if (startBlock) {
        startBlock();
    }
}
@end
