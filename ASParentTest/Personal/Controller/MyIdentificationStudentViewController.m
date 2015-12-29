//
//  MyIdentificationStudentViewController.m
//  ASParentTest
//
//  Created by 张浩 on 15/11/25.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "MyIdentificationStudentViewController.h"
#import "MyIdentificationStudentTableViewCell.h"
@interface MyIdentificationStudentViewController ()

@end

@implementation MyIdentificationStudentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"认证学生";
    //导航栏右侧添加按钮
    UIButton* rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,30,30)];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"add_white.png"] forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize: 14];
    [rightButton addTarget:self action:@selector(presentRightVC) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem= rightItem;
    
    //
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.backgroundColor = BackGroundColor;
}
-(void)viewWillAppear:(BOOL)animated{

    NSDictionary *dic1 = [[NSDictionary alloc]initWithObjectsAndKeys:@"王梦琪",@"name",@"济南中学",@"school",@"本人",@"type", nil];
    NSDictionary *dic2 = [[NSDictionary alloc]initWithObjectsAndKeys:@"王大",@"name",@"槐荫中学",@"school",@"",@"type", nil];
    NSDictionary *dic3 = [[NSDictionary alloc]initWithObjectsAndKeys:@"李晓红",@"name",@"济南中学",@"school",@"",@"type", nil];

    self.dataArr = [[NSMutableArray alloc]initWithObjects:dic1,dic2,dic3, nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)presentRightVC{

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
    cell.infoLab.text = [dic objectForKey:@"school"];
    cell.typeLab.text = [dic objectForKey:@"type"];

    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
@end
