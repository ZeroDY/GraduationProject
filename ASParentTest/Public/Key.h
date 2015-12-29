//
//  Key.h
//  CZC
//
//  Created by 周德艺 on 15/8/11.
//  Copyright (c) 2015年 周德艺. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AccoutObject.h"

#pragma mark - 网络

/** 全局用户对象 */
UIKIT_EXTERN AccoutObject *kAccountObject;

UIKIT_EXTERN double KLongitude;
UIKIT_EXTERN double KLatitude;
UIKIT_EXTERN NSString *KLocation;

/** 连接失败，请检查网络连接 */
UIKIT_EXTERN NSString *const kConnectionFailureError;
/** 请求超时，请检查连接网络 */
UIKIT_EXTERN NSString *const kRequestTimedOutError;
/** 认证失败，请检查网络连接 */
UIKIT_EXTERN NSString *const kAuthenticationError;

/** 接口地址 */
UIKIT_EXTERN NSString *const kPublic_URL;
UIKIT_EXTERN NSString *const kImage_URL;


/////////////////////////////////////Personal/////////////////////////////////////
/**1 登录 */
UIKIT_EXTERN NSString *const kLogin;

/**2.1 注册（检测是否有学生） */
UIKIT_EXTERN NSString *const kRegistOne;
/**2.2 注册 */
UIKIT_EXTERN NSString *const kRegistTwo;

/**3. 修改头像 */
UIKIT_EXTERN NSString *const kChangePhoto;

/**4.1 接收通知列表 */
UIKIT_EXTERN NSString *const kUserMessageList;
/**4.2 接收通知详情 */
UIKIT_EXTERN NSString *const kMessageSummary;

/////////////////////////////////////////Home/////////////////////////////////////////
/**1 查询成绩列表 */
UIKIT_EXTERN NSString *const kQueryGrade;


/////////////////////////////////////Identification/////////////////////////////////////
/**1 查询绑定的学生信息 */
UIKIT_EXTERN NSString *const kSearchBindStudents;

/**2 查询自己的作业 */
UIKIT_EXTERN NSString *const kSearchHomeWork;
/**2.1 查询作业详情 */
UIKIT_EXTERN NSString *const kSearchHomeWorkDetail;

/**3.1 查询请假列表 */
UIKIT_EXTERN NSString *const kSearchLeaveList;
/**3.2 提交请假申请 */
UIKIT_EXTERN NSString *const kAddLeaveReport;

/////////////////////////////////////Investigation/////////////////////////////////////
/**1.1 政策调查列表 */
UIKIT_EXTERN NSString *const kGetZcdcList;
/**1.2 政策调查问卷详情 */
UIKIT_EXTERN NSString *const kGetZcdcDetail;
/**1.3 提交调查结果信息 */
UIKIT_EXTERN NSString *const kSubmitZcdcResults;

/**2.1 集思广益列表 */
UIKIT_EXTERN NSString *const kGetJsgyList;
/**2.2 集思广益详情 */
UIKIT_EXTERN NSString *const kGetJsgyDetail;
/**2.3 集思广益评论列表 */
UIKIT_EXTERN NSString *const kGetJsgyCommentList;
/**2.1 集思广益发布评论 */
UIKIT_EXTERN NSString *const kPublishJsgy;

#pragma mark - 常量
UIKIT_EXTERN CGFloat const kHUDTime;
UIKIT_EXTERN CGFloat const kAnimaTime;
UIKIT_EXTERN NSString *const kLastCatchTime;
UIKIT_EXTERN NSString *const kLastCatchInfoTime;
UIKIT_EXTERN NSString *const kIsNetConnect;
UIKIT_EXTERN NSString *const kPassword;//密码
UIKIT_EXTERN NSString *const kPhoneNumber;//手机号
UIKIT_EXTERN NSString *const kUserInfoDefault;//用户信息
UIKIT_EXTERN NSString *const ISAUTOLOGIN;//是否自动登录的key


#pragma mark - 定义宏

#define HttpRequestService [HttpRequest shareIndex]
#define PublicObj [PublicObject shareIndex]
#define RGB(Red,Green,Blue,Alpha) [UIColor colorWithRed:Red/255.0 green:Green/255.0 blue:Blue/255.0 alpha:Alpha]

//程序主色调
#define MainColor [UIColor colorWithRed:27.0/255.0 green:200/255.0 blue:238.0/255.0 alpha:1.000]
#define BackGroundColor [UIColor colorWithRed:241.0/255.0 green:241.0/255.0 blue:241.0/255.0 alpha:1.0]


#define NavigationColor [UIColor colorWithRed:0/255.0 green:150.0/255.0 blue:245.0/255.0 alpha:1.0]
#define PlaceholderColor [UIColor colorWithRed:89.0/255.0 green:190.0/255.0 blue:231.0/255.0 alpha:0.6]
#define ButtonBackGround [UIColor colorWithRed:0.0/255.0 green:160.0/255.0 blue:253.0/255.0 alpha:1]
#define SCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define IS_IOS8_OR_ABOVE ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define IS_IOS7_OR_ABOVE ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)

#define DefaultImage [UIImage imageNamed:@"tabbar"]


#define NormalFontSize 16               //普通字体大小
#define LeftSpace 35                    //控件左边距
#define ElementHeight 50                //控件高度
#define ButtonHeight 40                 //按钮高度
#define VerifyCodeTime 90               //验证码等待时间


//tabbar最近一次选择的Index
UIKIT_EXTERN NSUInteger kLastSelectedIndex;


//#ifdef IS_IOS8_OR_ABOVE
#define RemoteNotificationTypeAlert UIUserNotificationTypeAlert
#define RemoteNotificationTypeBadge UIUserNotificationTypeBadge
#define RemoteNotificationTypeSound UIUserNotificationTypeSound
#define RemoteNotificationTypeNone  UIUserNotificationTypeNone
//#else
//#define RemoteNotificationTypeAlert UIRemoteNotificationTypeAlert
//#define RemoteNotificationTypeBadge UIRemoteNotificationTypeBadge
//#define RemoteNotificationTypeSound UIRemoteNotificationTypeSound
//#define RemoteNotificationTypeNone  UIRemoteNotificationTypeNone
//#endif



@interface Key : NSObject

@end
