//
//  ViewController.m
//  Footprint
//
//  Created by 周德艺 on 15/4/25.
//  Copyright (c) 2015年 周德艺. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self uploadImageWithImage:@""];
}


- ( void )uploadImageWithImage:( NSString *)imagePath

{
    UIImage *aImage=[UIImage imageNamed:@"d.jpg"];//要上传的图片
//    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    NSDictionary *param=[[NSDictionary alloc] init];
//    [manager POST:@"http://192.168.191.1:8080/RestTest/jaxrs/uploadservice/userphoto?username=xxx" parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        [formData appendPartWithFileData:UIImageJPEGRepresentation(aImage, 10) name:@"uploadimg" fileName:@"d.jpg" mimeType:@"image/jpeg"];
//    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"success");
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"fial%@",error);
//    }];
//
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    
    NSDictionary *parameters =@{@"username":@"value1"};
    
    NSData *imageData = UIImageJPEGRepresentation([UIImage imageNamed:@"d.jpg"], 1.0);
    
    
    [manager POST:@"http://192.168.191.1:8080/RestTest/jaxrs/uploadservice/userphoto?username=fff" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        
        [formData appendPartWithFileData :imageData name:@"d" fileName:@"d.jpg" mimeType:@"image/jpeg"];
        
        
    } success:^(AFHTTPRequestOperation *operation,id responseObject) {
        NSLog(@"Success: %@", responseObject);
        
        
    } failure:^(AFHTTPRequestOperation *operation,NSError *error) {
        NSLog(@"Error: %@", error);
        
        
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
