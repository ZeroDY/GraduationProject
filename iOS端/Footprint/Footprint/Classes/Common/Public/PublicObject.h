//
//  PublicObject.h
//  FootprintWall
//
//  Created by 张浩 on 15/4/15.
//  Copyright (c) 2015年 张浩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SDWebImage/UIImageView+WebCache.h>
@interface PublicObject : NSObject

+(NSString*)convertNullString:(NSString *)oldString;
+(NSNumber*)convertNullNumber:(NSNumber*)oldNum;

//+(void)showHUDView:(id)theView title:(NSString*)theTitle content:(NSString*)theContent time:(float)thTime;
+ (BOOL)validateUsername:(NSString *)username;//用户名验证
+ (BOOL)validatePassword:(NSString *)password;//密码验证
+ (UIImage *)fixOrientation:(UIImage *)aImage;//图片旋转
+(void)showHUDView:(id)theView title:(NSString*)theTitle content:(NSString*)theContent time:(float)thTime;//提示
@end
