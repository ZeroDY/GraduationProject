//
//  FootService.m
//  Footprint
//
//  Created by 张浩 on 15/4/27.
//  Copyright (c) 2015年 周德艺. All rights reserved.
//

#import "FootService.h"

static FootService *footsv;
@implementation FootService
+(FootService *)getFootService{
    if (footsv == nil)
    {
        footsv = [[FootService alloc]init];
    }
    return footsv;
}
-(void)GETmethod:(NSString *)methodName andParameters:(NSString *)parameters andHandle:(void (^)(NSDictionary *))handle{
    NSString *requrl = [NSString stringWithFormat:@"%@%@%@",kPublic_URL,methodName,parameters];
    requrl = [requrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@" 请求地址：%@",requrl);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain",@"text/html", @"text/json", @"text/javascript", nil];
    [manager GET:requrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"____成功");
        NSLog(@"JSON: %@", responseObject);
        handle((NSDictionary *) responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"____失败");
        NSLog(@"error: %@",error);
    }];
}

- (void)POSTmethod:(NSString *)methodName andParameters:(NSString *)parameters andHandle:(void (^)(NSDictionary *))handle{
    NSString *requrl = [NSString stringWithFormat:@"%@%@",kPublic_URL,methodName];
    requrl = [requrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain",@"text/html", @"text/json", @"text/javascript", nil];
    [manager POST:requrl parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        handle((NSDictionary *) responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}


-(void)postUploadWithUrl:(NSString *)urlStr fileImage:(UIImage *)image fileName:(NSString *)fileName success:(void (^)(id responseObject))success fail:(void (^)())fail
{
    // 本地上传给服务器时,没有确定的URL,不好用MD5的方式处理
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlStr parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        //        NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"loginBackGround.png" withExtension:nil];
        //
        //        // 要上传保存在服务器中的名称
        //        // 使用时间来作为文件名 2014-04-30 14:20:57.png
        //        // 让不同的用户信息,保存在不同目录中
        //        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        //        // 设置日期格式
        //        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        //        NSString *fileName = [formatter stringFromDate:[NSDate date]];
        
        NSData *data;
        if (UIImagePNGRepresentation(image) == nil) {
            data = UIImageJPEGRepresentation(image, 1);
        } else {
            data = UIImagePNGRepresentation(image);
        }
        [formData appendPartWithFileData:data name:fileName fileName:fileName mimeType:@"image/png"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (fail) {
            fail();
        }
    }];
}

@end
