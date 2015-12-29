//
//  RecommendViewController.m
//  ASParentTest
//
//  Created by 周德艺 on 15/11/17.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "RecommendViewController.h"
#import "NewsTableViewCell.h"
#import "RecTeacherTableViewCell.h"
#import "RecPersonTableViewCell.h"
#import "RecBookDetailViewController.h"
#import "RecTeacherDetailViewController.h"
#import "TeacherViewController.h"
#import "LoginViewController.h"
#import "GoodBookObject.h"
#import "TeacherTypeObject.h"
#import "GoodTeacherObject.h"
#import "GoodClassObject.h"
#import "JiaoShuYuRenObject.h"
#import "RecommendNormalDetailViewController.h"
//接口
#import "DYRequestBase+GetGoodBookList.h"
#import "DYRequestBase+GetGoodTeacherType.h"
#import "DYRequestBase+GetGoodTeacherList.h"
#import "DYRequestBase+GetGoodClassList.h"
#import "DYRequestBase+GetJiaoShuYuRenList.h"
@interface RecommendViewController ()

@end

@implementation RecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"推荐";
    //创建segmentControl
    LjjUISegmentedControl* ljjuisement=[[LjjUISegmentedControl alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,34)];
    ljjuisement.delegate = self;
    ljjuisement.titleColor = MainColor;
    ljjuisement.selectColor = MainColor;
    NSArray* ljjarray=[NSArray arrayWithObjects:@"好书推荐",@"名师推荐",@"课堂推荐",@"教书育人",nil];
    [ljjuisement AddSegumentArray:ljjarray];
    [self.view addSubview:ljjuisement];
    //设置recommendType
    self.recommendType = 0;// 0好书推荐",1@"名师推荐",2@"课堂推荐",3@"教书育人
    //设置teacherType
    self.teacherType = @"全部";
    //tableView视图
    self.tableView = [[UITableView alloc]init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tag = 0;
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.separatorColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
    
    //listBtn视图
    self.listBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,34, SCREEN_WIDTH, 30.0)];
    [self.listBtn setTitle:@"全部" forState:UIControlStateNormal];
    [self.listBtn setTitleColor:MainColor forState:UIControlStateNormal];
    [self.listBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [self.listBtn addTarget:self action:@selector(listBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.listBtn setBackgroundColor:[UIColor whiteColor]];
    self.listBtn.hidden = YES;
    self.listBtn.tag = 0;//0未选中，1选中
    [self.view addSubview:self.listBtn];
    
    //listTableBackView视图
    self.listTableBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 34+30, SCREEN_WIDTH, SCREEN_HEIGHT-34-30)];
    self.listTableBackView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.listTableBackView];
    self.listTableBackView.hidden = YES;
    
    //listTableView视图
    self.listTableView = [[UITableView alloc]init];
    self.listTableView.delegate = self;
    self.listTableView.dataSource = self;
    self.listTableView.tag = 1;
    [self.listTableBackView addSubview:self.listTableView];
    self.listTableView.hidden = YES;
    
    //根据recommendType刷新tableView
    [self refreshRecommendType];
    
    //下拉刷新
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.currentPage = 1;
        
        switch (self.recommendType) {
            case 0://好书推荐
            {
                [self getGoodBookListWithCurrentPage:self.currentPage andRowOfPage:@"10"];
            }
                break;
            case 1://老师推荐
            {
                [self getGoodTeacherListByType:self.teacherType WithCurrentPage:self.currentPage andRowOfPage:@"10"];
            }
                break;
            case 2://课程推荐
            {
                [self getGoodClassListWithCurrentPage:self.currentPage andRowOfPage:@"10"];
            }
                break;
            case 3://教书育人
            {
                [self getJiaoShuYuRenListWithCurrentPage:self.currentPage andRowOfPage:@"10"];
            }
                break;
            default:
                break;
        }
    }];
    // 上拉刷新方法1
    self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        switch (self.recommendType) {
            case 0://好书推荐
            {
                if (self.currentPage == self.bookAllPages) {
                    [PublicObject showHUDView:self.view title:@"已经是最后一页" content:@"" time:1 andCodes:^{
                        [self.tableView.footer endRefreshing];
                    }];
                }else{
                    self.currentPage++;
                    [self getGoodBookListWithCurrentPage:self.currentPage andRowOfPage:@"10"];
                }
            }
                break;
            case 1://老师推荐
            { if (self.currentPage == self.teacherAllPages) {
                [PublicObject showHUDView:self.view title:@"已经是最后一页" content:@"" time:1 andCodes:^{
                    [self.tableView.footer endRefreshing];
                }];
            }else{
                self.currentPage++;
                [self getGoodTeacherListByType:self.teacherType WithCurrentPage:self.currentPage andRowOfPage:@"10"];
            }
            }
                break;
            case 2://课程推荐
            { if (self.currentPage == self.classAllPages) {
                [PublicObject showHUDView:self.view title:@"已经是最后一页" content:@"" time:1 andCodes:^{
                    [self.tableView.footer endRefreshing];
                }];
            }else{
                self.currentPage++;
                [self getGoodClassListWithCurrentPage:self.currentPage andRowOfPage:@"10"];
            }
            }
                break;
            case 3://教书育人
            {
                if (self.currentPage == self.jsyrAllPages) {
                    [PublicObject showHUDView:self.view title:@"已经是最后一页" content:@"" time:1 andCodes:^{
                        [self.tableView.footer endRefreshing];
                    }];
                }else{
                    self.currentPage++;
                    [self getJiaoShuYuRenListWithCurrentPage:self.currentPage andRowOfPage:@"10"];
                }
            }
                break;
            default:
                break;
        }
    }];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.tableView.header beginRefreshing];
}
//好书推荐
-(void)getGoodBookListWithCurrentPage:(NSInteger)currentPage andRowOfPage:(NSString *)rowOfPage{
    [DYRequestBase getGoodBookListByCurrentPageNum:[NSString stringWithFormat:@"%ld",(long)currentPage] RowOfPage:rowOfPage requestStartBlock:^{
        [PublicObject showHUDBegain:self.view title:@"正在获取……"];
    } responseBlock:^(id dataObj, NSError *error) {
        [PublicObject dissMissHUDEnd];
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
        if (dataObj) {
            self.dataArr = [[NSMutableArray alloc]init];
            
            int status = [[dataObj objectForKey:@"status"] intValue];
            NSString *msg = [PublicObject convertNullString:[dataObj objectForKey:@"msg"]];
            if (status == 0) {
                self.bookAllPages = [[[dataObj objectForKey:@"pageInfo"] objectForKey:@"allPageNum"] intValue];
                NSArray *objArr = [dataObj objectForKey:@"list"];
                NSLog(@"%@",objArr);
                self.dataArr = [GoodBookObject mj_objectArrayWithKeyValuesArray:objArr];
                [self.tableView reloadData];
            }
            else {
                [PublicObject showHUDView:self.view title:msg content:@"" time:kHUDTime andCodes:^{
                }];
            }
        }else{
            [PublicObject showHUDView:self.view title:@"请求失败" content:@"" time:kHUDTime andCodes:^{
            }];
        }    }];
    
}
//老师推荐
-(void)getGoodTeacherListByType:(NSString *)type WithCurrentPage:(NSInteger)currentPage andRowOfPage:(NSString *)rowOfPage{
    //中文转码
    type = [type stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [DYRequestBase getGoodTeacherListByType:type CurrentPageNum:[NSString stringWithFormat:@"%ld",(long)currentPage] RowOfPage:rowOfPage requestStartBlock:^{
        [PublicObject showHUDBegain:self.view title:@"正在获取……"];
    } responseBlock:^(id dataObj, NSError *error) {
        [PublicObject dissMissHUDEnd];
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
        if (dataObj) {
            self.dataArr = [[NSMutableArray alloc]init];
            
            int status = [[dataObj objectForKey:@"status"] intValue];
            NSString *msg = [PublicObject convertNullString:[dataObj objectForKey:@"msg"]];
            if (status == 0) {
                self.teacherAllPages = [[[dataObj objectForKey:@"pageInfo"] objectForKey:@"allPageNum"] intValue];
                NSArray *objArr = [dataObj objectForKey:@"list"];
                NSLog(@"%@",objArr);
                self.dataArr = [GoodTeacherObject mj_objectArrayWithKeyValuesArray:objArr];
                [self.tableView reloadData];
            }
            else {
                [PublicObject showHUDView:self.view title:msg content:@"" time:kHUDTime andCodes:^{
                }];
            }
        }else{
            [PublicObject showHUDView:self.view title:@"请求失败" content:@"" time:kHUDTime andCodes:^{
            }];
        }
    }];
}
//课程推荐
-(void)getGoodClassListWithCurrentPage:(NSInteger)currentPage andRowOfPage:(NSString *)rowOfPage{
    [DYRequestBase getGoodClassListByCurrentPageNum:[NSString stringWithFormat:@"%ld",(long)currentPage] RowOfPage:rowOfPage requestStartBlock:^{
        [PublicObject showHUDBegain:self.view title:@"正在获取……"];
    } responseBlock:^(id dataObj, NSError *error) {
        [PublicObject dissMissHUDEnd];
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
        if (dataObj) {
            self.dataArr = [[NSMutableArray alloc]init];
            
            int status = [[dataObj objectForKey:@"status"] intValue];
            NSString *msg = [PublicObject convertNullString:[dataObj objectForKey:@"msg"]];
            if (status == 0) {
                self.classAllPages = [[[dataObj objectForKey:@"pageInfo"] objectForKey:@"allPageNum"] intValue];
                NSArray *objArr = [dataObj objectForKey:@"list"];
                NSLog(@"%@",objArr);
                self.dataArr = [GoodClassObject mj_objectArrayWithKeyValuesArray:objArr];
                [self.tableView reloadData];
            }
            else {
                [PublicObject showHUDView:self.view title:msg content:@"" time:kHUDTime andCodes:^{
                }];
            }
        }else{
            [PublicObject showHUDView:self.view title:@"请求失败" content:@"" time:kHUDTime andCodes:^{
            }];
        }    }];
    
}
//教书育人
-(void)getJiaoShuYuRenListWithCurrentPage:(NSInteger)currentPage andRowOfPage:(NSString *)rowOfPage{
    [DYRequestBase getJiaoShuYuRenListByCurrentPageNum:[NSString stringWithFormat:@"%ld",(long)currentPage] RowOfPage:rowOfPage requestStartBlock:^{
        [PublicObject showHUDBegain:self.view title:@"正在获取……"];
    } responseBlock:^(id dataObj, NSError *error) {
        [PublicObject dissMissHUDEnd];
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
        if (dataObj) {
            self.dataArr = [[NSMutableArray alloc]init];
            
            int status = [[dataObj objectForKey:@"status"] intValue];
            NSString *msg = [PublicObject convertNullString:[dataObj objectForKey:@"msg"]];
            if (status == 0) {
                self.jsyrAllPages = [[[dataObj objectForKey:@"pageInfo"] objectForKey:@"allPageNum"] intValue];
                NSArray *objArr = [dataObj objectForKey:@"list"];
                NSLog(@"%@",objArr);
                self.dataArr = [JiaoShuYuRenObject mj_objectArrayWithKeyValuesArray:objArr];
                [self.tableView reloadData];
            }
            else {
                [PublicObject showHUDView:self.view title:msg content:@"" time:kHUDTime andCodes:^{
                }];
            }
        }else{
            [PublicObject showHUDView:self.view title:@"请求失败" content:@"" time:kHUDTime andCodes:^{
            }];
        }    }];
    
}

/**
 *	个人中心
 */
- (IBAction)goPersonalVC:(id)sender{
    //设置最近一次变更
    kLastSelectedIndex = 2;
    
    TeacherViewController *pVC = [[TeacherViewController alloc]init];
    pVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:pVC animated:YES];
}
-(void)refreshRecommendType{
    if (self.recommendType == 1) {//名师推荐
        //创建tableView
        self.tableView.frame= CGRectMake(0, 34+30, SCREEN_WIDTH, SCREEN_HEIGHT-64-34-30-50);
        self.listBtn.hidden = NO;
    }else{
        //创建tableView
        self.tableView.frame = CGRectMake(0, 34, SCREEN_WIDTH, SCREEN_HEIGHT-64-34-50);
        self.listBtn.hidden = YES;
    }
    switch (self.recommendType) {
        case 0://好书推荐
        {
            [self getGoodBookListWithCurrentPage:self.currentPage andRowOfPage:@"10"];
        }
            break;
        case 1://老师推荐
        {
            [self getGoodTeacherListByType:self.teacherType WithCurrentPage:self.currentPage andRowOfPage:@"10"];
        }
            break;
        case 2://课程推荐
        {
            [self getGoodClassListWithCurrentPage:self.currentPage andRowOfPage:@"10"];
        }
            break;
        case 3://教书育人
        {
            [self getJiaoShuYuRenListWithCurrentPage:self.currentPage andRowOfPage:@"10"];
        }
            break;
        default:
            break;
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)listBtnClick{
    if (self.listBtn.tag == 0) {//未选中
        self.listBtn.tag = 1;
        self.listTableBackView.hidden = NO;
        self.listTableView.hidden = NO;
        //根据listTyprArr数量设置listTableViewrframe
        self.listTableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 30*self.listTypeArr.count);
        [self.listTableView reloadData];
    }else{
        self.listBtn.tag = 0;
        self.listTableBackView.hidden = YES;
        self.listTableView.hidden = YES;
        //刷新数据
        [self getGoodTeacherListByType:self.teacherType WithCurrentPage:self.currentPage andRowOfPage:@"10"];
    }
}
//获取所有老师科目列表
-(void)getTeacherTypeList{
    [DYRequestBase getGoodTeacherTypeRequestStartBlock:^{
        [PublicObject showHUDBegain:self.view title:@"正在获取……"];
    } responseBlock:^(id dataObj, NSError *error) {
        [PublicObject dissMissHUDEnd];
        if (dataObj) {
            self.dataArr = [[NSMutableArray alloc]init];
            
            int status = [[dataObj objectForKey:@"status"] intValue];
            NSString *msg = [PublicObject convertNullString:[dataObj objectForKey:@"msg"]];
            if (status == 0) {
                NSArray *objArr = [dataObj objectForKey:@"list"];
                NSLog(@"%@",objArr);
                self.listTypeArr = [TeacherTypeObject mj_objectArrayWithKeyValuesArray:objArr];
                //插入全部
                TeacherTypeObject *typeObj = [[TeacherTypeObject alloc]init];
                typeObj.teacoursename = @"全部";
                [self.listTypeArr insertObject:typeObj atIndex:0];
            }
            else {
                [PublicObject showHUDView:self.view title:msg content:@"" time:kHUDTime andCodes:^{
                }];
            }
        }else{
            [PublicObject showHUDView:self.view title:@"请求失败" content:@"" time:kHUDTime andCodes:^{
            }];
        }
    }];
}
#pragma mark - LjjUISegmentedControl
-(void)uisegumentSelectionChange:(NSInteger)selection{
    NSLog(@"%ld",(long)selection);
    self.recommendType = (int)selection;
    if (self.recommendType == 1) {
        //老师类型数据
        self.listTypeArr = [[NSMutableArray alloc]init];
        [self getTeacherTypeList];
    }
    [self refreshRecommendType];
}
#pragma mark - tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag == 0) {
        return self.dataArr.count;
    }else{
        return self.listTypeArr.count;
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 0) {
        //1.加载xib
        static NSString *CellIdentifier1 = @"NewsTableViewCell";
        static NSString *CellIdentifier2 = @"RecTeacherTableViewCell";
        static NSString *CellIdentifier3 = @"RecPersonTableViewCell";
        //根据newsType加载不同cell
        if (self.recommendType == 0) {//好书推荐
            NewsTableViewCell *cell = (NewsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
            if (cell == nil) {
                NSBundle *bundle = [NSBundle mainBundle];
                NSArray *nibArray = [bundle loadNibNamed:CellIdentifier1 owner:self options:nil];
                cell = (NewsTableViewCell *)[nibArray objectAtIndex:0];
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            }
            //数据
            GoodBookObject *bookObj = [self.dataArr objectAtIndex:indexPath.row];
            NSURL *imageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[PublicObject convertNullString:bookObj.bpicture]]];
            [cell.titleImg sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"default"]];
            cell.titleLab.text = [PublicObject convertNullString:bookObj.bname];
            cell.infoLab.text = [PublicObject convertNullString:bookObj.bjianjie];
            
            return cell;
        }else if (self.recommendType == 1){//名师推荐
            RecTeacherTableViewCell *cell = (RecTeacherTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
            if (cell == nil) {
                NSBundle *bundle = [NSBundle mainBundle];
                NSArray *nibArray = [bundle loadNibNamed:CellIdentifier2 owner:self options:nil];
                cell = (RecTeacherTableViewCell *)[nibArray objectAtIndex:0];
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            }
            //样式
            cell.titleLab.textColor = MainColor;
            //数据
            GoodTeacherObject *teacherObj = [self.dataArr objectAtIndex:indexPath.row];
            NSURL *imageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[PublicObject convertNullString:teacherObj.gtpicture]]];
            [cell.imgView sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"default"]];
            cell.titleLab.text = [PublicObject convertNullString:teacherObj.teaname];
            cell.infoLab1.text = [PublicObject convertNullString:teacherObj.teacoursename];
            cell.infoLab2.text = [PublicObject convertNullString:teacherObj.fromschoolname];
            cell.infoLab3.text = [PublicObject convertNullString:teacherObj.jlinian];
            cell.infoLab4.text = [PublicObject convertNullString:teacherObj.tdianzan];
            return cell;
            
        }else if (self.recommendType == 2){//课程推荐
            RecTeacherTableViewCell *cell = (RecTeacherTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
            if (cell == nil) {
                NSBundle *bundle = [NSBundle mainBundle];
                NSArray *nibArray = [bundle loadNibNamed:CellIdentifier2 owner:self options:nil];
                cell = (RecTeacherTableViewCell *)[nibArray objectAtIndex:0];
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            }
            //样式
            cell.titleLab.textColor = MainColor;
            //数据
            GoodClassObject *classObj = [self.dataArr objectAtIndex:indexPath.row];
            NSURL *imageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[PublicObject convertNullString:classObj.kpicture]]];
            [cell.imgView sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"default"]];
            
            cell.titleLab.text = [PublicObject convertNullString:classObj.kname];
            
            
            cell.infoLab1.text = [PublicObject convertNullString:classObj.jiangname];
            cell.infoLab2.text = [PublicObject convertNullString:classObj.kaddress];
            cell.infoLab3.text = [NSString stringWithFormat:@"开讲时间:%@",[PublicObject convertNullString:classObj.kname]];
            cell.infoLab4.hidden = YES;
            
            return cell;
        }else{
            RecPersonTableViewCell *cell = (RecPersonTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier3];
            if (cell == nil) {
                NSBundle *bundle = [NSBundle mainBundle];
                NSArray *nibArray = [bundle loadNibNamed:CellIdentifier3 owner:self options:nil];
                cell = (RecPersonTableViewCell *)[nibArray objectAtIndex:0];
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            }
            
            //样式
            cell.titleLab.textColor = MainColor;
            //假数据
            JiaoShuYuRenObject *jiaoshuyurenObj = [self.dataArr objectAtIndex:indexPath.row];
            NSURL *imageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[PublicObject convertNullString:jiaoshuyurenObj.jpicture]]];
            [cell.imgView sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"default"]];
            cell.titleLab.text = [PublicObject convertNullString:jiaoshuyurenObj.jheader];
            
            
            //            cell.titleLab.text = @"黄珊:遇见孩子，发现更好的自己";
            return cell;
        }
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"] ;
            cell.backgroundColor = [UIColor clearColor];
            cell.contentView.backgroundColor = [UIColor clearColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        //样式
        cell.textLabel.textColor = [UIColor lightGrayColor];
        cell.textLabel.font = [UIFont systemFontOfSize:12];
        //数据
        TeacherTypeObject *typeObj = [self.listTypeArr objectAtIndex:indexPath.row];
        cell.textLabel.text = [PublicObject convertNullString:typeObj.teacoursename];
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 0) {
        return 110;
    }else{
        return 30;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 0) {
        if (self.recommendType == 1){//名师推荐
            GoodTeacherObject *teacherObj = [self.dataArr objectAtIndex:indexPath.row];
            
            RecTeacherDetailViewController *recTeacherDetailVC = [[RecTeacherDetailViewController alloc]initWithNibName:@"RecTeacherDetailViewController" bundle:nil];
            recTeacherDetailVC.hidesBottomBarWhenPushed = YES;
            recTeacherDetailVC.teacherObj = teacherObj;
            [self.navigationController pushViewController:recTeacherDetailVC animated:YES];
        }
        else{//
            RecommendNormalDetailViewController *recommendNormalDetailVC = [[RecommendNormalDetailViewController alloc]initWithNibName:@"RecommendNormalDetailViewController" bundle:nil];
            recommendNormalDetailVC.hidesBottomBarWhenPushed = YES;
            if (self.recommendType == 0) {//好书推荐
                GoodBookObject *bookObj = [self.dataArr objectAtIndex:indexPath.row];
                recommendNormalDetailVC.title = [PublicObject convertNullString:bookObj.bname];
                recommendNormalDetailVC.idCode = [NSString stringWithFormat:@"api.recommend.goodBookSummary.do?goodBookId=%@",bookObj.idcode];
            }
            else if (self.recommendType == 2){//课堂推荐
                GoodClassObject *classObj = [self.dataArr objectAtIndex:indexPath.row];
                recommendNormalDetailVC.title = [PublicObject convertNullString:classObj.kname];
                recommendNormalDetailVC.idCode = [NSString stringWithFormat:@"api.recommend.goodKeTangSummary.do?keTangId=%@",classObj.idcode];
                ;
            }else{//教书育人
                JiaoShuYuRenObject *jiaoshuyurenObj = [self.dataArr objectAtIndex:indexPath.row];
                recommendNormalDetailVC.title = [PublicObject convertNullString:jiaoshuyurenObj.jheader];
                recommendNormalDetailVC.idCode = [NSString stringWithFormat:@"api.recommend.jiaoShuYuRenSummary.do?jiaoShuId=%@",jiaoshuyurenObj.idcode];
            }
            [self.navigationController pushViewController:recommendNormalDetailVC animated:YES];
        }
    }else{
        TeacherTypeObject *typeObj = [self.listTypeArr objectAtIndex:indexPath.row];
        [self.listBtn setTitle:typeObj.teacoursename forState:UIControlStateNormal];
        self.teacherType = typeObj.teacoursename;
        [self listBtnClick];
    }
}
@end
