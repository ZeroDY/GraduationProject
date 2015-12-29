//
//  DYRequestBase+GetVerifyCodeRequest.h
//  ASParentTest
//
//  Created by 张浩 on 15/12/18.
//  Copyright © 2015年 周德艺. All rights reserved.
//  获取验证码接口

#import "DYRequestBase.h"

@interface DYRequestBase (GetVerifyCodeRequest)
+ (void)getVerifyCodeByTel:(NSString *)tel requestStartBlock:(requestStartBlock)startBlock  responseBlock:(responseBlock)responseBlock;

@end
