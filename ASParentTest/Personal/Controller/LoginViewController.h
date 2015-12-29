//
//  LoginViewController.h
//  ASParentTest
//
//  Created by 张浩 on 15/11/19.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AutoScrollView.h"

@interface LoginViewController : UIViewController<UITextFieldDelegate>
@property (nonatomic, strong) AutoScrollView *scrollView;
@property (nonatomic, strong) UITextField *phoneNumberTextField;
@property (nonatomic, strong) UITextField *passwordTextField;

@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UIButton *registeBtn;
@property (nonatomic, strong) UIButton *forgetPwdBtn;

@property (strong, nonatomic) void (^dismissView)(BOOL isSuccess);


@end
