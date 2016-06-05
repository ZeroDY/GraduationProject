//
//  PublicObject.m
//  FootprintWall
//
//  Created by 张浩 on 15/4/15.
//  Copyright (c) 2015年 张浩. All rights reserved.
//

#import "PublicObject.h"

@implementation PublicObject
/**
 *  将null转换为空
 *
 *  @param oldString 源字符串
 *
 *  @return 新字符串
 */
+ (NSString *)convertNullString:(NSString *)oldString {
    if (oldString != nil && (NSNull *)oldString != [NSNull null]) {
        if ([oldString length] != 0 && ![oldString isEqualToString:@"<null>"]) {
            return  oldString;
        } else {
            return @"";
        }
    } else {
        return @"";
    }
}
//+ (NSNumber *)convertNullNumber:(NSNumber *)oldNum {
//    if (oldNum!=nil && (NSNull *)oldNum != [NSNull null]) {
//        if ([oldNum length] != 0 && ![oldNum isEqualToString:@"<null>"]) {
//            return  oldNum;
//        } else {
//            return @"";
//        }
//    } else {
//        return [NSNumber numberWithInt:0];
//    }
//}
/**
 *  显示提示，然后消失
 *
 *  @param theView
 *  @param theTitle
 *  @param theContent
 *  @param thTime
 */
+(void)showHUDView:(id)theView title:(NSString*)theTitle content:(NSString*)theContent time:(float)thTime {
    
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
    }];
}
//用户名验证
+ (BOOL)validateUsername:(NSString *)username{
    BOOL flag;
    if (username.length < 2 || username.length > 15) {
        flag = NO;
        return flag;
    }
    return YES;
}
//密码验证
+ (BOOL)validatePassword:(NSString *)password {
    BOOL flag;
    if (password.length < 2 || password.length > 12) {
        flag = NO;
        return flag;
    }
    //    NSString *passwordTest = @"[A-Za-z0-9]{6,20}";
    //    NSPredicate *passwordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passwordTest];
    //    return [passwordPredicate evaluateWithObject:password];
    return YES;
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

@end
