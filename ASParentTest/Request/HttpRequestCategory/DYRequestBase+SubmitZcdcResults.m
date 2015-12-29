//
//  DYRequestBase+SubmitZcdcResults.m
//  ASParentTest
//
//  Created by 张浩 on 15/12/18.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "DYRequestBase+SubmitZcdcResults.h"

@implementation DYRequestBase (SubmitZcdcResults)
+ (void)SubmitZcdcResultsByResultJson:(NSString *)resultJson UserId:(NSString *)userId DiaoChaBiaoId:(NSString *)diaochabiaoId UserType:(NSString *)userType requestStartBlock:(requestStartBlock)startBlock  responseBlock:(responseBlock)responseBlock
{
    NSDictionary *param = @{
                            @"resultJson":resultJson,
                            @"Userid":userId,
                            @"DiaochaBiaoId":diaochabiaoId,
                            @"userType":userType,
                            };
    [self getWithMethodName:@"api.zhengcediaocha.result.do" param:param responseBlock:responseBlock];
    if (startBlock) {
        startBlock();
    }

}
@end