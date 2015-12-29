//
//  HomeWorkOnlineViewController.m
//  ASParentTest
//
//  Created by 张浩 on 15/12/3.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "HomeWorkOnlineViewController.h"
#import "HomeWorkOnlineCollectionViewCell.h"
#import "ZcdcDetailHeaderView.h"
#import "ZcdcDetailTableViewCell.h"
#import "QuestionObject.h"
#import "OptionalObject.h"

static CGFloat const kBackViewWidthYes = 40.0;
static CGFloat const kBackViewWidthNo = 0.0;
@interface HomeWorkOnlineViewController ()

@end

@implementation HomeWorkOnlineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.collectionView registerClass:[HomeWorkOnlineCollectionViewCell class] forCellWithReuseIdentifier:@"HomeWorkOnlineCollectionViewCell"];
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.bottomBackView.backgroundColor = [UIColor whiteColor];
    self.lastQuestionBtn.backgroundColor = MainColor;
    self.nextQuestionBtn.backgroundColor = MainColor;
    
    //默认当前问题
    self.questionIndex = 0;
    //初始化隐藏上一题
    self.lastQuestionBtn.hidden = YES;
    
    //tableView样式
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    self.resultArr = [[NSMutableArray alloc]init];
    self.dataArr = [[NSMutableArray alloc]init];
    //假数据
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"HomeWorkOnlineQuestion" ofType:@"plist"];
    NSArray *data = [NSArray arrayWithContentsOfFile:plistPath];
    NSLog(@"%@",data);
    for (int i = 0; i < data.count; i++) {
        NSDictionary *dic = [data objectAtIndex:i];
        QuestionObject *queObj = [QuestionObject mj_objectWithKeyValues:dic];
        queObj.optArr = [OptionalObject mj_objectArrayWithKeyValuesArray:queObj.optArr];
        [self.dataArr addObject:queObj];
    }
    NSLog(@"%@",self.dataArr);
    //默认选中第一个问题
    QuestionObject *queObj = [self.dataArr objectAtIndex:0];
    queObj.status = @"1";
    self.oldIndex = 0;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    
}
#pragma collection

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个section的item个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    //    return 3+2;
    return self.dataArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    HomeWorkOnlineCollectionViewCell *cell = (HomeWorkOnlineCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"HomeWorkOnlineCollectionViewCell" forIndexPath:indexPath];
    QuestionObject *queObj = [self.dataArr objectAtIndex:indexPath.row];
    
    cell.backView.backgroundColor = MainColor;
    cell.labBackView.backgroundColor = MainColor;
    
    
    
    //    if (indexPath.row > 2) {
    //        //设置label文字
    //        cell.lab.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row-2];
    //    }
    
    //设置label文字
    cell.lab.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
    if ([queObj.status isEqualToString:@"1"]) {
        cell.backViewHeightConstraint.constant = kBackViewWidthNo;
        cell.backViewWidthConstraint.constant = kBackViewWidthNo;
        [self animationWithConstraintYes:cell.backViewHeightConstraint WithView:cell];
        [self animationWithConstraintYes:cell.backViewWidthConstraint WithView:cell];
        
    }else{
        cell.backViewHeightConstraint.constant = kBackViewWidthYes;
        cell.backViewWidthConstraint.constant = kBackViewWidthYes;
        [self animationWithConstraintNo:cell.backViewHeightConstraint WithView:cell];
        [self animationWithConstraintNo:cell.backViewWidthConstraint WithView:cell];
        
    }
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //全部改为不选中
    for (int i = 0; i < self.dataArr.count; i++) {
        QuestionObject *queObj = [self.dataArr objectAtIndex:i];
        queObj.status = @"0";
    }
    QuestionObject *queObj = [self.dataArr objectAtIndex:indexPath.row];
    queObj.status = @"1";
    
    //刷新当前行和上一行
    NSLog(@"%ld",(long)self.oldIndex);
    NSIndexPath *reloadIndexPath = [NSIndexPath indexPathForRow:self.oldIndex inSection:0];
    NSArray *reloadIndexArr = [[NSArray alloc]initWithObjects:indexPath,reloadIndexPath, nil];
    [self.collectionView reloadItemsAtIndexPaths:reloadIndexArr];
    [self refreshTableView:indexPath.row];
    //    [self.collectionView reloadData];
    //修改选中的OldIndex
    self.oldIndex = indexPath.row;
}
- (void)animationWithConstraintYes:(NSLayoutConstraint *)constraint WithView:(UIView *)view
{
    //持续时间1.5s,回到初始大小
    constraint.constant = kBackViewWidthYes;
    [UIView animateWithDuration:0.5 animations:^{
        [view layoutIfNeeded];
    }];
}
//
- (void)animationWithConstraintNo:(NSLayoutConstraint *)constraint WithView:(UIView *)view
{
    //持续时间1.5s,回到初始大小
    constraint.constant = kBackViewWidthNo;
    [UIView animateWithDuration:0.5 animations:^{
        [view layoutIfNeeded];
    }];
}

#pragma tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.dataArr.count) {
        QuestionObject *queObj = [self.dataArr objectAtIndex:self.questionIndex];
        return queObj.optArr.count;
    }
    else{
        return 4;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    ZcdcDetailHeaderView *headView = [[ZcdcDetailHeaderView alloc]init];
    //获得nib视图数组
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ZcdcDetailHeaderView" owner:self options:nil];
    //得到第一个UIView
    headView = [nib objectAtIndex:0];
    
    if (self.dataArr.count) {
        //加载数据
        QuestionObject *queObj = [self.dataArr objectAtIndex:self.questionIndex];
        NSString *str = queObj.title;
        NSLog(@"%@",str);
        headView.titleLab.text = str;
    }
    headView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    headView.backView.backgroundColor = MainColor;
    headView.titleLab.backgroundColor = [UIColor clearColor];
    headView.titleLab.textColor = [UIColor whiteColor];
    return headView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (self.dataArr.count) {
        
        QuestionObject *queObj = [self.dataArr objectAtIndex:self.questionIndex];
        NSString *str = queObj.title;
        return [ZcdcDetailHeaderView calculateViewHeightWithContentStr:str];
    }else{
        return 44;
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //1.加载xib
    static NSString *CellIdentifier = @"ZcdcDetailTableViewCell";
    ZcdcDetailTableViewCell *cell = (ZcdcDetailTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        NSBundle *bundle = [NSBundle mainBundle];
        NSArray *nibArray = [bundle loadNibNamed:CellIdentifier owner:self options:nil];
        cell = (ZcdcDetailTableViewCell *)[nibArray objectAtIndex:0];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    cell.backView.tag = indexPath.row;//点击选择记录index使用
    cell.delegate = self;
    if (self.dataArr.count) {
        //加载数据
        NSLog(@"%@",self.dataArr);
        NSLog(@"%d",self.questionIndex);
        
        QuestionObject *queObj = [self.dataArr objectAtIndex:self.questionIndex];
        OptionalObject *optObj = [queObj.optArr objectAtIndex:indexPath.row];
        
        NSString *str = optObj.title;
        if ([optObj.status intValue] == 0) {//0 为 未选中状态 1 为选中状态
            [cell.titleImg setImage:[UIImage imageNamed:@"choose_no.png" ]];
        }else{
            [cell.titleImg setImage:[UIImage imageNamed:@"choose_yes.png" ]];
        }
        cell.titleLab.text = str;
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataArr.count) {
        QuestionObject *queObj = [self.dataArr objectAtIndex:self.questionIndex];
        OptionalObject *optObj = [queObj.optArr objectAtIndex:indexPath.row];
        
        NSLog(@"%ld",(long)indexPath.row);
        NSLog(@"%@",queObj.title);
        NSLog(@"%@",optObj.title);
        
        NSString *str = optObj.title;
        return [ZcdcDetailTableViewCell calculateCellHeightWithContentStr:str]+30;
    }else{
        return 44;
    }
}
-(void)chooseOptionalClick:(UIView *)backView{
    if (self.dataArr.count) {
        NSLog(@"%d",self.questionIndex);
        NSLog(@"%ld",(long)backView.tag);
        
        //获取当前问题的数据（包括当前问题和选项信息）
        QuestionObject *queObj = [self.dataArr objectAtIndex:self.questionIndex];
        OptionalObject *optObj = [queObj.optArr objectAtIndex:backView.tag];
        
        //修改ZcdcOptionalObject中isshow状态为1
        NSLog(@"%@",self.dataArr);
        optObj.status = @"1";
        NSLog(@"%@",self.dataArr);
        //遍历所有选项，把其他的选项变为0
        for (int i = 0; i < queObj.optArr.count; i++) {
            OptionalObject *optObj = [queObj.optArr objectAtIndex:i];
            if (i != backView.tag) {
                optObj.status = @"0";
            }
        }
        
        
        //遍历resultArr，看看是已存在该问题，若存在，则用户的操作是修改答案；若不存在，则直接添加
        BOOL isExist;
        NSLog(@"%@",self.resultArr);
        for (int i = 0; i < self.resultArr.count; i++) {
            NSMutableDictionary *dic = [self.resultArr objectAtIndex:i];
            NSString *questionId = [dic objectForKey:@"question"];
            if ([queObj.queId isEqualToString:questionId]) {
                isExist = YES;
                [dic setValue:optObj.optId forKey:@"answer"];
                break;
            }
        }
        if (!isExist) {
            NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithObjectsAndKeys:queObj.queId,@"question",optObj.optId,@"answer", nil];
            [self.resultArr addObject:dic];
        }
    }
    NSLog(@"%@",self.resultArr);
    NSLog(@"%@",self.dataArr);
    [self.tableView reloadData];
}

-(void)refreshBottomView{
    NSLog(@"%d",self.questionIndex);
    if (self.questionIndex == 0) {
        if (self.dataArr.count == 1) {
            self.lastQuestionBtn.hidden = YES;
            self.nextQuestionBtn.hidden = NO;
            [self.nextQuestionBtn setTitle:@"提交问卷" forState:UIControlStateNormal];
        }else{
            self.lastQuestionBtn.hidden = YES;
            self.nextQuestionBtn.hidden = NO;
            [self.nextQuestionBtn setTitle:@"下一题" forState:UIControlStateNormal];
        }
    }
    else if (self.questionIndex == self.dataArr.count-1){
        self.lastQuestionBtn.hidden = NO;
        self.nextQuestionBtn.hidden = NO;
        [self.nextQuestionBtn setTitle:@"提交问卷" forState:UIControlStateNormal];
        //        self.nextQuestionBtn.tag = 1;//状态为1时，下一题按钮改为改为提交问卷按钮
    }
    else{
        self.lastQuestionBtn.hidden = NO;
        self.nextQuestionBtn.hidden = NO;
        [self.lastQuestionBtn setTitle:@"上一题" forState:UIControlStateNormal];
        [self.nextQuestionBtn setTitle:@"下一题" forState:UIControlStateNormal];
        
        //        self.nextQuestionBtn.tag = 0;
    }
}
- (IBAction)lastQuestionClick:(id)sender {
    if (self.questionIndex == 0) {
        self.questionIndex = 0;
    }else{
        self.questionIndex--;
    }
    //刷新bottomBtn
    [self refreshBottomView];
    //刷新数据
    [self.tableView reloadData];
}

- (IBAction)nextQuestionClick:(id)sender {
    //    UIButton *btn = (UIButton *)sender;
    //    if (btn.tag == 0) {
    if (self.questionIndex == self.dataArr.count-1) {
        self.questionIndex = (int)self.dataArr.count-1;
    }else{
        self.questionIndex++;
    }
    //刷新bottomBtn
    [self refreshBottomView];
    if(self.questionIndex == self.dataArr.count){
        [self submitResults];
        
    }else{
        //刷新数据
        [self.tableView reloadData];
    }
    //    }else{//提交问卷
    //        [self submitResults];
    //    }
    
}
-(void)refreshTableView:(NSInteger) cellIndex{
    
    //    //    for (int i = 0; i < self.dataArr.count; i++) {
    //    QuestionObject *queObj = [self.dataArr objectAtIndex:backView.tag];
    //    NSLog(@"%@",queObj.status);
    //    if ([queObj.status isEqualToString:@"0"]) {
    //        [ animationWithConstraintNo:self.backViewHeightConstraint WithView:self];
    //        [self animationWithConstraintNo:self.backViewWidthConstraint WithView:self];
    //    }else{
    //        [self animationWithConstraintYes:self.backViewHeightConstraint WithView:self];
    //        [self animationWithConstraintYes:self.backViewWidthConstraint WithView:self];
    //    }
    //    //    }
    
    
    
    self.questionIndex = (int)cellIndex;
    //刷新bottomBtn
    [self refreshBottomView];
    if(self.questionIndex == self.dataArr.count){
        [self submitResults];
        
    }else{
        //刷新数据
        [self.tableView reloadData];
    }
    
}
-(void)submitResults{
    //    AccoutObject *userObj = [UIViewController getUserInfoDefault];
    //    NSMutableDictionary *parametersDic = [[NSMutableDictionary alloc]init];
    //    [parametersDic setValue:[self.resultArr JSONString] forKey:@"resultJson"];
    //    [parametersDic setValue:userObj.idcode forKey:@"Userid"];
    //    [parametersDic setValue:self.zcdcObj.idcode forKey:@"DiaochaBiaoId"];
    //    [parametersDic setValue:@"0" forKey:@"userType"];
    //    [parametersDic setValue:@"stCont" forKey:@"stCont"];//文字内容
    //    NSLog(@"%@",parametersDic);
    //    [HttpRequestService httpForGetData:kSubmitZcdcResults parameter:parametersDic start:^{
    //        [PublicObject showHUDBegain:self.view title:@"正在提交……"];
    //    } success:^(NSDictionary *successDictionary) {
    //        [PublicObject dissMissHUDEnd];
    //        NSLog(@"%@",successDictionary);
    //        NSDictionary *result = successDictionary;
    //        int status = [[result objectForKey:@"status"] intValue];
    //        NSString *msg = [PublicObject convertNullString:[result objectForKey:@"msg"]];
    //        if (status == 0) {
    //            [PublicObject showHUDView:self.view title:@"提交成功" content:@"" time:kHUDTime andCodes:^{
    //                [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    //            }];
    //        } else {
    //            [PublicObject showHUDView:self.view title:msg content:@"" time:kHUDTime andCodes:^{
    //            }];
    //        }
    //    } failed:^(NSError *err) {
    //        [PublicObject dissMissHUDEnd];
    //        [PublicObject showHUDView:self.view title:@"失败" content:@"" time:kHUDTime andCodes:^{
    //        }];
    //
    //    }];
}


@end
