//
//  RegistOneViewController.m
//  ASParentTest
//
//  Created by 张浩 on 15/11/19.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "RegistOneViewController.h"
#import "RegistTwoViewController.h"
#import "LoginViewController.h"
//接口
#import "DYRequestBase+CheckUserTelRequest.h"
@interface RegistOneViewController ()

@end

@implementation RegistOneViewController

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
    
    //提示信息
    self.infoLab = [[UILabel alloc]initWithFrame:CGRectMake(LeftSpace, 50, SCREEN_WIDTH-LeftSpace * 2, ElementHeight)];
    self.infoLab.textColor = [UIColor lightGrayColor];
    self.infoLab.font = [UIFont systemFontOfSize:12];
    self.infoLab.text = @"我们将把手机验证码发至您填写的手机号上";
    [self.scrollView addSubview:self.infoLab];
    
    //手机号
    self.phoneTextField = [[UITextField alloc]initWithFrame:CGRectMake(LeftSpace, self.infoLab.frame.origin.y + self.infoLab.frame.size.height+20, SCREEN_WIDTH - LeftSpace * 2, ElementHeight)];
    UIView *phoneLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, ElementHeight)];
    UIImageView *phoneLeftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, (ElementHeight - 20) / 2, 20, 20)];
    phoneLeftImageView.image = [UIImage imageNamed:@"phone.png"];
    [phoneLeftView addSubview:phoneLeftImageView];
    self.phoneTextField.leftView = phoneLeftView;
    self.phoneTextField.leftViewMode = UITextFieldViewModeAlways;
    self.phoneTextField.placeholder = @"输入要注册的手机号码";
    [self.phoneTextField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    self.phoneTextField.backgroundColor = [UIColor whiteColor];
    self.phoneTextField.layer.borderColor = MainColor.CGColor;
    self.phoneTextField.layer.borderWidth = 0.5f;
    self.phoneTextField.textColor = [UIColor blackColor];
    self.phoneTextField.font = [UIFont systemFontOfSize:12];
    self.phoneTextField.delegate = self;
    self.phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.scrollView addSubview:self.phoneTextField];
    
    //下一步
    self.nextStepBtn = [[UIButton alloc]initWithFrame:CGRectMake(LeftSpace, self.phoneTextField.frame.origin.y + self.phoneTextField.frame.size.height + 20, SCREEN_WIDTH - LeftSpace * 2, 40)];
    [self.nextStepBtn setTitle:@"下一步" forState:UIControlStateNormal];
    self.nextStepBtn.backgroundColor = MainColor;
    [self.nextStepBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [self.nextStepBtn addTarget:self action:@selector(nextStepClick) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.nextStepBtn];
    
    //已经注册?直接登录
    self.loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(LeftSpace+self.nextStepBtn.frame.size.width-60, self.nextStepBtn.frame.origin.y + self.nextStepBtn.frame.size.height + 10, 60, 30)];
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    self.loginBtn.backgroundColor = [UIColor clearColor];
    [self.loginBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [self.loginBtn setTitleColor:MainColor forState:UIControlStateNormal];
    [self.loginBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    self.loginBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    self.loginBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.scrollView addSubview:self.loginBtn];
    
    //lab
    self.loginLab = [[UILabel alloc]initWithFrame:CGRectMake(self.loginBtn.frame.origin.x-80, self.loginBtn.frame.origin.y, 80, 30)];
    self.loginLab.textAlignment = UITextAlignmentRight;
    self.loginLab.textColor = MainColor;
    self.loginLab.font = [UIFont systemFontOfSize:12];
    self.loginLab.text = @"已经注册?";
    [self.scrollView addSubview:self.loginLab];
    
    //设置scrolleView滑动范围
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH,self.nextStepBtn.frame.origin.y+self.nextStepBtn.frame.size.height+30);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//隐藏键盘的方法
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.scrollView endEditing:YES];
}
//http://localhost:8080/EducationPC/api.user.checkStuIsExist.do?tel=18766108398
- (void)nextStepClick {
    NSLog(@"login");
    {
        if (self.phoneTextField.text.length == 0) {
            [PublicObject showHUDView:self.view title:@"注意" content:@"手机号不能为空" time:kHUDTime andCodes:^{
            }];
            return;
        }
    }
    NSString *phoneNumber=self.phoneTextField.text;
    
    NSMutableDictionary *parametersDic = [[NSMutableDictionary alloc]init];
    [parametersDic setValue:phoneNumber forKey:@"tel"];
    
    [DYRequestBase cheackUserTelByTel:phoneNumber requestStartBlock:^{
        [PublicObject showHUDBegain:self.view title:@"正在验证……"];
    } responseBlock:^(id dataObj, NSError *error) {
        [PublicObject dissMissHUDEnd];
        if (dataObj) {
            int status = [[dataObj objectForKey:@"status"] intValue];
            NSString *msg = [PublicObject convertNullString:[dataObj objectForKey:@"msg"]];
            if (status == 0) {
                RegistTwoViewController *nextStepVC = [[RegistTwoViewController alloc]initWithNibName:@"RegistTwoViewController" bundle:nil];
                nextStepVC.phoneStr = phoneNumber;
                [self.navigationController pushViewController:nextStepVC animated:YES];
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
-(void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
