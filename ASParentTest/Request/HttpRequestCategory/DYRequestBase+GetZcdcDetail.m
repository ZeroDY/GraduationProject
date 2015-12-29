//
//  DYRequestBase+GetZcdcDetail.m
//  ASParentTest
//
//  Created by 张浩 on 15/12/18.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "DYRequestBase+GetZcdcDetail.h"

@implementation DYRequestBase (GetZcdcDetail)
+ (void)GetZcdcDetailByWenJuanId:(NSString *)wenjuanId requestStartBlock:(requestStartBlock)startBlock  responseBlock:(responseBlock)responseBlock
{
    NSDictionary *param = @{
                            @"WenJuanId":wenjuanId,
                            };
    [self getWithMethodName:@"api.zhengcediaocha.questionList.do" param:param responseBlock:responseBlock];
    if (startBlock) {
        startBlock();
    }
}
@end
