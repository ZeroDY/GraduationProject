//
//  QzbsViewController.m
//  ASParentTest
//
//  Created by 张浩 on 15/11/20.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "QzbsViewController.h"
#import "QzbsLeftTableViewCell.h"
#import "QzbsRightTableViewCell.h"
#import "QzbsTableViewCell.h"
@interface QzbsViewController ()

@end

@implementation QzbsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"七嘴八舌";
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.backgroundColor = BackGroundColor;
}
-(void)viewWillAppear:(BOOL)animated{
    self.dataArr = [[NSMutableArray alloc]initWithObjects:@"一寸光阴一寸金，寸金难买寸光阴",@"志不强者智不达，言不信者行不果智不达，言不信者行不果",@"城市是人生的命脉，是一切价值的根基",@"欺人只能一时，而诚实却是长久之策",@"人总是要犯错误、受挫折、伤脑筋的，不过决不能停滞不前；应该完成的任务，即使为它牺牲生命，也要完成。社会之河的圣水就是因为被一股永不停滞的激流推动向前才得以保持洁净。这意味着河岸偶尔也会被冲垮，短时间造成损失，可是如果怕河堤溃决，便设法永远堵死这股激流，那只会招致停滞和死亡。", nil];
    
    //假数据
    NSDictionary *qzbs1 = @{@"titleImg":@"xxxx",@"title":@"一寸光阴一寸金，寸金难买寸光阴",@"time":@"2015-10-12"};
    NSDictionary *qzbs2 = @{@"titleImg":@"xxxx",@"title":@"欺人只能一时，而诚实却是长久之策",@"time":@"xxxxxxxxx"};
    NSDictionary *qzbs3 = @{@"titleImg":@"xxxx",@"title":@"城市是人生的命脉，是一切价值的根基",@"time":@"xxxxxxxxx"};
    NSDictionary *qzbs4 = @{@"titleImg":@"xxxx",@"title":@"人总是要犯错误、受挫折、伤脑筋的，不过决不能停滞不前；应该完成的任务，即使为它牺牲生命，也要完成。社会之河的圣水就是因为被一股永不停滞的激流推动向前才得以保持洁净。这意味着河岸偶尔也会被冲垮，短时间造成损失，可是如果怕河堤溃决，便设法永远堵死这股激流，那只会招致停滞和死亡。",@"time":@"xxxxxxxxx"};
    NSDictionary *qzbs5 = @{@"titleImg":@"xxxx",@"title":@"志不强者智不达，言不信者行不果智不达，言不信者行不果",@"time":@"xxxxxxxxx"};
    self.qzbsTempArr = [[NSMutableArray alloc]initWithObjects:qzbs1,qzbs2,qzbs3,qzbs4,qzbs5, nil];
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
    static NSString *CellIdentifier = @"QzbsTableViewCell";
    
    QzbsTableViewCell *cell = (QzbsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        NSBundle *bundle = [NSBundle mainBundle];
        NSArray *nibArray = [bundle loadNibNamed:CellIdentifier owner:self options:nil];
        cell = (QzbsTableViewCell *)[nibArray objectAtIndex:0];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    //        cell.titleImg.image = [UIImage imageNamed:@""];
    
    NSDictionary *dic = [self.qzbsTempArr objectAtIndex:indexPath.row];
    cell.contentLab.text = [dic objectForKey:@"title"];
    cell.timeLab.text = [dic objectForKey:@"time"];
    //
    cell.contentBackView.layer.cornerRadius = cell.contentLab.frame.size.height/5;
    cell.contentBackView.layer.masksToBounds = YES;
    cell.contentLab.layer.cornerRadius = cell.contentLab.frame.size.height/5;
    cell.contentLab.layer.masksToBounds = YES;
    
    cell.contentLab.textColor = [UIColor darkGrayColor];
    cell.contentBackView.backgroundColor = BackGroundColor;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = [self.qzbsTempArr objectAtIndex:indexPath.row];
    int heigh = [QzbsTableViewCell calculateCellHeightWithContentStr:[dic objectForKey:@"title"]];
    NSLog(@"%d",heigh);
    return heigh;
}
- (IBAction)publishClick:(id)sender {
}
@end
