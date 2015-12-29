//
//  DYRequestBase+GetScoreRequest.h
//  ASParentTest
//
//  Created by 张浩 on 15/12/18.
//  Copyright © 2015年 周德艺. All rights reserved.
//  成绩查询接口

#import "DYRequestBase.h"

@interface DYRequestBase (GetScoreRequest)
+ (void)GetScoreByName:(NSString *)name XuejiNum:(NSString *)xuejiNum ZhunkaozhengNum:(NSString *)zhunkaozhengNum requestStartBlock:(requestStartBlock)startBlock  responseBlock:(responseBlock)responseBlock;

@end
