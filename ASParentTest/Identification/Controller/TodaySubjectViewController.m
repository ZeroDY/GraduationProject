//
//  TodaySubjectViewController.m
//  ASParentTest
//
//  Created by 张浩 on 15/11/21.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "TodaySubjectViewController.h"
#import "TodaySubjectTableViewCell.h"
@interface TodaySubjectViewController ()

@end

@implementation TodaySubjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"今日课程";
    self.tableView.tableFooterView = [[UIView alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    
    self.dataArr = [[NSMutableArray alloc]init];
    
    NSDictionary *tempDic1 = [[NSDictionary alloc]initWithObjectsAndKeys:@"",@"image",@"大雁归来",@"title",@"世界上的一队小小的漂泊者呀，请留下你们的足印在我的文字里。",@"info", nil];
    NSDictionary *tempDic2 = [[NSDictionary alloc]initWithObjectsAndKeys:@"",@"image",@"云没有奔跑",@"title",@"是大地的泪点，使她的微笑保持着青春不谢。",@"info", nil];
    NSDictionary *tempDic3 = [[NSDictionary alloc]initWithObjectsAndKeys:@"",@"image",@"非我",@"title",@"无垠的沙漠热烈追求一叶绿草的爱，她摇摇头笑着飞开了。",@"info", nil];
    NSDictionary *tempDic4 = [[NSDictionary alloc]initWithObjectsAndKeys:@"",@"image",@"刻意",@"title",@"如果你因失去了太阳而流泪，那么你也将失去群星了。",@"info", nil];
    NSDictionary *tempDic5 = [[NSDictionary alloc]initWithObjectsAndKeys:@"",@"image",@"单月的风",@"title",@"忧思在我的心里平静下去，正如暮色降临在寂静的山林中。",@"info", nil];
    NSDictionary *tempDic6 = [[NSDictionary alloc]initWithObjectsAndKeys:@"",@"image",@"只能有七个字",@"title",@"她的热切的脸，如夜雨似的，搅扰着我的梦魂。",@"info", nil];
    NSDictionary *tempDic7 = [[NSDictionary alloc]initWithObjectsAndKeys:@"",@"image",@"飞鸟集",@"title",@"静静地听，我的心呀，听那世界的低语，这是它对你求爱的表示呀。",@"info", nil];
    
    NSArray *subjectArr1= [[NSArray alloc]initWithObjects:tempDic1,tempDic2, nil];
    NSArray *subjectArr2= [[NSArray alloc]initWithObjects:tempDic3,tempDic4,tempDic5,tempDic7, nil];
    NSArray *subjectArr3= [[NSArray alloc]initWithObjects:tempDic6, nil];
    
    NSDictionary *dic1= [[NSDictionary alloc]initWithObjectsAndKeys:@"2011-10-1 周三",@"time",subjectArr1,@"data", nil];
    NSDictionary *dic2= [[NSDictionary alloc]initWithObjectsAndKeys:@"2011-10-2 周四",@"time",subjectArr2,@"data", nil];
    NSDictionary *dic3= [[NSDictionary alloc]initWithObjectsAndKeys:@"2011-10-3 周五",@"time",subjectArr3,@"data", nil];
    [self.dataArr addObject:dic1];
    [self.dataArr addObject:dic2];
    [self.dataArr addObject:dic3];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        NSDictionary *tempDic = [self.dataArr objectAtIndex:section];
        NSArray *tempArr = [tempDic objectForKey:@"data"];
        return tempArr.count;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH , 30)];
    headView.backgroundColor = BackGroundColor;
    
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 20)];
    titleLab.font = [UIFont systemFontOfSize:14];
    titleLab.backgroundColor = MainColor;
    titleLab.textColor = [UIColor whiteColor];
    
    NSDictionary *tempDic = [self.dataArr objectAtIndex:section];
    
    //设置每组的的标题
    titleLab.text = [tempDic objectForKey:@"time"];
    [headView addSubview:titleLab];//将标题v_headerLab添加到创建的视图（v_headerView）中
    return headView;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //1.加载xib
    static NSString *CellIdentifier = @"TodaySubjectTableViewCell";
    TodaySubjectTableViewCell *cell = (TodaySubjectTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        NSBundle *bundle = [NSBundle mainBundle];
        NSArray *nibArray = [bundle loadNibNamed:CellIdentifier owner:self options:nil];
        cell = (TodaySubjectTableViewCell *)[nibArray objectAtIndex:0];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    //
    cell.titleImg.layer.cornerRadius = cell.titleImg.frame.size.width/2;
    cell.titleImg.layer.masksToBounds = YES;
    
    NSDictionary *temp = [self.dataArr objectAtIndex:indexPath.section];
    NSArray *tempArr = [temp objectForKey:@"data"];
    NSDictionary *dic = [tempArr objectAtIndex:indexPath.row];
    cell.titleLab.text = [dic objectForKey:@"title"];
    cell.infoLab.text = [dic objectForKey:@"info"];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *temp = [self.dataArr objectAtIndex:indexPath.section];
    NSArray *tempArr = [temp objectForKey:@"data"];
    NSDictionary *dic = [tempArr objectAtIndex:indexPath.row];
    NSString *str = [dic objectForKey:@"info"];
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:12]};
        CGSize labelSize = [str boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-80, 0) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    return labelSize.height+50;
}
//去掉UItableview headerview黏性
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.tableView)
    {
        CGFloat sectionHeaderHeight = 30;
        if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
    }
}


@end
