//
//  DYRequestBase+GetJyxcAllObjectById.m
//  ASParentTest
//
//  Created by 张浩 on 15/12/27.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "DYRequestBase+GetJyxcAllObjectById.h"

@implementation DYRequestBase (GetJyxcAllObjectById)
+ (void)getJyxcAllObjectById:(NSString *)uid requestStartBlock:(requestStartBlock)startBlock  responseBlock:(responseBlock)responseBlock
{
    NSDictionary *param = @{
                            @"uid":uid,
                            };
    [self getWithMethodName:@"api.suggestion.getAllObjectById.do" param:param responseBlock:responseBlock];
    if (startBlock) {
        startBlock();
    }

}
@end
