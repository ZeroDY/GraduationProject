//
//  DYRequestBase+GetJsgyCommentList.m
//  ASParentTest
//
//  Created by 张浩 on 15/12/18.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "DYRequestBase+GetJsgyCommentList.h"

@implementation DYRequestBase (GetJsgyCommentList)
+ (void)GetJsgyCommentListByUserId:(NSString *)userId JsgyId:(NSString *)jsgyId requestStartBlock:(requestStartBlock)startBlock  responseBlock:(responseBlock)responseBlock
{
    NSDictionary *param = @{
                            @"userId":userId,
                            @"brainStormId":jsgyId,
                            };
    [self getWithMethodName:@"api.jsgy.jsgyComment.do" param:param responseBlock:responseBlock];
    if (startBlock) {
        startBlock();
    }
}
@end
