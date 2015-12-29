//
//  DYRequestBase+LoginRequest.h
//  ASParentTest
//
//  Created by 张浩 on 15/12/17.
//  Copyright © 2015年 周德艺. All rights reserved.
//  登录请求接口

#import "DYRequestBase.h"

@interface DYRequestBase (LoginRequest)
+ (void)loginByTel:(NSString *)tel Password:(NSString *)password requestStartBlock:(requestStartBlock)startBlock  responseBlock:(responseBlock)responseBlock;

@end
