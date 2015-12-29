//
//  DYRequestBase+CheckUserTelRequest.m
//  ASParentTest
//
//  Created by 张浩 on 15/12/17.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "DYRequestBase+CheckUserTelRequest.h"

@implementation DYRequestBase (CheckUserTelRequest)
+ (void)cheackUserTelByTel:(NSString *)tel requestStartBlock:(requestStartBlock)startBlock responseBlock:(responseBlock)responseBlock{
    NSDictionary *param = @{
                            @"tel":tel,
                            };
    [self getWithMethodName:@"api.user.checkStuIsExist.do" param:param responseBlock:responseBlock];
    if (startBlock) {
        startBlock();
    }
}
@end
