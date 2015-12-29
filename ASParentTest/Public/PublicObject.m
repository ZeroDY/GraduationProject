//
//  PublicObject.m
//  EnjoyCAPP
//
//  Created by ONCE on 14-1-9.
//  Copyright (c) 2014年 ONCE. All rights reserved.
//


#import "PublicObject.h"
#import "AppDelegate.h"
#include <sys/sysctl.h>
#include <sys/types.h>
#import <CommonCrypto/CommonDigest.h>

static CGRect oldframe;

@implementation PublicObject

- (id)init{
    self = [super init];
    if (self) {
        NSDateFormatter *dateForm = [[NSDateFormatter alloc] init];
        [dateForm setDateFormat:@"yyyy-MM-dd"];
        self.dateFormate = dateForm;
    }
    return self;
}
//存储用户信息
+ (void)saveUserInfoDefault:(AccoutObject *)user{
    NSLog(@"%@",user);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *userDic = user.mj_keyValues;
    [defaults setObject:userDic forKey:kUserInfoDefault];
    [defaults synchronize];
}


//获取用户信息
+(AccoutObject *)getUserInfoDefault{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *userDic = [defaults objectForKey:kUserInfoDefault];
    AccoutObject *user = [[AccoutObject alloc]init];
    if(userDic == nil)
    {
        return nil;
    }
    else{
        user = [AccoutObject mj_objectWithKeyValues:userDic];
        return user;
    }
}
+ (NSMutableArray *)getImageList:(NSString *)imageStr{
    NSArray *list = [imageStr componentsSeparatedByString:@","];
    NSMutableArray *imageUrlList = [[NSMutableArray alloc]init];
    for (NSString *dic in list) {
        NSString *imageUrl = [NSString stringWithFormat:@"%@%@",kImage_URL,dic];
        [imageUrlList addObject:imageUrl];
    }
    return imageUrlList;
}
+(void)showImage:(UIButton *)avatarImageView{
    UIImage *image=[avatarImageView imageForState:UIControlStateNormal];
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    UIView *backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    oldframe=[avatarImageView convertRect:avatarImageView.bounds toView:window];
    backgroundView.backgroundColor=[UIColor blackColor];
    backgroundView.alpha=0;
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:oldframe];
    imageView.image=image;
    imageView.tag=1;
    [backgroundView addSubview:imageView];
    [window addSubview:backgroundView];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage:)];
    [backgroundView addGestureRecognizer: tap];
    
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame=CGRectMake(0,([UIScreen mainScreen].bounds.size.height-image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width)/2, [UIScreen mainScreen].bounds.size.width, image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width);
        backgroundView.alpha=1;
    } completion:^(BOOL finished) {
        
    }];
}

+(void)hideImage:(UITapGestureRecognizer*)tap{
    UIView *backgroundView=tap.view;
    UIImageView *imageView=(UIImageView*)[tap.view viewWithTag:1];
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame=oldframe;
        backgroundView.alpha=0;
    } completion:^(BOOL finished) {
        [backgroundView removeFromSuperview];
    }];
}
//验证邮箱
+ (BOOL)isEmailAddress:(NSString*)candidate
{
    NSString* emailRegex = @"^[a-zA-Z0-9_]{1,16}+@([a-zA-Z0-9_]|-)+(\\.([a-zA-Z0-9_]|-)+)+$";
    NSPredicate* emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:candidate];
}
//验证用户名
+ (BOOL)isUserName:(NSString*)candidate
{
    NSString* usernameRegex = @"^[a-zA-Z]{1}([a-zA-Z0-9]|[._]){3,19}$";
    NSPredicate* usernameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", usernameRegex];
    return [usernameTest evaluateWithObject:candidate];
}
//验证密码
+ (BOOL)isPassword:(NSString*)candidate
{
    NSString* passwordRegex = @"^[a-zA-Z0-9_]{6,16}$";
    NSPredicate* passwordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passwordRegex];
    return [passwordTest evaluateWithObject:candidate];
}
//手机号
+ (BOOL)isTel:(NSString*)candidate
{
    NSString* telRegex = @"^1[3|4|5|8][0-9]\\d{8}$";
    NSPredicate* telTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", telRegex];
    return [telTest evaluateWithObject:candidate];
}

/**
 *  将null转换为空
 *
 *  @param oldString 源字符串
 *
 *  @return 新字符串
 */
+(NSString*)convertNullString:(NSString*)oldString{
    if (oldString!=nil && (NSNull *)oldString != [NSNull null]) {
        if ([oldString length]!=0) {
            if ([oldString isEqualToString:@"(null)"]) {
                return @"";
            }
            return  oldString;
        }else{
            return @"";
        }
    }
    else{
        return @"";
    }
}

+(NSNumber*)convertNullNumber:(NSNumber*)oldNum{
    if (oldNum!=nil && (NSNull *)oldNum != [NSNull null]) {
        return  oldNum;
    }
    else{
        return [NSNumber numberWithInt:0];
    }
}

/**
 *  NSString 转换成  图片
 *
 *  @return
 */
//+(UIImage*)convertStrToImage:(NSString *)imgByte{
//    if ([imgByte length]==0) {
//        UIImage *defautImg =[UIImage imageNamed:@"d_default"];
//        return defautImg;
//    }
//    NSData *data = [imgByte dataUsingEncoding: NSASCIIStringEncoding];
//    NSData *baseData = [GTMBase64 decodeData:data];
////    UIImage *image =[UIImage imageWithData:baseData scale:320/170];
//    UIImage *image =[UIImage imageWithData:baseData];
//    return  image;
//}


//构建加密签名请求参数
+(NSString *)buildRequstData:(NSMutableDictionary *)requestDic{
    //加入时间戳
    NSDateFormatter *datef =[[NSDateFormatter alloc] init];
    [datef setDateFormat:@"yyyyMMddHHmm"];
    NSString *dateStr =[datef stringFromDate:[NSDate date]];
    [requestDic setValue:dateStr forKey:@"reqTime"];

    NSArray *allKeyArry= [[requestDic allKeys] sortedArrayUsingSelector:@selector(compare:)];
    NSString *questStr=@"";//请求参数，如果有空值，则不加入
    NSString *lastQuestStr=@"";//所有请求参数
    
    for (int i=0;i<[allKeyArry count];i++) {
        NSString *key = allKeyArry[i];
        NSString *value = requestDic[key];
        if (i==[allKeyArry count]-1) {
            if ([[PublicObject convertNullString:value] length]>0) {
                questStr = [questStr stringByAppendingFormat:@"%@=%@",key,value];
            }
            lastQuestStr = [lastQuestStr stringByAppendingFormat:@"%@=%@",key,value];
        }else{
            if ([[PublicObject convertNullString:value] length]>0) {
                questStr = [questStr stringByAppendingFormat:@"%@=%@&",key,value];
            }
            lastQuestStr = [lastQuestStr stringByAppendingFormat:@"%@=%@&",key,value];
        }
    }
    NSLog(@"keyStr===%@",questStr);
    NSLog(@"keyStr===%@",lastQuestStr);
    NSString *key =@"77e487c7e29d441ea142dcefab11e021";//公用key
    NSString *indataStr =[NSString stringWithFormat:@"%@%@",questStr,key];
    NSLog(@"----%@---",indataStr);
    NSString *md5Str= [PublicObject md5:indataStr];
    md5Str= [md5Str lowercaseString];
    NSLog(@"----%@---",md5Str);
//    NSString *result =[NSString stringWithFormat:@"%@&sign=%@",lastQuestStr,md5Str];//元参数+sign=zhaoyao
    [requestDic setValue:md5Str forKey:@"sign"];
    return md5Str;
}


/**
 *  显示提示，然后消失
 *
 *  @param theView
 *  @param theTitle
 *  @param theContent
 *  @param thTime
 *  @param andCodes
 */
+(void)showHUDView:(id)theView title:(NSString *)theTitle content:(NSString *)theContent time:(float)thTime andCodes:(void (^)())finish{
    UIView *aView        = (id)theView;
    MBProgressHUD*HUD    = [[MBProgressHUD alloc] initWithView:aView];
    [aView addSubview:HUD];
    HUD.labelText        = [NSString stringWithFormat:@"%@",theTitle];
    HUD.detailsLabelText = [NSString stringWithFormat:@"%@",theContent];
    HUD.mode             = MBProgressHUDModeText;
    
    [HUD showAnimated:YES whileExecutingBlock:^{
        sleep(thTime);
    } completionBlock:^{
        [HUD removeFromSuperview];
        finish();
    }];
}


+(void)showHUDBegain:(id)theView title:(NSString *)theTitle{
    [[MBProgressView shareMBProgressView] showProgressHUD:theView title:theTitle];
}

+(void)dissMissHUDEnd{
    [[MBProgressView shareMBProgressView] dissMissProgressHUD];
}


+(NSString *)md5:(NSString *)str {
    const char *cStr = [str UTF8String];//转换成utf-8
    unsigned char result[16];//开辟一个16字节（128位：md5加密出来就是128位/bit）的空间（一个字节=8字位=8个二进制数）
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    /*
     添加属性(CC_LONG)
     extern unsigned char *CC_MD5(const void *data, CC_LONG len, unsigned char *md)官方封装好的加密方法
     把cStr字符串转换成了32位的16进制数列（这个过程不可逆转） 存储到了result这个空间中
     */
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
    /*
     x表示十六进制，%02X  意思是不足两位将用0补齐，如果多余两位则不影响
     NSLog("%02X", 0x888);  //888
     NSLog("%02X", 0x4); //04
     */
}


//日期转周几
+ (NSString*)weekdayStringFromDate:(NSString *)inputDateStr {
    
    NSLog(@"%@",inputDateStr);
    //NSString转nsdata
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *inputDate = [dateFormatter dateFromString:inputDateStr];
    NSArray *weekdays = [NSArray arrayWithObjects:@"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSWeekdayCalendarUnit;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    NSLog(@"%ld",(long)theComponents.weekday);
    NSLog(@"%@",[weekdays objectAtIndex:theComponents.weekday]);
    return [weekdays objectAtIndex:theComponents.weekday-1];
    
}

+ (UIImage *)fixOrientation:(UIImage *)aImage {
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }

    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

//可通过苹果review
+ (NSString *)getDeviceVersion {
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = (char*)malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    //NSString *platform = [NSStringstringWithUTF8String:machine];二者等效
    free(machine);
    return platform;
}

+ (NSString *)phoneModelString {
    NSString *platform = [self getDeviceVersion];
    if ([platform isEqualToString:@"i386"])       return @"Simulator";
    else if ([platform isEqualToString:@"x86_64"])      return @"Simulator";
    else if ([platform isEqualToString:@"iPhone2,1"])   return @"iPhone 3GS";
    else if ([platform isEqualToString:@"iPhone3,1"])   return @"iPhone4 GSM";
    else if ([platform isEqualToString:@"iPhone3,2"])   return @"iPhone4 8G";
    else if ([platform isEqualToString:@"iPhone3,3"])   return @"iPhone4 CDMA";
    else if ([platform isEqualToString:@"iPhone4,1"] || [platform isEqualToString:@"iPhone4,2"])   return @"iPhone4S";
    else if ([platform isEqualToString:@"iPhone5,1"] || [platform isEqualToString:@"iPhone5,2"])   return @"iPhone5";
    else if ([platform isEqualToString:@"iPhone5,3"] || [platform isEqualToString:@"iPhone5,4"])   return @"iPhone5C";
    else if ([platform isEqualToString:@"iPhone6,1"] || [platform isEqualToString:@"iPhone6,2"])   return @"iPhone5S";
    else if ([platform isEqualToString:@"iPhone7,1"])   return @"iPhone6 Plus";
    else if ([platform isEqualToString:@"iPhone7,2"])   return @"iPhone6";
    else if ([platform isEqualToString:@"iPod4,1"])     return@"iPod Touch 4";
    else if ([platform isEqualToString:@"iPod5,1"])     return@"iPod Touch 5";
    else if ([platform isEqualToString:@"iPad2,1"] || [platform isEqualToString:@"iPad2,2"] || [platform isEqualToString:@"iPad2,3"] || [platform isEqualToString:@"iPad2,4"])     return @"iPad2";
    else if ([platform isEqualToString:@"iPad2,5"] || [platform isEqualToString:@"iPad2,6"] || [platform isEqualToString:@"iPad2,7"])     return @"iPad mini";
    else if ([platform isEqualToString:@"iPad3,1"] || [platform isEqualToString:@"iPad3,2"] || [platform isEqualToString:@"iPad3,3"])     return @"iPad3";
    else if ([platform isEqualToString:@"iPad3,4"] || [platform isEqualToString:@"iPad3,5"] || [platform isEqualToString:@"iPad3,6"])     return @"iPad4";
    else if ([platform isEqualToString:@"iPad4,1"] || [platform isEqualToString:@"iPad4,2"] || [platform isEqualToString:@"iPad4,3"])     return @"iPad Air";
    else if ([platform isEqualToString:@"iPad4,4"] || [platform isEqualToString:@"iPad4,5"] || [platform isEqualToString:@"iPad4,6"])     return @"iPad mini retain";
    else
        return platform;
}

////获取 TextView的高度
//+ (float) heightForTextView: (UITextView *)textView WithText: (NSString *) strText{
//    float fPadding = 16.0; // 8.0px x 2
//    CGSize constraint = CGSizeMake(textView.contentSize.width - fPadding, CGFLOAT_MAX);
////    CGSize size = [strText sizeWithFont: textView.font constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
//    NSDictionary *attributes = @{NSFontAttributeName:textView.font};
//    CGRect rect = [strText boundingRectWithSize:constraint
//                                              options:NSStringDrawingUsesLineFragmentOrigin
//                                           attributes:attributes
//                                              context:nil];
//
//    float fHeight = rect.size.height + 16.0;
//    return fHeight;
//}

@end

