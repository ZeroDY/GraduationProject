//
//  LeaveDeatilShowViewController.m
//  ASParentTest
//
//  Created by 张浩 on 15/11/29.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "LeaveDeatilShowViewController.h"

@interface LeaveDeatilShowViewController ()

@end

@implementation LeaveDeatilShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"请假详情";
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.tableFooterView = [[UIView alloc]init];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //2.手写
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell.textLabel setTextColor:[UIColor darkGrayColor]];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
    }
    if (indexPath.row == 0) {
        if ([self.leaveObj.leavestyle isEqualToString:@"0"]) {
            cell.textLabel.text = [NSString stringWithFormat:@"请假类型:病假"];
        }else{
            cell.textLabel.text = [NSString stringWithFormat:@"请假类型:事假"];
        }
    }else if (indexPath.row == 1){
        cell.textLabel.text = [NSString stringWithFormat:@"开始时间:%@",self.leaveObj.firsttime];
    }else if (indexPath.row == 2){
        cell.textLabel.text = [NSString stringWithFormat:@"结束时间:%@",self.leaveObj.lasttime];
    }else if (indexPath.row == 3){
        cell.textLabel.text = [NSString stringWithFormat:@"请假理由:%@",self.leaveObj.subjectline];
    }else{
        NSString *status = [NSString stringWithFormat:@"%@",self.leaveObj.ltype];
        if ([status isEqualToString:@"0"]) {
            cell.textLabel.text = [NSString stringWithFormat:@"审核状态:允许"];
        }else if ([status isEqualToString:@"1"]){
            cell.textLabel.text = [NSString stringWithFormat:@"审核状态:拒绝"];
        }else{
            cell.textLabel.text = [NSString stringWithFormat:@"审核状态:未审核"];
        }
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
@end
