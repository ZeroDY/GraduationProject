//
//  LoginViewController.m
//  ASParentTest
//
//  Created by 张浩 on 15/11/19.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "LoginViewController.h"
#import "RegistOneViewController.h"
#import "TeacherViewController.h"
#import "AccoutObject.h"
//接口
#import "DYRequestBase+LoginRequest.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"登录";
    //返回按钮
    UIButton* leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,60,30)];
    [leftButton setImage:[UIImage imageNamed:@"arrow_white_left.png"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem= leftItem;
    
    self.scrollView = [[AutoScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 44 - 20)];
    self.scrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.scrollView];
    
    //手机号
    self.phoneNumberTextField =[[UITextField alloc]initWithFrame:CGRectMake(LeftSpace, 50, SCREEN_WIDTH - LeftSpace * 2, ElementHeight)];
    UIView *phoneNumberLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, ElementHeight)];
    UIImageView *phoneNumberLeftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, (ElementHeight - 20) / 2, 20, 20)];
    phoneNumberLeftImageView.image = [UIImage imageNamed:@"userName.png"];
    [phoneNumberLeftView addSubview:phoneNumberLeftImageView];
    self.phoneNumberTextField.leftView = phoneNumberLeftView;
    self.phoneNumberTextField.leftViewMode = UITextFieldViewModeAlways;
    self.phoneNumberTextField.placeholder = @"手机号";
    [self.phoneNumberTextField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    self.phoneNumberTextField.backgroundColor = [UIColor whiteColor];
    self.phoneNumberTextField.layer.borderColor = MainColor.CGColor;
    self.phoneNumberTextField.layer.borderWidth = 0.5f;
    self.phoneNumberTextField.textColor = [UIColor blackColor];
    self.phoneNumberTextField.font = [UIFont systemFontOfSize:12];
    self.phoneNumberTextField.delegate = self;
    [self.scrollView addSubview:self.phoneNumberTextField];
    
    //密码
    self.passwordTextField = [[UITextField alloc]initWithFrame:CGRectMake(LeftSpace, self.phoneNumberTextField.frame.origin.y + self.phoneNumberTextField.frame.size.height, SCREEN_WIDTH - LeftSpace * 2, ElementHeight)];
    UIView *passwordLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, ElementHeight)];
    UIImageView *passwordLeftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, (ElementHeight - 20) / 2, 20, 20)];
    passwordLeftImageView.image = [UIImage imageNamed:@"password.png"];
    [passwordLeftView addSubview:passwordLeftImageView];
    self.passwordTextField.leftView = passwordLeftView;
    self.passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    self.passwordTextField.placeholder = @"输入密码(6-16位数字、字母或组合)";
    [self.passwordTextField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    self.passwordTextField.backgroundColor = [UIColor whiteColor];
    self.passwordTextField.layer.borderColor = MainColor.CGColor;
    self.passwordTextField.layer.borderWidth = 0.5f;
    self.passwordTextField.textColor = [UIColor blackColor];
    self.passwordTextField.font = [UIFont systemFontOfSize:12];
    [self.passwordTextField setSecureTextEntry:YES];
    self.passwordTextField.delegate = self;
    [self.scrollView addSubview:self.passwordTextField];
    
    //登录
    self.loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(LeftSpace, self.passwordTextField.frame.origin.y + self.passwordTextField.frame.size.height + 20, SCREEN_WIDTH - LeftSpace * 2, 40)];
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    self.loginBtn.backgroundColor = MainColor;
    [self.loginBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [self.loginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.loginBtn];
    //注册
    self.registeBtn = [[UIButton alloc]initWithFrame:CGRectMake(LeftSpace, self.loginBtn.frame.origin.y + self.loginBtn.frame.size.height + 10, 60, 30)];
    [self.registeBtn setTitle:@"注册" forState:UIControlStateNormal];
    self.registeBtn.backgroundColor = [UIColor clearColor];
    [self.registeBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [self.registeBtn setTitleColor:MainColor forState:UIControlStateNormal];
    [self.registeBtn addTarget:self action:@selector(regist) forControlEvents:UIControlEventTouchUpInside];
    self.registeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.registeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.scrollView addSubview:self.registeBtn];
    //忘记密码
    self.forgetPwdBtn = [[UIButton alloc]initWithFrame:CGRectMake(LeftSpace+self.loginBtn.frame.size.width-60, self.loginBtn.frame.origin.y + self.loginBtn.frame.size.height + 10, 60, 30)];
    [self.forgetPwdBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    self.forgetPwdBtn.backgroundColor = [UIColor clearColor];
    [self.forgetPwdBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [self.forgetPwdBtn setTitleColor:MainColor forState:UIControlStateNormal];
    [self.forgetPwdBtn addTarget:self action:@selector(forgetPwd) forControlEvents:UIControlEventTouchUpInside];
    self.forgetPwdBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    self.forgetPwdBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.scrollView addSubview:self.forgetPwdBtn];
    //设置scrolleView滑动范围
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH,self.registeBtn.frame.origin.y+self.registeBtn.frame.size.height+30);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//隐藏键盘的方法
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.scrollView endEditing:YES];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
}

#pragma mark - 登录
//http://localhost:8080/EducationPC/api.parent.login.do?tel=123&password=456
-(void)login{
    NSLog(@"login");
    {
        if (self.phoneNumberTextField.text.length == 0) {
            [PublicObject showHUDView:self.view title:@"注意" content:@"手机号不能为空" time:kHUDTime andCodes:^{
            }];
            return;
        }
        //        if (self.phoneNumberTextField.text.length != 11) {
        //            [PublicObject showHUDView:self.view title:@"注意" content:@"手机号格式不正确" time:kHUDTime andCodes:^{
        //            }];
        //            return;
        //        }
        if (self.passwordTextField.text.length==0) {
            [PublicObject showHUDView:self.view title:@"注意" content:@"请填写密码" time:kHUDTime andCodes:^{
            }];
            return;
        }
    }
    NSString *phoneNumber=self.phoneNumberTextField.text;
    NSString *password=self.passwordTextField.text;
    
    //    密码加密
    NSString *enStr = [PublicObject md5:password];
    NSLog(@"%@",enStr);
    [DYRequestBase loginByTel:phoneNumber Password:password requestStartBlock:^{
        [PublicObject showHUDBegain:self.view title:@"正在登录……"];
    } responseBlock:^(id dataObj, NSError *error) {
        NSLog(@"%@",dataObj);
        [PublicObject dissMissHUDEnd];
        if(dataObj){
            NSLog(@"%@",dataObj);
            int status = [[dataObj objectForKey:@"status"] intValue];
            NSString *msg = [PublicObject convertNullString:[dataObj objectForKey:@"msg"]];
            if (status == 0) {
                NSArray *objArr = [dataObj objectForKey:@"obj"];
                NSLog(@"%@",objArr);
                NSDictionary *objDic = [objArr objectAtIndex:0];
                AccoutObject *userObj = [AccoutObject mj_objectWithKeyValues:objDic];
                [PublicObject saveUserInfoDefault:userObj];
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:phoneNumber forKey:kPhoneNumber];
                [defaults setObject:password forKey:kPassword];
                [defaults synchronize];
                self.dismissView(YES);//block回调
                [self dismissViewControllerAnimated:YES completion:^{  }];
            }else{
                [PublicObject showHUDView:self.view title:msg content:@"" time:kHUDTime andCodes:^{
                }];
            }
        }else{
            [PublicObject showHUDView:self.view title:@"请求失败" content:@"" time:1 andCodes:^{
            }];
        }
    }];
}

#pragma mark - 跳转注册页面
-(void)regist{
    NSLog(@"Regist");
    RegistOneViewController *registerVC = [[RegistOneViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
}

#pragma mark - 忘记密码
-(void)forgetPwd{
    //    FindPWViewController *findPW = [[FindPWViewController alloc]init];
    //    findPW.title = @"忘记密码";
    //    [self.navigationController pushViewController:findPW animated:YES];
}

#pragma mark - 文本协议
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)backClick{
    self.dismissView(NO);
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

@end
