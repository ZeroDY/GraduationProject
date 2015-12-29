//
//  DYBaseRequest.m
//  ASTeacher
//
//  Created by 周德艺 on 15/11/29.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "DYRequestBase.h"
#import "AFNetworking.h"
//阿里云地址
static NSString *kAPI_URL = @"http://asapi.zzxb.me/";
//李东彬家
//static NSString *kAPI_URL = @"http://192.168.1.108/EducationApi/";
//李东彬公司
//static NSString *kAPI_URL = @"http://172.19.2.168/EducationApi/";

@implementation DYRequestBase

+ (DYRequestBase *)shareDYBaseRequest{
    static DYRequestBase *instance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        if(instance == nil){
            instance = [[DYRequestBase alloc]init];
        }
    });
    return instance;
}

+ (void)getWithMethodName:(NSString *)methodName param:(id)param responseBlock:(responseBlock)responseDataBlock {
    NSDictionary *params = (NSDictionary *)param;
    NSString *requestStr = [NSString stringWithFormat:@"%@%@",kAPI_URL,methodName];
    for (int index = 0; index < params.allKeys.count; index ++) {
        NSString *key = params.allKeys[index];
        NSString *value = params[key];
        if (index == 0) {
            requestStr = [requestStr stringByAppendingString:@"?"];
        }else{
            requestStr = [requestStr stringByAppendingString:@"&"];
        }
        requestStr = [requestStr stringByAppendingString:[NSString stringWithFormat:@"%@=%@",key,value]];
    }
    requestStr = [requestStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSLog(@"请求地址-------%@",requestStr);
    [[DYNetworkRequest shareDYNetworkRequest] getRequest:requestStr params:nil success:^(id responseObj) {
        responseDataBlock(responseObj, nil);
    } failure:^(NSError *error) {
        responseDataBlock(nil, error);
    }];
}
+ (void)postWithMethodName:(NSString *)methodName param:(id)param responseBlock:(responseBlock)responseDataBlock {
    NSString *requestStr = [NSString stringWithFormat:@"%@%@",kAPI_URL,methodName];
    NSLog(@"请求地址-------%@",requestStr);
    [[DYNetworkRequest shareDYNetworkRequest] postRequest:requestStr params:param success:^(id responseObj) {
        responseDataBlock(responseObj, nil);
    } failure:^(NSError *error) {
        responseDataBlock(nil, error);
    }];
}

+ (void)putWithUrl:(NSString *)url param:(id)param responseBlock:(responseBlock)responseDataBlock {
    [[DYNetworkRequest shareDYNetworkRequest] putRequest:url params:param success:^(id responseObj) {
        responseDataBlock(responseObj, nil);
    } failure:^(NSError *error) {
        responseDataBlock(nil, error);
    }];
}

+ (void)deleteWithUrl:(NSString *)url param:(id)param  responseBlock:(responseBlock)responseDataBlock {
    
    [[DYNetworkRequest shareDYNetworkRequest] deleteRequest:url params:param success:^(id responseObj) {
        responseDataBlock(responseObj, nil);
    } failure:^(NSError *error) {
        responseDataBlock(nil, error);
    }];
}

@end


//+ (void)getWithMethodName:(NSString *)methodName param:(id)param requestStartBlock:(requestStartBlock)start responseBlock:(responseBlock)responseDataBlock {
//    NSDictionary *params = (NSDictionary *)param;
//    NSString *requestStr = [NSString stringWithFormat:@"%@%@",kAPI_URL,methodName];
//    for (int index = 0; index < params.allKeys.count; index ++) {
//        NSString *key = params.allKeys[index];
//        NSString *value = params[key];
//        if (index == 0) {
//            requestStr = [requestStr stringByAppendingString:@"?"];
//        }else{
//            requestStr = [requestStr stringByAppendingString:@"&"];
//        }
//        requestStr = [requestStr stringByAppendingString:[NSString stringWithFormat:@"%@=%@",key,value]];
//    }
//    requestStr = [requestStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
//    [[DYNetworkRequest shareDYNetworkRequest] getRequest:requestStr params:nil success:^(id responseObj) {
//        responseDataBlock(dataObj, nil);
//    } failure:^(NSError *error) {
//        responseDataBlock(nil, error);
//    }];
//    if (start) {
//        start();
//    }
//}
//+ (void)postWithMethodName:(NSString *)methodName param:(id)param requestStartBlock:(requestStartBlock)start responseBlock:(responseBlock)responseDataBlock {
//    NSString *requestStr = [NSString stringWithFormat:@"%@%@",kAPI_URL,methodName];
//    [[DYNetworkRequest shareDYNetworkRequest] postRequest:requestStr params:param success:^(id responseObj) {
//        responseDataBlock(dataObj, nil);
//    } failure:^(NSError *error) {
//        responseDataBlock(nil, error);
//    }];
//    if (start) {
//        start();
//    }
//}
//
//+ (void)putWithUrl:(NSString *)url param:(id)param requestStartBlock:(requestStartBlock)start responseBlock:(responseBlock)responseDataBlock {
//    [[DYNetworkRequest shareDYNetworkRequest] putRequest:url params:param success:^(id responseObj) {
//        responseDataBlock(dataObj, nil);
//    } failure:^(NSError *error) {
//        responseDataBlock(nil, error);
//    }];
//    if (start) {
//        start();
//    }
//}
//
//+ (void)deleteWithUrl:(NSString *)url param:(id)param  requestStartBlock:(requestStartBlock)start responseBlock:(responseBlock)responseDataBlock {
//    
//    [[DYNetworkRequest shareDYNetworkRequest] deleteRequest:url params:param success:^(id responseObj) {
//        responseDataBlock(dataObj, nil);
//    } failure:^(NSError *error) {
//        responseDataBlock(nil, error);
//    }];
//    if (start) {
//        start();
//    }
//}
//
//
//
//
//@end
