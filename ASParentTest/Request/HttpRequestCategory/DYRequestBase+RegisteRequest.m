//
//  DYRequestBase+RegisteRequest.m
//  ASParentTest
//
//  Created by 张浩 on 15/12/18.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "DYRequestBase+RegisteRequest.h"

@implementation DYRequestBase (RegisteRequest)
+ (void)RegisteByTel:(NSString *)tel Password:(NSString *)password requestStartBlock:(requestStartBlock)startBlock  responseBlock:(responseBlock)responseBlock;
{
    NSDictionary *param = @{
                            @"tel":tel,
                            @"Password":password,
                            };
    [self getWithMethodName:@"api.user.register.do" param:param responseBlock:responseBlock];
    if (startBlock) {
        startBlock();
    }
}
@end
