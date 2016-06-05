//
//  RegisterViewController.m
//  FootprintWall
//
//  Created by 张浩 on 15/4/16.
//  Copyright (c) 2015年 张浩. All rights reserved.
//

#import "RegisterViewController.h"
#import "ProvisionViewController.h"
@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"用户注册";
    self.navigationController.navigationBarHidden = NO;

    self.scrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.scrollView];
    self.isAgree = YES;
    //用户名
    self.userNameTextField = [[UITextField alloc]initWithFrame:CGRectMake(LeftSpace, 50+64, SCREEN_WIDTH - LeftSpace * 2, ElementHeight)];
    UIView *userNameLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, ElementHeight)];
    UIImageView *userNameLeftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, (ElementHeight - 26) / 2, 26, 26)];
    userNameLeftImageView.image = [UIImage imageNamed:@"card.png"];
    [userNameLeftView addSubview:userNameLeftImageView];
    self.userNameTextField.leftView = userNameLeftView;
    self.userNameTextField.leftViewMode = UITextFieldViewModeAlways;
    self.userNameTextField.placeholder = @"用户名";
    [self.userNameTextField setValue:PlaceholderColor forKeyPath:@"_placeholderLabel.textColor"];
    self.userNameTextField.backgroundColor = [UIColor whiteColor];
    self.userNameTextField.layer.borderColor = BackGroundColor.CGColor;
    self.userNameTextField.layer.borderWidth = 0.5f;
    self.userNameTextField.textColor = DominantColor;
    self.userNameTextField.font = [UIFont systemFontOfSize:18];
    self.userNameTextField.delegate = self;
    [self.scrollView addSubview:self.userNameTextField];
    
    //密码
    self.passwordTextField = [[UITextField alloc]initWithFrame:CGRectMake(LeftSpace, self.userNameTextField.frame.origin.y + self.userNameTextField.frame.size.height, SCREEN_WIDTH - LeftSpace * 2, ElementHeight)];
    UIView *passwordLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, ElementHeight)];
    UIImageView *passwordLeftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, (ElementHeight - 26) / 2, 26, 26)];
    passwordLeftImageView.image = [UIImage imageNamed:@"lock.png"];
    [passwordLeftView addSubview:passwordLeftImageView];
    self.passwordTextField.leftView = passwordLeftView;
    self.passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    self.passwordTextField.placeholder = @"密码：6-12位";
    [self.passwordTextField setValue:PlaceholderColor forKeyPath:@"_placeholderLabel.textColor"];
    self.passwordTextField.backgroundColor = [UIColor whiteColor];
    self.passwordTextField.layer.borderColor = BackGroundColor.CGColor;
    self.passwordTextField.layer.borderWidth = 0.5f;
    self.passwordTextField.textColor = DominantColor;
    self.passwordTextField.font = [UIFont systemFontOfSize:18];
    [self.passwordTextField setSecureTextEntry:YES];
    self.passwordTextField.delegate = self;
    [self.scrollView addSubview:self.passwordTextField];

    //真实姓名
    self.trueNameTextField = [[UITextField alloc]initWithFrame:CGRectMake(LeftSpace, self.passwordTextField.frame.origin.y + self.passwordTextField.frame.size.height, SCREEN_WIDTH - LeftSpace * 2, ElementHeight)];
    UIView *trueNameLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, ElementHeight)];
    UIImageView *trueNameLeftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, (ElementHeight - 26) / 2, 26, 26)];
    trueNameLeftImageView.image = [UIImage imageNamed:@"nickname.png"];
    [trueNameLeftView addSubview:trueNameLeftImageView];
    self.trueNameTextField.leftView = trueNameLeftView;
    self.trueNameTextField.leftViewMode = UITextFieldViewModeAlways;
    self.trueNameTextField.placeholder = @"昵称";
    [self.trueNameTextField setValue:PlaceholderColor forKeyPath:@"_placeholderLabel.textColor"];
    self.trueNameTextField.backgroundColor = [UIColor whiteColor];
    self.trueNameTextField.layer.borderColor = BackGroundColor.CGColor;
    self.trueNameTextField.layer.borderWidth = 0.5f;
    self.trueNameTextField.textColor = DominantColor;
    self.trueNameTextField.font = [UIFont systemFontOfSize:18];
    self.trueNameTextField.delegate = self;
    [self.scrollView addSubview:self.trueNameTextField];
    
    
    //同意按钮
    self.agreeButton = [[UIButton alloc]initWithFrame:CGRectMake(LeftSpace, self.trueNameTextField.frame.origin.y + self.trueNameTextField.frame.size.height + 15, 18, 18)];
    [self.agreeButton setImage:[UIImage imageNamed:@"yesImage.png"] forState:UIControlStateNormal];
    [self.agreeButton addTarget:self action:@selector(agreeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.agreeButton];
    
    UILabel *agreeLabel = [[UILabel alloc] initWithFrame:CGRectMake(LeftSpace + self.agreeButton.frame.size.width + 5, self.trueNameTextField.frame.origin.y + self.trueNameTextField.frame.size.height + 10, 30, 30)];
    agreeLabel.text = @"我已阅读并同意";
    agreeLabel.textColor = [UIColor whiteColor];
    [agreeLabel setFont:[UIFont systemFontOfSize:18]];
    agreeLabel.backgroundColor = [UIColor clearColor];
    CGSize fittingSize = [agreeLabel sizeThatFits:CGSizeZero];
    CGRect frame = agreeLabel.frame;
    frame.size.width = fittingSize.width;
    agreeLabel.frame = frame;
    [self.scrollView addSubview:agreeLabel];
    
    //协议内容
    self.serviceTermButton = [[UIButton alloc]initWithFrame:CGRectMake(agreeLabel.frame.origin.x + agreeLabel.frame.size.width, self.trueNameTextField.frame.origin.y + self.trueNameTextField.frame.size.height + 10, 150, 30)];
    [self.serviceTermButton setTitle:@"《服务协议》" forState:UIControlStateNormal];
    self.serviceTermButton.backgroundColor = [UIColor clearColor];
    [self.serviceTermButton setTitleColor:DominantColor forState:UIControlStateNormal];
    [self.serviceTermButton.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [self.serviceTermButton addTarget:self action:@selector(showServiceTerm:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.serviceTermButton];
    
    //注册
    self.registerBtn = [[UIButton alloc]initWithFrame:CGRectMake(LeftSpace, self.agreeButton.frame.origin.y + self.agreeButton.frame.size.height + 20, SCREEN_WIDTH - LeftSpace * 2, 40)];
    [self.registerBtn setTitle:@"注 册" forState:UIControlStateNormal];
    self.registerBtn.backgroundColor = DominantColor;
    [self.registerBtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [self.registerBtn addTarget:self action:@selector(registerUser:) forControlEvents:UIControlEventTouchUpInside];
    self.registerBtn.layer.cornerRadius = self.registerBtn.frame.size.height / 2;
    [self.scrollView addSubview:self.registerBtn];
    
    // handleSwipeFrom 是偵測到手势，所要呼叫的方法
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidenKeyboard)];
    gesture.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:gesture];
    
    self.scrollView.delegate = self;
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, self.registerBtn.frame.origin.y + self.registerBtn.frame.size.height + 20);}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//显示服务条款
- (IBAction)showServiceTerm:(id)sender {
    ProvisionViewController *provisionVC = [[ProvisionViewController alloc] initWithNibName:@"ProvisionViewController" bundle:nil];
    provisionVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:provisionVC animated:YES];
}
- (void)agreeButtonClick:(id)sender {
    if (self.isAgree) {
        self.isAgree = NO;
        [self.agreeButton setImage:[UIImage imageNamed:@"noImage.png"] forState:UIControlStateNormal];
    } else {
        self.isAgree = YES;
        [self.agreeButton setImage:[UIImage imageNamed:@"yesImage.png"] forState:UIControlStateNormal];
    }
}
//隐藏键盘的方法
- (void)hidenKeyboard {
    [self.userNameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.trueNameTextField resignFirstResponder];
}
//显示键盘的方法
- (BOOL)shownKeyboard:(UITextField *)textFiled {
    [super becomeFirstResponder];
    return [textFiled becomeFirstResponder];
}

//当用户按下return键或者按回车键，keyboard消失
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
//注册新用户
- (IBAction)registerUser:(id)sender {
    [self hidenKeyboard];
    NSString *userName = self.userNameTextField.text;
    userName = [userName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *trueName = self.trueNameTextField.text;
    trueName = [trueName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *password = self.passwordTextField.text;
    //对输入的用户信息进行非空检查
    if ([userName isEqualToString:@""]) {
        //请输入用户名
        [PublicObject showHUDView:self.view title:@"提示" content:@"请填写您的姓名" time:kHUDTime];
        [self performSelector:@selector(shownKeyboard:) withObject:self.userNameTextField  afterDelay:kHUDTime];
        return;
    }
    if ([trueName isEqualToString:@""]) {
        //请输入真实姓名
        [PublicObject showHUDView:self.view title:@"提示" content:@"请填写您的手机号" time:kHUDTime];
        [self performSelector:@selector(shownKeyboard:) withObject:self.trueNameTextField  afterDelay:kHUDTime];
        return;
    }
    if ([password isEqualToString:@""]) {
        //请输入密码
        [PublicObject showHUDView:self.view title:@"提示" content:@"请填写密码" time:kHUDTime];
        [self performSelector:@selector(shownKeyboard:) withObject:self.passwordTextField  afterDelay:kHUDTime];
        return;
    }
    if (![PublicObject validatePassword:password]) {
        //请输入格式正确的密码
        [PublicObject showHUDView:self.view title:@"提示" content:@"请填写6-12位密码" time:kHUDTime];
        self.passwordTextField.text = @"";
        [self performSelector:@selector(shownKeyboard:) withObject:self.passwordTextField  afterDelay:kHUDTime];
        return;
    }
    
    if (!self.isAgree) {
        [PublicObject showHUDView:self.view title:@"提示" content:@"请阅读并同意《服务协议》内容" time:kHUDTime];
    }
    //http://192.168.191.1:8080/FootMarkWall/jaxrs/userservice/register/{userName},{password},{trueName}
    NSString *parameters = [NSString stringWithFormat:@"%@,%@,%@",userName,password,trueName];
    [FtService GETmethod:kregister andParameters:parameters andHandle:^(NSDictionary *myresult) {
        NSDictionary *result = myresult;
        int status = [[result objectForKey:@"status"]intValue];
        switch (status) {
            case 0:{
                [PublicObject showHUDView:self.view title:@"注册失败，此用户名已被占用" content:@"" time:kHUDTime];
                NSLog(@"失败");
                break;
               
            }
            case 1:{
                [PublicObject showHUDView:self.view title:@"" content:@"注册成功" time:kHUDTime];
                NSLog(@"成功");
                [self performSelector:@selector(backFucntion:) withObject:nil afterDelay:kHUDTime];
                break;
            }
            default:
                NSLog(@"失败");
                break;
        }
    }];
}
-(IBAction)backFucntion:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
