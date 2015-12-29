//
//  DYRequestBase.h
//  ASTeacher
//
//  Created by 周德艺 on 15/11/29.
//  Copyright © 2015年 周德艺. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "DYNetworkRequest.h"
#import "MJExtension.h"

@interface DYRequestBase : NSObject

+ (DYRequestBase *)shareDYBaseRequest;

/**
 GET请求转模型
 */
+ (void)getWithMethodName:(NSString *)methodName param:(id)param responseBlock:(responseBlock)responseDataBlock;

/**
 POST请求转模型
 */
+ (void)postWithMethodName:(NSString *)methodName param:(id)param responseBlock:(responseBlock)responseDataBlock;

+ (void)putWithUrl:(NSString *)url param:(id)param responseBlock:(responseBlock)responseDataBlock;

+ (void)deleteWithUrl:(NSString *)url param:(id)param responseBlock:(responseBlock)responseDataBlock;

@end


///**
// GET请求转模型
// */
//+ (void)getWithMethodName:(NSString *)methodName param:(id)param requestStartBlock:(requestStartBlock)start responseBlock:(responseBlock)responseDataBlock;
//
///**
// POST请求转模型
// */
//+ (void)postWithMethodName:(NSString *)methodName param:(id)param requestStartBlock:(requestStartBlock)start responseBlock:(responseBlock)responseDataBlock;
//
//+ (void)putWithUrl:(NSString *)url param:(id)param requestStartBlock:(requestStartBlock)start responseBlock:(responseBlock)responseDataBlock;
//
//+ (void)deleteWithUrl:(NSString *)url param:(id)param requestStartBlock:(requestStartBlock)start responseBlock:(responseBlock)responseDataBlock;
//
//@end
