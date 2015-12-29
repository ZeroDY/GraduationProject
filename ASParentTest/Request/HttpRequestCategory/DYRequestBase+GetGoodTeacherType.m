//
//  DYRequestBase+GetGoodTeacherType.m
//  ASParentTest
//
//  Created by 张浩 on 15/12/21.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "DYRequestBase+GetGoodTeacherType.h"

@implementation DYRequestBase (GetGoodTeacherType)
+ (void)getGoodTeacherTypeRequestStartBlock:(requestStartBlock)startBlock  responseBlock:(responseBlock)responseBlock
{
    [self getWithMethodName:@"api.recommend.teacherCourse.do" param:nil responseBlock:responseBlock];
    if (startBlock) {
        startBlock();
    }
}
@end
