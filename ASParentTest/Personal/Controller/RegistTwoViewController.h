//
//  RegistTwoViewController.h
//  ASParentTest
//
//  Created by 张浩 on 15/11/19.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AutoScrollView.h"

@interface RegistTwoViewController : UIViewController<UITextFieldDelegate>
@property (nonatomic, strong) AutoScrollView *scrollView;
@property (nonatomic, strong) UILabel *phonelab;
@property (nonatomic, strong) UITextField *passwordTextFiled;
@property (nonatomic, strong) UITextField *passwordReTextFiled;
@property (nonatomic, strong) UITextField *verifyCodeTextField;
@property (nonatomic, strong) UIButton *verifycodeBtn;

@property (nonatomic, strong) UIButton *registeBtn;
@property (nonatomic, strong) UIButton *serviceTermButton;
@property (nonatomic, strong) NSTimer *timer;//短信验证码倒计时
@property (nonatomic, assign) int second;//验证码可重发秒数

@property (nonatomic, strong) NSString *phoneStr;

@end
