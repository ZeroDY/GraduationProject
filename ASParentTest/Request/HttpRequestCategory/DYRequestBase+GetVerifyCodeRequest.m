//
//  DYRequestBase+GetVerifyCodeRequest.m
//  ASParentTest
//
//  Created by 张浩 on 15/12/18.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "DYRequestBase+GetVerifyCodeRequest.h"

@implementation DYRequestBase (GetVerifyCodeRequest)
+ (void)getVerifyCodeByTel:(NSString *)tel requestStartBlock:(requestStartBlock)startBlock  responseBlock:(responseBlock)responseBlock{
    NSDictionary *param = @{
                            @"tel":tel,
                            };
    [self getWithMethodName:@"" param:param responseBlock:responseBlock];
    if (startBlock) {
        startBlock();
    }
}
@end
