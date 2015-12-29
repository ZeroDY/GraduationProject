//
//  NewsViewController.m
//  ASParentTest
//
//  Created by 周德艺 on 15/11/17.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsTableViewCell.h"
#import "NewsDetailViewController.h"
#import "TeacherViewController.h"
#import "LoginViewController.h"
#import "NewObject.h"
@interface NewsViewController ()

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"新闻";
    //创建segmentControl
    LjjUISegmentedControl* ljjuisement=[[LjjUISegmentedControl alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,34)];
    ljjuisement.delegate = self;
    ljjuisement.titleColor = MainColor;
    ljjuisement.selectColor = MainColor;
    NSArray* ljjarray=[NSArray arrayWithObjects:@"热点新闻",@"教育信息",@"校园动态",@"招考信息",nil];
    [ljjuisement AddSegumentArray:ljjarray];
    [self.view addSubview:ljjuisement];
    //设置newType
    self.newsType = 0;//0热点新闻 1教育信息 2校园动态  3招考信息
    
    //
    self.tablewView.separatorColor = [UIColor clearColor];
    self.tablewView.backgroundColor = BackGroundColor;
    
    //取出所有数据
    //假数据
    //热点新闻数据
    self.tempNormalArr = [[NSMutableArray alloc]init];
    self.tempHotArr = [[NSMutableArray alloc]init];
    NSString *plistPath1 = [[NSBundle mainBundle] pathForResource:@"NewsHotPlist" ofType:@"plist"];
    NSArray *data1 = [NSArray arrayWithContentsOfFile:plistPath1];
    NSLog(@"%@",data1);
    self.tempHotArr = [NewObject mj_objectArrayWithKeyValuesArray:data1];
    NSLog(@"%@",self.tempNormalArr);
    //普通新闻数据
    NSString *plistPath2 = [[NSBundle mainBundle] pathForResource:@"NewsPlist" ofType:@"plist"];
    NSArray *data2 = [NSArray arrayWithContentsOfFile:plistPath2];
    NSLog(@"%@",data2);
    self.tempNormalArr = [NewObject mj_objectArrayWithKeyValuesArray:data2];
    NSLog(@"%@",self.tempHotArr);
    //    for (int i = 0; i < data.count; i++) {
    //        NSDictionary *dic = [data objectAtIndex:i];
    //        QuestionObject *queObj = [QuestionObject mj_objectWithKeyValues:dic];
    //        queObj.optArr = [OptionalObject mj_objectArrayWithKeyValuesArray:queObj.optArr];
    //        [self.dataArr addObject:queObj];
    //    }
    
}
-(void)viewWillAppear:(BOOL)animated{
    [self manageNewsData:0 andSmallType:0];
}
/**
 *	个人中心
 */
- (IBAction)goPersonalVC:(id)sender{
    //设置最近一次变更
    kLastSelectedIndex = 1;
    
    TeacherViewController *pVC = [[TeacherViewController alloc]init];
    pVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:pVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - LjjUISegmentedControl
-(void)uisegumentSelectionChange:(NSInteger)selection{
    NSLog(@"%ld",(long)selection);
    self.newsType = (int)selection;
    [self manageNewsData:self.newsType andSmallType:0];
}
#pragma mark - segmentConrol
-(void)segmentAction:(UISegmentedControl *)Seg{
    NSInteger Index = Seg.selectedSegmentIndex;
    NSLog(@"Index %li", (long)Index);
    switch (Index) {
        case 0:
            NSLog(@"点击了国内新闻热点");
            [self manageNewsData:0 andSmallType:0];
            break;
        case 1:
            NSLog(@"点击了国外新闻热点");
            [self manageNewsData:0 andSmallType:1];
            break;
        default:
            break;
    }
}
-(void)manageNewsData:(int)bigType andSmallType:(int)smallType{
    self.dataArr = [[NSMutableArray alloc]init];
    if (bigType == 0) {//热点新闻
        if (smallType == 0) {//国内热点
            for (int i = 0 ; i < self.tempHotArr.count; i++) {
                NewObject *newObj = [self.tempHotArr objectAtIndex:i];
                if ([newObj.type isEqualToString:@"0"]) {
                    [self.dataArr addObject:newObj];
                }
            }
        }else{//国外热点
            for (int i = 0 ; i < self.tempHotArr.count; i++) {
                NewObject *newObj = [self.tempHotArr objectAtIndex:i];
                if ([newObj.type isEqualToString:@"1"]) {
                    [self.dataArr addObject:newObj];
                }
            }
        }
    }else if (bigType == 1){//教育信息
        for (int i = 0 ; i < self.tempNormalArr.count; i++) {
            NewObject *newObj = [self.tempNormalArr objectAtIndex:i];
            if ([newObj.type isEqualToString:@"0"]) {
                [self.dataArr addObject:newObj];
            }
        }
    }else if (bigType == 2){//校园动态
        for (int i = 0 ; i < self.tempNormalArr.count; i++) {
            NewObject *newObj = [self.tempNormalArr objectAtIndex:i];
            if ([newObj.type isEqualToString:@"1"]) {
                [self.dataArr addObject:newObj];
            }
        }
    }else{//招考信息
        NSLog(@"%@",self.tempNormalArr);
        for (int i = 0 ; i < self.tempNormalArr.count; i++) {
            NewObject *newObj = [self.tempNormalArr objectAtIndex:i];
            if ([newObj.type isEqualToString:@"2"]) {
                [self.dataArr addObject:newObj];
            }
        }
    }
    [self.tablewView reloadData];
    
}
#pragma mark - tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //1.加载xib
    static NSString *CellIdentifier1 = @"NewsTableViewCell";
    //根据newsType加载不同cell
    if (self.newsType == 0) {//热点新闻
        if (indexPath.row == 0) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"] ;
                cell.backgroundColor = [UIColor clearColor];
                cell.contentView.backgroundColor = [UIColor clearColor];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            //创建adScrollView
            AdvertScrollView* adScrollView=[[AdvertScrollView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,170)];
            adScrollView.layer.cornerRadius = 5;
            adScrollView.adScrollViewDelegate = self;
            [cell addSubview:adScrollView];
            //假数据(轮播图片的假数据)
            NSDictionary *dic1 = [[NSDictionary alloc]initWithObjectsAndKeys:@"lab1",@"titleName",@"pic-20.png",@"picUrl", nil];
            NSDictionary *dic2 = [[NSDictionary alloc]initWithObjectsAndKeys:@"lab2",@"titleName",@"pic-22.png",@"picUrl", nil];
            NSDictionary *dic3 = [[NSDictionary alloc]initWithObjectsAndKeys:@"lab3",@"titleName",@"pic-21.png",@"picUrl", nil];
            
            [adScrollView.topNewsArray addObject:dic1];
            [adScrollView.topNewsArray addObject:dic2];
            [adScrollView.topNewsArray addObject:dic3];
            [adScrollView setUpBigView];
            return cell;
        }
        else if (indexPath.row == 1){
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell2"] ;
                cell.backgroundColor = [UIColor clearColor];
                cell.contentView.backgroundColor = [UIColor clearColor];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"国内热点",@"国外热点",nil];
                UISegmentedControl *segmentControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
                segmentControl.frame = CGRectMake(50, 7, SCREEN_WIDTH-100, 30);
                segmentControl.selectedSegmentIndex = 0;//设置默认选择项索引
                
                segmentControl.tintColor = MainColor;
                [segmentControl addTarget: self
                                   action: @selector(segmentAction:)
                         forControlEvents: UIControlEventValueChanged
                 ];
                [cell addSubview:segmentControl];
            }
            return cell;
        }
        else{
            NewsTableViewCell *cell = (NewsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
            if (cell == nil) {
                NSBundle *bundle = [NSBundle mainBundle];
                NSArray *nibArray = [bundle loadNibNamed:CellIdentifier1 owner:self options:nil];
                cell = (NewsTableViewCell *)[nibArray objectAtIndex:0];
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            }
            NewObject *newObj = [self.dataArr objectAtIndex:indexPath.row];
            NSString *imgStr = newObj.photo;
            cell.titleImg.image = [UIImage imageNamed:imgStr];
            cell.titleLab.text = newObj.title;
            cell.infoLab.text = newObj.info;
            return cell;
        }
    }
    else{
        if (indexPath.row == 0) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"] ;
                cell.backgroundColor = [UIColor clearColor];
                cell.contentView.backgroundColor = [UIColor clearColor];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            //创建adScrollView
            AdvertScrollView* adScrollView=[[AdvertScrollView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,170)];
            adScrollView.layer.cornerRadius = 5;
            adScrollView.adScrollViewDelegate = self;
            [cell addSubview:adScrollView];
            //假数据(轮播图片的假数据)
            NSDictionary *dic1 = [[NSDictionary alloc]initWithObjectsAndKeys:@"lab1",@"titleName",@"img1",@"picUrl", nil];
            NSDictionary *dic2 = [[NSDictionary alloc]initWithObjectsAndKeys:@"lab1",@"titleName",nil,@"picUrl", nil];
            NSDictionary *dic3 = [[NSDictionary alloc]initWithObjectsAndKeys:@"lab1",@"titleName",@"img1",@"picUrl", nil];
            
            [adScrollView.topNewsArray addObject:dic1];
            [adScrollView.topNewsArray addObject:dic2];
            [adScrollView.topNewsArray addObject:dic3];
            [adScrollView setUpBigView];
            return cell;
        }
        else{
            NewsTableViewCell *cell = (NewsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
            if (cell == nil) {
                NSBundle *bundle = [NSBundle mainBundle];
                NSArray *nibArray = [bundle loadNibNamed:CellIdentifier1 owner:self options:nil];
                cell = (NewsTableViewCell *)[nibArray objectAtIndex:0];
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            }
            NewObject *newObj = [self.dataArr objectAtIndex:indexPath.row];
            NSString *imgStr = newObj.photo;
            cell.titleImg.image = [UIImage imageNamed:imgStr];
            cell.titleLab.text = newObj.title;
            cell.infoLab.text = newObj.info;
            return cell;
        }
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.newsType == 0) {
        if (indexPath.row == 0) {
            return 170;
        }
        else if (indexPath.row == 1){
            return 35;
        }
        else{
            return 100;
        }
    }else{
        if (indexPath.row == 0) {
            return 170;
        }
        else{
            return 100;
        }
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsDetailViewController *newsDetailVC = [[NewsDetailViewController alloc]initWithNibName:@"NewsDetailViewController" bundle:nil];
    newsDetailVC.newsObj = [self.dataArr objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:newsDetailVC animated:YES];
}
@end
