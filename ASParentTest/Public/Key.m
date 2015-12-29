//
//  Key.m
//  CZC
//
//  Created by 周德艺 on 15/8/11.
//  Copyright (c) 2015年 周德艺. All rights reserved.
//

#import "Key.h"

#pragma mark - 网络
/** 全局用户对象 */
AccoutObject *kAccountObject = nil;

NSString *const kConnectionFailureError = @"连接失败，请检查网络连接";
NSString *const kRequestTimedOutError  = @"请求超时，请检查连接网络";
NSString *const kAuthenticationError  = @"认证失败，请检查网络连接";

//阿里云地址
NSString *const kPublic_URL = @"http://aishengpc.zzxb.me/";
//李东彬家
//NSString *const kPublic_URL = @"http://192.168.1.108/EducationApi/";
//李东彬公司
//NSString *const kPublic_URL = @"http://172.19.2.168/EducationApi/";

//NSString *const kPublic_URL = @"http://10.0.1.12:8080/EducationApi/";

NSString *const kImage_URL = @"http://asimg.zzxb.me";

/////////////////////////////////////Personal/////////////////////////////////////
/**1 登录 */
NSString *const kLogin = @"api.parent.login.do?";

/**2.1 注册(检测是否有学生) */
NSString *const kRegistOne = @"api.user.checkStuIsExist.do?";
/**2.2 注册 */
NSString *const kRegistTwo = @"api.user.register.do?";

/**3. 修改头像 */
NSString *const kChangePhoto = @"api.picture.upload.do?";

/**4.1 接收通知列表 */
NSString *const kUserMessageList = @"api.message.userMessageList.do?";
/**4.2 接收通知详情 */
NSString *const kMessageSummary = @"api.message.messageSummary.do?";



/////////////////////////////////////////Home/////////////////////////////////////////
/**1 查询成绩列表 */
NSString *const kQueryGrade = @"api.student.queryGrade.do?";


/////////////////////////////////////identification////////////////////////////////////
/**1 查询绑定的学生信息 */
NSString *const kSearchBindStudents = @"api.user.queryChildren.do?";

/**2 查询自己的作业 */
NSString *const kSearchHomeWork = @"api.homework.studentHomeWork.do?";
/**2.1 查询作业详情 */
NSString *const kSearchHomeWorkDetail = @"api.homework.homeWorkSummary.do?";


/**3.1 查询请假列表 */
NSString *const kSearchLeaveList = @"api.leave.getStudentLeaveList.do?";
/**3.2 提交请假申请 */
NSString *const kAddLeaveReport = @"api.leave.addLeave.do?";

/////////////////////////////////////Investigation/////////////////////////////////////
/**1.1  政策调查列表 */
NSString *const kGetZcdcList = @"api.zhengcediaocha.dianchalist.do?";
/**1.2 政策调查问卷详情 */
NSString *const kGetZcdcDetail = @"api.zhengcediaocha.questionList.do?";
/**1.3 提交调查结果信息 */
NSString *const kSubmitZcdcResults = @"api.zhengcediaocha.result.do?";

/**2.1  集思广益列表 */
NSString *const kGetJsgyList = @"api.jsgy.jsgylist.do?";
/**2.2 集思广益详情 */
NSString *const kGetJsgyDetail = @"api.jsgy.jsgysummary.do?";
/**2.3 集思广益评论列表 */
NSString *const kGetJsgyCommentList = @"api.jsgy.jsgyComment.do?";
/**2.4 集思广益发布评论 */
NSString *const kPublishJsgy = @"api.jsgy.saveMycomment.do?";

#pragma mark - 常量
CGFloat const kHUDTime = 1.0f;
CGFloat const kAnimaTime  = 0.30f;
NSString *const kLastCatchTime = @"LastCatchTime";
NSString *const kLastCatchInfoTime = @"LastCatchTime_Info";
NSString *const kIsNetConnect = @"isNetConnect";
NSString *const kPassword = @"password";//密码
NSString *const kPhoneNumber = @"phoneNumber";//用户名
NSString *const kUserInfoDefault = @"userDefault";//用户信息


NSString *const ISAUTOLOGIN = @"isAutoLogin";//是否自动登录的key

/** tabbar最近一次选择的Index */
NSUInteger kLastSelectedIndex = 0;

@implementation Key

@end
