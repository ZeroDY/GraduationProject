//
//  DYRequestBase+CheckUserTelRequest.h
//  ASParentTest
//
//  Created by 张浩 on 15/12/17.
//  Copyright © 2015年 周德艺. All rights reserved.
//  注册第一步，检测用户的手机号是否绑定学生

#import "DYRequestBase.h"

@interface DYRequestBase (CheckUserTelRequest)
+ (void)cheackUserTelByTel:(NSString *)tel requestStartBlock:(requestStartBlock)startBlock  responseBlock:(responseBlock)responseBlock;

@end
