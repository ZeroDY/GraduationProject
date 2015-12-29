//
//  PublicObject.h
//  EnjoyCAPP
//
//  Created by ONCE on 14-1-9.
//  Copyright (c) 2014年 ONCE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccoutObject.h"
@interface PublicObject : NSObject


@property(nonatomic ,strong) NSDateFormatter *dateFormate;

+ (void)saveUserInfoDefault:(AccoutObject *)user;//保存个人信息
+ (AccoutObject *)getUserInfoDefault;
/**
 *	图片数组转化
 */
+ (NSMutableArray *)getImageList:(NSString *)imageStr;
/**
 *	图片放大
 */
+(void)showImage:(UIButton*)avatarImageView;

+ (void)showHUDView:(id)theView title:(NSString*)theTitle content:(NSString*)theContent time:(float)thTime andCodes:(void(^)())finish;
+ (void)showHUDBegain:(id)theView title:(NSString *)theTitle;
+ (void)dissMissHUDEnd;

+ (NSString*)convertNullString:(NSString *)oldString;
+ (NSNumber*)convertNullNumber:(NSNumber*)oldNum;

+ (UIImage *)fixOrientation:(UIImage *)aImage;//图片旋转
+ (NSString *)phoneModelString;//获取设备名称
+ (NSString *)md5:(NSString *)str;//md5加密
+ (NSString *)buildRequstData:(NSMutableDictionary *)requestDic;;//数据签名


//+ (float) heightForTextView: (UITextView *)textView WithText: (NSString *) strText;

//验证邮箱
+ (BOOL)isEmailAddress:(NSString*)candidate;
//验证用户名
+ (BOOL)isUserName:(NSString*)candidate;
//验证密码
+ (BOOL)isPassword:(NSString*)candidate;
//手机号
+ (BOOL)isTel:(NSString*)candidate;
//日期转周几
+ (NSString*)weekdayStringFromDate:(NSString *)inputDateStr;

@end
