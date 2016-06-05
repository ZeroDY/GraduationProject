//
//  ChangeUseInfoViewController.m
//  Footprint
//
//  Created by 张浩 on 15/5/26.
//  Copyright (c) 2015年 周德艺. All rights reserved.
//

#import "ChangeUseInfoViewController.h"

@interface ChangeUseInfoViewController ()

@end

@implementation ChangeUseInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.titleStr;
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    if (self.isSex) {
        self.backView.hidden = YES;
        self.tableView.hidden = NO;
    }
    else{
        self.backView.hidden = NO;
        self.tableView.hidden = YES;
        // handleSwipeFrom 是偵測到手势，所要呼叫的方法
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidenKeyboard)];
        gesture.numberOfTapsRequired = 1;
        
        [self.view addGestureRecognizer:gesture];
    }
    self.infoField.text = self.infoStr;
    self.sexArr = [[NSArray alloc]initWithObjects:@"男",@"女", nil];
    if ([self.infoStr isEqualToString:@"男"]) {
        self.index = 0;
    }
    if ([self.infoStr isEqualToString:@"女"]) {
        self.index = 1;
    }else{
        self.index = 0;
    }
    //添加导航栏按钮
    UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cancelBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [cancelBtn addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:cancelBtn];
    
    UIButton *saveBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [saveBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    saveBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [saveBtn addTarget:self action:@selector(saveClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:saveBtn];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 获取数据 - 修改用户信息
-(void)changeTrueName:(NSString *) userName andNewInfo:(NSString *)newTrueName{
    NSString *parameters = [NSString stringWithFormat:@"%@,%@",userName,newTrueName];
    [FtService GETmethod:kUpdatetruename andParameters:parameters andHandle:^(NSDictionary *myresult) {
        NSDictionary *result = myresult;
        int status = [[result objectForKey:@"status"]intValue];
        if (status == 1) {
            [PublicObject showHUDView:self.view title:@"提示" content:@"修改成功" time:kHUDTime];
            [self performSelector:@selector(backFucntion:) withObject:nil afterDelay:kHUDTime];
        }
        else{
            NSLog(@"失败");
            [PublicObject showHUDView:self.view title:@"提示" content:@"修改失败" time:kHUDTime];
        }
    }];
}
-(void)changeSex:(NSString *) userName andNewInfo:(NSString *)newSex{
    NSString *parameters = [NSString stringWithFormat:@"%@,%@",userName,newSex];
    [FtService GETmethod:kUpdatesex andParameters:parameters andHandle:^(NSDictionary *myresult) {
        NSDictionary *result = myresult;
        int status = [[result objectForKey:@"status"]intValue];
        if (status == 1) {
            [PublicObject showHUDView:self.view title:@"提示" content:@"修改成功" time:kHUDTime];
            [self performSelector:@selector(backFucntion:) withObject:nil afterDelay:kHUDTime];
        }
        else{
            NSLog(@"失败");
            [PublicObject showHUDView:self.view title:@"提示" content:@"修改失败" time:kHUDTime];
        }
    }];
}
-(void)changeAge:(NSString *) userName andNewInfo:(NSString *)newAge{
    NSString *parameters = [NSString stringWithFormat:@"%@,%@",userName,newAge];
    [FtService GETmethod:kUpdateage andParameters:parameters andHandle:^(NSDictionary *myresult) {
        NSDictionary *result = myresult;
        int status = [[result objectForKey:@"status"]intValue];
        if (status == 1) {
            [PublicObject showHUDView:self.view title:@"提示" content:@"修改成功" time:kHUDTime];
            [self performSelector:@selector(backFucntion:) withObject:nil afterDelay:kHUDTime];
        }
        else{
            NSLog(@"失败");
            [PublicObject showHUDView:self.view title:@"提示" content:@"修改失败" time:kHUDTime];
        }
    }];
}

-(void)changeTel:(NSString *) userName andNewInfo:(NSString *)newTel{
    NSString *parameters = [NSString stringWithFormat:@"%@,%@",userName,newTel];
    [FtService GETmethod:kUpdatetel andParameters:parameters andHandle:^(NSDictionary *myresult) {
        NSDictionary *result = myresult;
        int status = [[result objectForKey:@"status"]intValue];
        if (status == 1) {
            [PublicObject showHUDView:self.view title:@"提示" content:@"修改成功" time:kHUDTime];
            [self performSelector:@selector(backFucntion:) withObject:nil afterDelay:kHUDTime];
        }
        else{
            NSLog(@"失败");
            [PublicObject showHUDView:self.view title:@"提示" content:@"修改失败" time:kHUDTime];
        }
    }];
}
-(IBAction)backFucntion:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];    
}
//隐藏键盘的方法
- (void)hidenKeyboard {
    [self.infoField resignFirstResponder];
}


- (IBAction)cancelClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)saveClick:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *userDic = [defaults objectForKey:USERINFO];
    self.user = [UserObject objectWithKeyValues:userDic];
    if (self.isTrueName) {
        [self changeTrueName:self.user.username andNewInfo:self.infoField.text];
    }
    if (self.isSex) {
        [self changeSex:self.user.username andNewInfo:[self.sexArr objectAtIndex:_index]];
    }
    if (self.isAge) {
        [self changeAge:self.user.username andNewInfo:self.infoField.text];
    }
    if (self.isTel) {
        [self changeTel:self.user.username andNewInfo:self.infoField.text];
    }
    
}
//#pragma mark - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.sexArr count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellid = @"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSInteger myrow = [indexPath row];
    cell.textLabel.text = [self.sexArr objectAtIndex:myrow];
    
    // 重用机制，如果选中的行正好要重用
    if (_index == indexPath.row) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"qqqqq");
    // 取消前一个选中的，就是单选啦
    NSIndexPath *lastIndex = [NSIndexPath indexPathForRow:_index inSection:0];
    UITableViewCell *lastCell = [tableView cellForRowAtIndexPath:lastIndex];
    lastCell.accessoryType = UITableViewCellAccessoryNone;
    
    // 选中操作
    UITableViewCell *cell = [tableView  cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    // 保存选中的
    _index = indexPath.row;
    [_tableView performSelector:@selector(deselectRowAtIndexPath:animated:) withObject:indexPath afterDelay:.5];
}
@end
