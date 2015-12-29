//
//  DYRequestBase+GetZcdcList.m
//  ASParentTest
//
//  Created by 张浩 on 15/12/18.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "DYRequestBase+GetZcdcList.h"

@implementation DYRequestBase (GetZcdcList)
+ (void)GetZcdcListByUserId:(NSString *)userId CurrentPageNum:(NSString *)currentPageNum RowOfPage:(NSString *)rowOfPage requestStartBlock:(requestStartBlock)startBlock  responseBlock:(responseBlock)responseBlock
{
    NSLog(@"%@",userId);
    NSDictionary *param = @{
                            @"userId":userId,
                            @"curPageNum":currentPageNum,
                            @"rowOfPage":rowOfPage,
                            };
    [self getWithMethodName:@"api.zhengcediaocha.dianchalist.do" param:param responseBlock:responseBlock];
    if (startBlock) {
        startBlock();
    }
}
@end
