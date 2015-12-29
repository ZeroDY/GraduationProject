//
//  DYRequestBase+SearchBindStudentsRequest.m
//  ASParentTest
//
//  Created by 张浩 on 15/12/18.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "DYRequestBase+SearchBindStudentsRequest.h"

@implementation DYRequestBase (SearchBindStudentsRequest)
+ (void)SearchBindStudentsByUserId:(NSString *)userId requestStartBlock:(requestStartBlock)startBlock  responseBlock:(responseBlock)responseBlock
{
    NSDictionary *param = @{
                            @"userId":userId,
                            };
    [self getWithMethodName:@"api.user.queryChildren.do" param:param responseBlock:responseBlock];
    if (startBlock) {
        startBlock();
    }
}
@end
