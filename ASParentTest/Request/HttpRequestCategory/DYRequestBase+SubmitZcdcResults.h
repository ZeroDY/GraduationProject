//
//  DYRequestBase+SubmitZcdcResults.h
//  ASParentTest
//
//  Created by 张浩 on 15/12/18.
//  Copyright © 2015年 周德艺. All rights reserved.
//  提交政策调查问卷结果接口

#import "DYRequestBase.h"

@interface DYRequestBase (SubmitZcdcResults)
+ (void)SubmitZcdcResultsByResultJson:(NSString *)resultJson UserId:(NSString *)userId DiaoChaBiaoId:(NSString *)diaochabiaoId UserType:(NSString *)userType requestStartBlock:(requestStartBlock)startBlock  responseBlock:(responseBlock)responseBlock;
@end
