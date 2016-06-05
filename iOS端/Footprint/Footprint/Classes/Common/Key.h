//
//  PersonalViewController.h
//  FootprintWall
//
//  Created by 张浩 on 15/4/15.
//  Copyright (c) 2015年 张浩. All rights reserved.
//
#import <Foundation/Foundation.h>
#ifndef QLWB_Key_h
#define QLWB_Key_h

#pragma mark - URL


//测试环境
//#define kPublic_URL @"http://10.8.68.3:8080/FootMarkWall/jaxrs/"
//#define KImageUpload_URL @"http://10.8.68.3:8080/UploadImage/servlet/UploadImageAction"

//#define kPublic_URL @"http://192.168.1.100:8080/FootMarkWall/jaxrs/"
//#define KImageUpload_URL @"http://192.168.1.100:8080/UploadImage/servlet/UploadImageAction"
#define kPublic_URL @"http://192.168.191.1:8080/FootMarkWall/jaxrs/"
#define KImageUpload_URL @"http://192.168.191.1:8080/UploadImage/servlet/UploadImageAction"
#define KGetImage_URL @"http://192.168.191.1:8080/UploadImage/upload/"

#define FtService [FootService getFootService]

#pragma mark - 网络
#define kConnectionFailureError @"连接失败，请检查网络连接"
#define kRequestTimedOutError   @"请求超时，请检查连接网络"
#define kAuthenticationError    @"认证失败，请检查网络连接"

#pragma mark - 常亮
#define kHUDTime 1.0f
#define kAnimaTime 0.30f
#define kLastCatchTime @"LastCatchTime"
#define kLastCatchInfoTime @"LastCatchTime_Info"
#define kIsNetConnect @"isNetConnect"

#pragma mark - 方法
#define kregister @"userservice/register/"//注册
#define klogin @"userservice/login/"//登录
#define kFinduserbyname @"userservice/finduserbyname/"//查询用户信息
#define kUpdatetruename @"userservice/updatetruename/"//修改昵称
#define kUpdatesex @"userservice/updatesex/"//修改性别
#define kUpdateage @"userservice/updateage/"//修改年龄
#define kUpdatetel @"userservice/updatetel/"//修改电话
#define kUpdatePhoto @"userservice/updatephotourl/"//修改头像
#define KFindWallsByXY @"wallservice/findwallsbyxy/"//通过坐标获取附近墙
#define KCreateWall @"wallservice/createwall?"//创建墙
#define KFindSetWallsByUN @"wallservice/findwallsbyusername/"//通过用户名查找用户建立的墙
#define KFindCollectByUN @"collectservice/findcollectbyusername/"//通过用户名查找用户收藏的墙
#define KFindCollectWallsByUN @"collectservice/findcollectwallsbyusername/"//通过用户名查找用户收藏的墙
#define KCollectWall @"collectservice/collectwall/"//收藏墙
#define KFindCollectMsgsByUN  @"collectservice/findcollectmsgsbyusername/" //通过用户名查找用户收藏的信息
#define KCollectMsg @"collectservice/collectmsg/"//收藏信息
#define KCreateNote @"msgservice/createmsg?"//添加小纸条
#define KComment @"reviewservice/createreview/"//发表评论
#define KFindreviewbymsgid @"reviewservice/findreviewbymsgid/"//根据小纸条id查看所有评论
#define KFindAllMsgByWallid @"msgservice/findallmsgbywallid/"//通过墙id查询墙信息
#define KFindAllAtdByAtdWallid @"atdservice/findallatdbyatdwallid/"//通过墙id获得签到数组签到
#define KCreateAtdWall @"atdwallservice/createatdwall/"//创建签到墙
#define KFindAtdWallsByUN @"atdwallservice/findatdwallsbyusername/"//通过用户名查找用户建立签到墙
#define KFindAtdWallsByXY @"atdwallservice/findatdwallsbyxy/"//通过坐标获取附近墙
#define KAtd @"atdservice/atd/"// 签到
#define KDeleteAtdWall @"atdwallservice/deleteatdwall/"// 删除签到墙
#define KDeleteWall @"wallservice/deletewall/"// 删除签到墙


#define PASSWORD @"password"//密码
#define USERINFO @"userInfo"//用户信息
#define ISAUTOLOGIN @"isAutoLogin"//是否自动登录的key


#define ReadedNews @"ReadedNews"//已读新闻
#define ReadedOpinions @"ReadedOpinions"//已读的带有回复的举报、建议、咨询


#define SCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

//程序主色调
#define DominantColor [UIColor colorWithRed:28.0/255.0 green:164.0/255.0 blue:247.0/255.0 alpha:1.0]
#define NavigationColor [UIColor colorWithRed:0/255.0 green:150.0/255.0 blue:245.0/255.0 alpha:1.0]
#define BackGroundColor [UIColor colorWithRed:243.0/255.0 green:244.0/255.0 blue:250.0/255.0 alpha:1.0]
#define PlaceholderColor [UIColor colorWithRed:89.0/255.0 green:190.0/255.0 blue:231.0/255.0 alpha:0.6]

#define NormalFontSize 16               //普通字体大小
#define LeftSpace 35                    //控件左边距
#define ElementHeight 50                //控件高度
#define ButtonHeight 40                 //按钮高度
#define VerifyCodeTime 90               //验证码等待时间

#define kTitleLength 16  //标题和昵称字数
#define kContentLength 200 //详情，内容，评论字数限制

#define PADDING     10                  //首页悬浮的防范支招按钮的边缘距离

typedef enum _OpinionType {//指南状态
    OpinionTypeReport   = 1,
    OpinionTypeSuggest  = 2,
    OpinionTypeConsult  = 3
} OpinionType;

extern double KLongitude;
extern double KLatitude;
extern NSString *KLocation;

#define APP_URL @"http://itunes.apple.com/lookup?id=903816468"

#define kReportArray [NSArray arrayWithObjects:@"营销诈骗",@"淫秽色情",@"地域攻击",@"其他理由",nil]//举报类型

#endif

