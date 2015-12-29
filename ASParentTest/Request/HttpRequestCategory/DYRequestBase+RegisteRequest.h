//
//  DYRequestBase+RegisteRequest.h
//  ASParentTest
//
//  Created by 张浩 on 15/12/18.
//  Copyright © 2015年 周德艺. All rights reserved.
//  注册接口

#import "DYRequestBase.h"

@interface DYRequestBase (RegisteRequest)
+ (void)RegisteByTel:(NSString *)tel Password:(NSString *)password requestStartBlock:(requestStartBlock)startBlock  responseBlock:(responseBlock)responseBlock;
@end
