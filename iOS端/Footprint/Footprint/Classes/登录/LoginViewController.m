//
//  LoginViewController.m
//  FootprintWall
//
//  Created by 张浩 on 15/4/15.
//  Copyright (c) 2015年 张浩. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "NearViewController.h"
#import "MMDrawerController.h"
#import "MMNavigationController.h"
#import "MenuViewController.h"
#import "MMExampleDrawerVisualStateManager.h"

@interface LoginViewController ()
@property (nonatomic,strong) MMDrawerController * drawerController;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"用户登录";
    self.navigationController.navigationBarHidden = YES;

    //设置导航按钮
    
    self.scrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.scrollView];
    
    //用户名
    self.usernameTextField = [[UITextField alloc]initWithFrame:CGRectMake(LeftSpace, 90, SCREEN_WIDTH - LeftSpace * 2, ElementHeight)];
    UIView *usernameLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, ElementHeight)];
    UIImageView *usernameLeftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, (ElementHeight - 26) / 2, 26, 26)];
    usernameLeftImageView.image = [UIImage imageNamed:@"nickname.png"];
    [usernameLeftView addSubview:usernameLeftImageView];
    self.usernameTextField.leftView = usernameLeftView;
    self.usernameTextField.leftViewMode = UITextFieldViewModeAlways;
    self.usernameTextField.placeholder = @"用户名";
    [self.usernameTextField setValue:PlaceholderColor forKeyPath:@"_placeholderLabel.textColor"];
    self.usernameTextField.backgroundColor = [UIColor whiteColor];
    self.usernameTextField.layer.borderColor = BackGroundColor.CGColor;
    self.usernameTextField.layer.borderWidth = 0.5f;
    self.usernameTextField.textColor = DominantColor;
    self.usernameTextField.font = [UIFont systemFontOfSize:18];
    self.usernameTextField.delegate = self;
    [self.scrollView addSubview:self.usernameTextField];
    //密码
    self.passwordTextField = [[UITextField alloc]initWithFrame:CGRectMake(LeftSpace, self.usernameTextField.frame.origin.y + self.usernameTextField.frame.size.height, SCREEN_WIDTH - LeftSpace * 2, ElementHeight)];
    UIView *passWordLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, ElementHeight)];
    UIImageView *passWordLeftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, (ElementHeight - 26) / 2, 26, 26)];
    passWordLeftImageView.image = [UIImage imageNamed:@"lock.png"];
    [passWordLeftView addSubview:passWordLeftImageView];
    self.passwordTextField.leftView = passWordLeftView;
    self.passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    self.passwordTextField.placeholder = @"输入密码";
    [self.passwordTextField setValue:PlaceholderColor forKeyPath:@"_placeholderLabel.textColor"];
    self.passwordTextField.backgroundColor = [UIColor whiteColor];
    self.passwordTextField.layer.borderColor = BackGroundColor.CGColor;
    self.passwordTextField.layer.borderWidth = 0.5f;
    self.passwordTextField.textColor = DominantColor;
    [self.passwordTextField setSecureTextEntry:YES];
    self.passwordTextField.font = [UIFont systemFontOfSize:18];
    self.passwordTextField.delegate = self;
    [self.scrollView addSubview:self.passwordTextField];
    //登录
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loginBtn.frame = CGRectMake(LeftSpace, self.passwordTextField.frame.origin.y + self.passwordTextField.frame.size.height + 20, SCREEN_WIDTH - LeftSpace * 2, 40);
    [self.loginBtn setTitle:@"登 录" forState:UIControlStateNormal];
    self.loginBtn.backgroundColor = DominantColor;
    [self.loginBtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [self.loginBtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    //self.loginBtn.layer.cornerRadius = self.loginBtn.frame.size.height / 2;
    [self.scrollView addSubview:self.loginBtn];
    //注册
    self.registerBtn = [[UIButton alloc]initWithFrame:CGRectMake(LeftSpace, self.loginBtn.frame.origin.y + self.loginBtn.frame.size.height + 10, 40, 30)];
    [self.registerBtn setTitle:@"注 册" forState:UIControlStateNormal];
    self.registerBtn.backgroundColor = [UIColor clearColor];
    [self.registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.registerBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.registerBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [self.registerBtn addTarget:self action:@selector(registerClick) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.registerBtn];
    //忘记密码
    self.forgetPwBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - LeftSpace - 70, self.loginBtn.frame.origin.y + self.loginBtn.frame.size.height + 10, 70, 30)];
    [self.forgetPwBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    self.forgetPwBtn.backgroundColor = [UIColor clearColor];
    [self.forgetPwBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.forgetPwBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    self.forgetPwBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.forgetPwBtn addTarget:self action:@selector(forgetKeyClick) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.forgetPwBtn];
    // handleSwipeFrom 是偵測到手势，所要呼叫的方法
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidenKeyboard)];
    gesture.numberOfTapsRequired = 1;
    
    [self.view addGestureRecognizer:gesture];
    
    self.hideView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.hideView setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.5]];
    [self.hideView setHidden:YES];
    [self.view addSubview:self.hideView];
    
}


-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
    [[RefreshLocation shareInstance]RefreshLocationLable:nil andBlock:^{    }];
}

//显示键盘的方法
- (BOOL)shownKeyboard:(UITextField *)textFiled {
    [super becomeFirstResponder];
    return [textFiled becomeFirstResponder];
}
//隐藏键盘的方法
- (void)hidenKeyboard {
    [self.usernameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}
//登录
- (void)login:(id)sender {
    [self hidenKeyboard];
    NSString *username = self.usernameTextField.text;
    NSString *password = self.passwordTextField.text;
    //    NSString *md5Password = [PublicObject md5:password];
    NSLog(@"%@,%@",username,password);
    if ([username isEqualToString:@""]) {
        //请输入用户名
        [PublicObject showHUDView:self.view title:@"提示" content:@"请填写用户名" time:kHUDTime];
        [self performSelector:@selector(shownKeyboard:) withObject:self.usernameTextField afterDelay:kHUDTime];
        return;
    }
    if ([password isEqualToString:@""]) {
        //请输入密码
        [PublicObject showHUDView:self.view title:@"提示" content:@"请填写密码" time:kHUDTime];
        [self performSelector:@selector(shownKeyboard:) withObject:self.passwordTextField afterDelay:kHUDTime];
        return;
    }
        if (![PublicObject validatePassword:password]) {
        //请输入格式正确的密码
        [PublicObject showHUDView:self.view title:@"提示" content:@"密码错误，请重新填写" time:kHUDTime];
        self.passwordTextField.text = @"";
        [self performSelector:@selector(shownKeyboard:) withObject:self.passwordTextField afterDelay:kHUDTime];
        return;
    }
    
    //http://192.168.191.1:8080/FootMarkWall/jaxrs/userservice/login/{userName},{password}
    NSString *parameters = [NSString stringWithFormat:@"%@,%@",username,password];
    [GMDCircleLoader setOnView:self.hideView withTitle:@"Loading..." animated:YES];
    [self.hideView setHidden:NO];
    [FtService GETmethod:klogin andParameters:parameters andHandle:^(NSDictionary *myresult) {
        [self.hideView setHidden:YES];
        [GMDCircleLoader hideFromView:self.hideView animated:YES];
        NSDictionary *result = myresult;
        int status = [[result objectForKey:@"status"]intValue];
        if (status == 1) {
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSDictionary *temp = [[NSDictionary alloc]initWithDictionary:result[@"result"]];
            self.user = [UserObject objectWithKeyValues:temp];
            NSDictionary *userInfo = self.user.keyValues;
            [defaults setObject:userInfo forKey:USERINFO];
            [defaults synchronize];
            
            NearViewController *nearViewController = [[NearViewController alloc] initWithNibName:@"NearViewController" bundle:nil];
            nearViewController.user = self.user;
            UINavigationController * navigationController = [[MMNavigationController alloc] initWithRootViewController:nearViewController];
            
            MenuViewController * leftViewController = [[MenuViewController alloc] init];
            [leftViewController addTableHeader];
            UINavigationController * leftSideNavController = [[MMNavigationController alloc] initWithRootViewController:leftViewController];
            
            self.drawerController = [[MMDrawerController alloc]
                                     initWithCenterViewController:navigationController
                                     leftDrawerViewController:leftSideNavController
                                     rightDrawerViewController:nil];
            [self.drawerController setShowsShadow:NO];
            
            [self.drawerController setMaximumRightDrawerWidth:200.0];
            [self.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
            [self.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
            
            [self.drawerController
             setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
                 MMDrawerControllerDrawerVisualStateBlock block;
                 block = [[MMExampleDrawerVisualStateManager sharedManager]
                          drawerVisualStateBlockForDrawerSide:drawerSide];
                 if(block){
                     block(drawerController, drawerSide, percentVisible);
                 }
             }];
            [self presentViewController:self.drawerController animated:YES completion:^{
            }];
        }
        else{
                NSLog(@"失败");
        }
    }];
    
}

//注册
- (void)registerClick {
        RegisterViewController *registerVC = [[RegisterViewController alloc]initWithNibName:@"RegisterViewController" bundle:nil];
        [self.navigationController pushViewController:registerVC animated:YES];
        
}

//忘记密码
- (void)forgetKeyClick {
    //    ForgetPwViewController *forgetPwdVC = [[ForgetPwViewController alloc] init];
    //    [self.navigationController pushViewController:forgetPwdVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
