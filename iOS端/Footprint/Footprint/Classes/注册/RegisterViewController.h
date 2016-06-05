//
//  RegisterViewController.h
//  FootprintWall
//
//  Created by 张浩 on 15/4/16.
//  Copyright (c) 2015年 张浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController<UITextFieldDelegate,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) UITextField *userNameTextField;
@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) UITextField *trueNameTextField;
@property (nonatomic, strong) UIButton *registerBtn;


@property (nonatomic, strong) UIButton *serviceTermButton;
@property (nonatomic, strong) UIButton *agreeButton;
@property (nonatomic, assign) BOOL isAgree;//是否统一服务条款
@end
