//
//  AtdWallViewController.m
//  Footprint
//
//  Created by 周德艺 on 15/6/10.
//  Copyright (c) 2015年 周德艺. All rights reserved.
//

#import "AtdWallViewController.h"
#import "AMTagListView.h"
#import "MZTimerLabel.h"
#import <AdSupport/AdSupport.h>

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface AtdWallViewController ()

@end

@implementation AtdWallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"签到墙"];
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    [rightBtn setTitle:@"签到" forState:UIControlStateNormal];
    [rightBtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [rightBtn addTarget:self action:@selector(getHere:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    self.timer = [[MZTimerLabel alloc] initWithLabel:_label andTimerType:MZTimerLabelTypeTimer];
    
    [[AMTagView appearance] setTagLength:10];
    [[AMTagView appearance] setTextPadding:14];
    [[AMTagView appearance] setTextFont:[UIFont systemFontOfSize:14]];
    [[AMTagView appearance] setTagColor:UIColorFromRGB(0x1f8dd6)];
    
    [self.view addSubview:self.tagListView];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [self getArrayByAtdWallid];
}

-(void)reloadTime{
    if (self.atdWall.atdwallstatus == 0) {
        self.navigationItem.rightBarButtonItem = nil;
        _label.text = @"已结束";
    }else{
        //显示倒计时
        NSDate *date=[NSDate date];
        NSTimeInterval interval = [date timeIntervalSince1970];
        NSInteger nowTime = interval;
        [self.timer setCountDownTime:(self.atdWall.atdwallcreattime.longLongValue/1000+3600-nowTime)];
        [self.timer start];
    }
    
}

-(void)getArrayByAtdWallid{
    [FtService GETmethod:KFindAllAtdByAtdWallid andParameters:self.atdWall.atdwallid andHandle:^(NSDictionary *myresult) {
        NSDictionary *result = myresult;
        int status = [[result objectForKey:@"status"]intValue];
        if (status == 1) {
            [self.tagListView reloadInputViews];
            self.atdArray = [[NSMutableArray alloc]init];
            NSArray *dic = [result objectForKey:@"result"];
            NSArray *atds = [AtdObject objectArrayWithKeyValuesArray:dic];
            self.atdArray = [[NSMutableArray alloc]initWithArray:atds];
            for (AtdObject *atd in self.atdArray) {
                [self.tagListView addTag:atd.atdinfo];
            }            
        }
        else{
            NSLog(@"失败");
        }
        [self reloadTime];
        
    }];
}


// Close the keyboard when the user taps away froma  textfield
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UIView* view in self.view.subviews) {
        if ([view isKindOfClass:[UITextField class]])
            [view resignFirstResponder];
    }
}

- (IBAction)getHere:(id)sender {
    NSString *title = NSLocalizedString(@"签到", nil);
    NSString *message = NSLocalizedString(@"输入一个签到姓名\n每人每墙只可签到一次", nil);
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    // Add the text field for the secure text entry.
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        
    }];
    
    // Create the actions.
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    }];
    
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"签到" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"bbbbbbbb%@",((UILabel*)alertController.textFields.firstObject).text);
        NSString *adId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
        NSString *parm = [NSString stringWithFormat:@"%@,%@,%@,%@",self.user.username,self.atdWall.atdwallid,((UILabel*)alertController.textFields.firstObject).text,adId];
        [FtService GETmethod:KAtd andParameters:parm andHandle:^(NSDictionary *myresult) {
            NSDictionary *result = myresult;
            int status = [[result objectForKey:@"status"]intValue];
            if (status == 1) {
                [self getArrayByAtdWallid];
                [PublicObject showHUDView:self.view title:@"签到成功" content:@"" time:kHUDTime];
            }
            else{
                NSLog(@"失败");
                [PublicObject showHUDView:self.view title:@"该设备已签到" content:@"" time:kHUDTime];

            }
            [self reloadTime];
            
        }];
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
