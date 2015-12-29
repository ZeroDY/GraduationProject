//
//  DYRequestBase+LoginRequest.m
//  ASParentTest
//
//  Created by 张浩 on 15/12/17.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "DYRequestBase+LoginRequest.h"

@implementation DYRequestBase (LoginRequest)

+ (void)loginByTel:(NSString *)tel Password:(NSString *)password requestStartBlock:(requestStartBlock)startBlock responseBlock:(responseBlock)responseBlock{
    NSDictionary *param = @{
                            @"tel":tel,
                            @"password":password,
                            };
    [self getWithMethodName:@"api.parent.login.do" param:param responseBlock:responseBlock];
    if (startBlock) {
        startBlock();
    }
}
@end
