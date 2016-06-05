//
//  FootService.h
//  Footprint
//
//  Created by 张浩 on 15/4/27.
//  Copyright (c) 2015年 周德艺. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@interface FootService : NSObject{
    void(^myresulthandle)(NSDictionary *myresult);
}
+ (FootService *)getFootService;
- (void) GETmethod:(NSString *) methodName andParameters:(NSString *) parameters andHandle:(void(^)(NSDictionary *myresult)) handle;
- (void) POSTmethod:(NSString *) methodName andParameters:(NSString *) parameters andHandle:(void(^)(NSDictionary *myresult)) handle;
-(void)postUploadWithUrl:(NSString *)urlStr fileImage:(UIImage *)image fileName:(NSString *)fileName success:(void (^)(id responseObject))success fail:(void (^)())fail;

@end
