//
//  RegistTwoViewController.m
//  ASParentTest
//
//  Created by 张浩 on 15/11/19.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "RegistTwoViewController.h"
#import "UserProtocolViewController.h"
//接口
#import "DYRequestBase+GetVerifyCodeRequest.h"
#import "DYRequestBase+RegisteRequest.h"
@interface RegistTwoViewController ()

@end

@implementation RegistTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [super viewDidLoad];
    self.title = @"注册";
    
    //返回按钮
    UIButton* leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,60,30)];
    [leftButton setImage:[UIImage imageNamed:@"arrow_white_left.png"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem= leftItem;
    
    
    self.scrollView = [[AutoScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 44 - 20)];
    self.scrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.scrollView];
    //手机号Lab
    self.phonelab = [[UILabel alloc]initWithFrame:CGRectMake(LeftSpace, 30, self.scrollView.frame.size.width - LeftSpace * 2, ElementHeight)];
    self.phonelab.textColor = [UIColor lightGrayColor];
    self.phonelab.text = [NSString stringWithFormat:@"验证短信已发送至%@",self.phoneStr];
    self.phonelab.font = [UIFont systemFontOfSize:14];
    [self.scrollView addSubview:self.phonelab];
    
    //验证码
    self.verifyCodeTextField = [[UITextField alloc]initWithFrame:CGRectMake(LeftSpace, self.phonelab.frame.origin.y + self.phonelab.frame.size.height+5, self.scrollView.frame.size.width - LeftSpace * 2, ElementHeight)];
    //验证码Left
    UIView *verifyCodeLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, ElementHeight)];
    UIImageView *verifyCodeLeftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, (ElementHeight - 20) / 2, 20, 20)];
    verifyCodeLeftImageView.image = [UIImage imageNamed:@"verifyCode.png"];
    [verifyCodeLeftView addSubview:verifyCodeLeftImageView];
    self.verifyCodeTextField.leftView = verifyCodeLeftView;
    self.verifyCodeTextField.leftViewMode = UITextFieldViewModeAlways;
    //验证码Right
    UIView *verifyCodeRightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, ElementHeight)];
    self.verifycodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.verifycodeBtn setFrame:CGRectMake(0, (ElementHeight - 30) / 2, 90, 30)];
    [self.verifycodeBtn setBackgroundColor:[UIColor whiteColor]];
    [self.verifycodeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    [self.verifycodeBtn setTitleColor:MainColor forState:UIControlStateNormal];
    [self.verifycodeBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [self.verifycodeBtn addTarget:self action:@selector(messageVerifyCode:) forControlEvents:UIControlEventTouchUpInside];
    self.verifycodeBtn.layer.cornerRadius = self.verifycodeBtn.frame.size.height / 2;
    [verifyCodeRightView addSubview:self.verifycodeBtn];
    self.verifycodeBtn.layer.borderColor = MainColor.CGColor;
    self.verifycodeBtn.layer.borderWidth = 0.5f;
    self.verifyCodeTextField.rightView = verifyCodeRightView;
    self.verifyCodeTextField.rightViewMode = UITextFieldViewModeAlways;
    self.verifyCodeTextField.placeholder = @"验证码";
    [self.verifyCodeTextField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    self.verifyCodeTextField.backgroundColor = [UIColor whiteColor];
    self.verifyCodeTextField.layer.borderColor = MainColor.CGColor;
    self.verifyCodeTextField.layer.borderWidth = 0.5f;
    self.verifyCodeTextField.textColor = [UIColor blackColor];
    self.verifyCodeTextField.font = [UIFont systemFontOfSize:12];
    self.verifyCodeTextField.delegate = self;
    self.verifyCodeTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.scrollView addSubview:self.verifyCodeTextField];
    
    
    //密码
    self.passwordTextFiled = [[UITextField alloc]initWithFrame:CGRectMake(LeftSpace, self.verifyCodeTextField.frame.origin.y + self.verifyCodeTextField.frame.size.height+20, self.scrollView.frame.size.width - LeftSpace * 2, ElementHeight)];
    UIView *passwordLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, ElementHeight)];
    UIImageView *passwordLeftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, (ElementHeight - 20) / 2, 20, 20)];
    passwordLeftImageView.image = [UIImage imageNamed:@"password.png"];
    [passwordLeftView addSubview:passwordLeftImageView];
    self.passwordTextFiled.leftView = passwordLeftView;
    self.passwordTextFiled.leftViewMode = UITextFieldViewModeAlways;
    self.passwordTextFiled.placeholder = @"输入密码(6-16位数字、字母或组合)";
    [self.passwordTextFiled setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    self.passwordTextFiled.backgroundColor = [UIColor whiteColor];
    self.passwordTextFiled.layer.borderColor = MainColor.CGColor;
    self.passwordTextFiled.layer.borderWidth = 0.5f;
    self.passwordTextFiled.textColor = [UIColor blackColor];
    self.passwordTextFiled.font = [UIFont systemFontOfSize:12];
    [self.passwordTextFiled setSecureTextEntry:YES];
    self.passwordTextFiled.delegate = self;
    [self.scrollView addSubview:self.passwordTextFiled];
    
    //密码确认
    self.passwordReTextFiled = [[UITextField alloc]initWithFrame:CGRectMake(LeftSpace, self.passwordTextFiled.frame.origin.y + self.passwordTextFiled.frame.size.height, self.scrollView.frame.size.width - LeftSpace * 2, ElementHeight)];
    UIView *passwordReLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, ElementHeight)];
    UIImageView *passwordReLeftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, (ElementHeight - 20) / 2, 20, 20)];
    passwordReLeftImageView.image = [UIImage imageNamed:@"password.png"];
    [passwordReLeftView addSubview:passwordReLeftImageView];
    self.passwordReTextFiled.leftView = passwordReLeftView;
    self.passwordReTextFiled.leftViewMode = UITextFieldViewModeAlways;
    self.passwordReTextFiled.placeholder = @"再次填写密码";
    [self.passwordReTextFiled setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    self.passwordReTextFiled.backgroundColor = [UIColor whiteColor];
    self.passwordReTextFiled.layer.borderColor = MainColor.CGColor;
    self.passwordReTextFiled.layer.borderWidth = 0.5f;
    self.passwordReTextFiled.textColor = [UIColor blackColor];
    self.passwordReTextFiled.font = [UIFont systemFontOfSize:12];
    [self.passwordReTextFiled setSecureTextEntry:YES];
    self.passwordReTextFiled.delegate = self;
    [self.scrollView addSubview:self.passwordReTextFiled];
    
    //注册
    self.registeBtn = [[UIButton alloc]initWithFrame:CGRectMake(LeftSpace, self.passwordReTextFiled.frame.origin.y + self.passwordReTextFiled.frame.size.height + 20, self.scrollView.frame.size.width - LeftSpace * 2, 40)];
    [self.registeBtn setTitle:@"注册" forState:UIControlStateNormal];
    self.registeBtn.backgroundColor = MainColor;
    [self.registeBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [self.registeBtn addTarget:self action:@selector(registerUser) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.registeBtn];
    
    //同意按钮
    UILabel *agreeLabel = [[UILabel alloc] initWithFrame:CGRectMake(LeftSpace , self.registeBtn.frame.origin.y + self.registeBtn.frame.size.height + 10, 30, 30)];
    agreeLabel.text = @"注册即视为同意";
    agreeLabel.textColor = [UIColor grayColor];
    [agreeLabel setFont:[UIFont systemFontOfSize:12]];
    agreeLabel.backgroundColor = [UIColor clearColor];
    CGSize fittingSize = [agreeLabel sizeThatFits:CGSizeZero];
    CGRect frame = agreeLabel.frame;
    frame.size.width = fittingSize.width;
    agreeLabel.frame = frame;
    [self.scrollView addSubview:agreeLabel];
    
    //协议内容
    self.serviceTermButton = [[UIButton alloc]initWithFrame:CGRectMake(agreeLabel.frame.origin.x + agreeLabel.frame.size.width, self.registeBtn.frame.origin.y + self.registeBtn.frame.size.height + 10, 100, 30)];
    [self.serviceTermButton setTitle:@"《服务协议》" forState:UIControlStateNormal];
    self.serviceTermButton.backgroundColor = [UIColor clearColor];
    [self.serviceTermButton setTitleColor:MainColor forState:UIControlStateNormal];
    [self.serviceTermButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [self.serviceTermButton addTarget:self action:@selector(showServiceTerm) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.serviceTermButton];
    
    //设置scrolleView滑动范围
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH,self.serviceTermButton.frame.origin.y+self.serviceTermButton.frame.size.height+30);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [self sengVerfyCode];
}
-(void)sengVerfyCode{
    NSString *randomStr = [NSString stringWithFormat:@"%d",(int)(1000 + (arc4random() % (9999 - 1000)))];
    //发送验证码
    [PublicObject showHUDView:self.view title:@"验证码" content:randomStr time:kHUDTime andCodes:^{
        self.verifyCodeTextField.text = randomStr;
    }];
    
}
//隐藏键盘的方法
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.scrollView endEditing:YES];
}
#pragma mark - 注册信息
//http://localhost:8080/EducationPC/api.user.register.do?tel=18766108398&Password=123456
-(void)registerUser{
    NSString *password = self.passwordTextFiled.text;
    NSString *passwordRe = self.passwordReTextFiled.text;
    NSString *verifyCode = self.verifyCodeTextField.text;
    
    if (password.length==0) {
        [PublicObject showHUDView:self.view title:@"注意" content:@"密码不能为空" time:kHUDTime andCodes:^{
        }];
        return;
    }
    if (verifyCode.length==0) {
        [PublicObject showHUDView:self.view title:@"注意" content:@"验证码不能为空" time:kHUDTime andCodes:^{
        }];
        return;
    }
    //    if (![PublicObject validatePassword:password]) {
    //        //请输入格式正确的密码
    //        [PublicObject showHUDView:self.view title:@"提示" content:@"密码为6-16个数字、字母或组合" time:kHUDTime];
    //        self.passwordTextFiled.text = @"";
    //        [self performSelector:@selector(shownKeyboard:) withObject:self.passwordTextFiled  afterDelay:kHUDTime];
    //        return;
    //    }
    
    if (![passwordRe isEqualToString:password]) {
        [PublicObject showHUDView:self.view title:@"注意" content:@"两次密码输入不一致,请重新输入" time:kHUDTime andCodes:^{
        }];
        return;
    }
    //密码加密
    //    NSString *enPassword = [PublicObject encrypt:password];
    
    [DYRequestBase RegisteByTel:self.phoneStr Password:password requestStartBlock:^{
        [PublicObject showHUDBegain:self.view title:@"正在注册……"];
    } responseBlock:^(id dataObj, NSError *error) {
        [PublicObject dissMissHUDEnd];
        if(dataObj){
            NSLog(@"%@",dataObj);
            int status = [[dataObj objectForKey:@"status"] intValue];
            NSString *msg = [PublicObject convertNullString:[dataObj objectForKey:@"msg"]];
            if (status == 0) {
                [PublicObject showHUDView:self.view title:@"注册成功" content:@"" time:kHUDTime andCodes:^{
                    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];
                }];
            } else {
                [PublicObject showHUDView:self.view title:msg content:@"" time:kHUDTime andCodes:^{
                }];
            }
        }else{
            [PublicObject showHUDView:self.view title:@"请求失败" content:@"" time:kHUDTime andCodes:^{
            }];
        }
    }];
}
//获取短信验证码
- (void)messageVerifyCode:(id)sender {
    [self sengVerfyCode];
    
//    [DYRequestBase getVerifyCodeByTel:self.phoneStr requestStartBlock:^{
//        [PublicObject showHUDBegain:self.view title:@"正在发送……"];
//    } responseBlock:^(id dataObj, NSError *error) {
//        [PublicObject dissMissHUDEnd];
//        if(dataObj){
//            NSLog(@"%@",dataObj);
//            int status = [[dataObj objectForKey:@"status"] intValue];
//            NSString *msg = [PublicObject convertNullString:[dataObj objectForKey:@"msg"]];
//            if (status == 0) {
//                [PublicObject showHUDView:self.view title:@"注册成功" content:@"" time:kHUDTime andCodes:^{
//                    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];
//                }];
//            } else {
//                [PublicObject showHUDView:self.view title:msg content:@"" time:kHUDTime andCodes:^{
//                }];
//            }
//        }else{
//            [PublicObject showHUDView:self.view title:@"请求失败" content:@"" time:kHUDTime andCodes:^{
//            }];
//        }
//    }];
}
//计时器执行
- (void)updateTime {
    if (self.second <= 0) {
        [self.timer invalidate];
        self.timer = nil;
        [self.verifycodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.verifycodeBtn setUserInteractionEnabled:YES];
    } else {
        [self.verifycodeBtn setTitle:[NSString stringWithFormat:@"%ds",self.second] forState:UIControlStateNormal];
        [self.verifycodeBtn setBackgroundColor:MainColor];
        [self.verifycodeBtn setUserInteractionEnabled:NO];
    }
    self.second--;
}

#pragma mark - 查看注册协议
-(void)showServiceTerm{
    UserProtocolViewController *userProVC =[[UserProtocolViewController alloc] initWithNibName:@"UserProtocolViewController" bundle:nil];
    [self.navigationController pushViewController:userProVC animated:YES];
}

//显示键盘的方法
- (BOOL)shownKeyboard:(UITextField *)textFiled {
    [super becomeFirstResponder];
    return [textFiled becomeFirstResponder];
}
-(void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
