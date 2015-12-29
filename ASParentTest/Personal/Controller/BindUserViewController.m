//
//  BindUserViewController.m
//  ASParentTest
//
//  Created by 张浩 on 15/11/25.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "BindUserViewController.h"
#import "MyIdentificationStudentTableViewCell.h"
@interface BindUserViewController ()

@end

@implementation BindUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"绑定用户";
    
    //
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.backgroundColor = BackGroundColor;

}

-(void)viewWillAppear:(BOOL)animated{
    
    NSDictionary *dic1 = [[NSDictionary alloc]initWithObjectsAndKeys:@"用户名1",@"name",@"13477776548",@"tel",@"本人",@"type", nil];
    NSDictionary *dic2 = [[NSDictionary alloc]initWithObjectsAndKeys:@"用户名2",@"name",@"13407564358",@"tel",@"",@"type", nil];
    NSDictionary *dic3 = [[NSDictionary alloc]initWithObjectsAndKeys:@"用户名3",@"name",@"15169035751",@"tel",@"",@"type", nil];
    
    self.dataArr = [[NSMutableArray alloc]initWithObjects:dic1,dic2,dic3, nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //1.加载xib
    static NSString *CellIdentifier = @"MyIdentificationStudentTableViewCell";
    MyIdentificationStudentTableViewCell *cell = (MyIdentificationStudentTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        NSBundle *bundle = [NSBundle mainBundle];
        NSArray *nibArray = [bundle loadNibNamed:CellIdentifier owner:self options:nil];
        cell = (MyIdentificationStudentTableViewCell *)[nibArray objectAtIndex:0];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    NSDictionary *dic = [self.dataArr objectAtIndex:indexPath.row];
    cell.titleLab.text = [dic objectForKey:@"name"];
    cell.infoLab.text = [dic objectForKey:@"tel"];
    cell.typeLab.text = [dic objectForKey:@"type"];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
@end
