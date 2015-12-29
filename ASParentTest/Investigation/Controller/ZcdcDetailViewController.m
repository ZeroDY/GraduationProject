//
//  ZcdcDetailViewController.m
//  ASParentTest
//
//  Created by 张浩 on 15/11/20.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "ZcdcDetailViewController.h"
#import "ZcdcQuestionObject.h"
#import "ZcdcDetailHeaderView.h"
#import "ZcdcDetailTableViewCell.h"
//接口
#import "DYRequestBase+GetZcdcDetail.h"
#import "DYRequestBase+SubmitZcdcResults.h"
@interface ZcdcDetailViewController ()

@end

@implementation ZcdcDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"调查问卷";
    
    self.titleBackView.backgroundColor = [UIColor whiteColor];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.bottomBackView.backgroundColor = [UIColor whiteColor];
    self.lastQuestionBtn.backgroundColor = MainColor;
    self.nextQuestionBtn.backgroundColor = MainColor;
    self.titleLab.textColor = RGB(240, 100, 20, 1);
    self.infoLab.textColor = [UIColor darkGrayColor];
    
    NSLog(@"%@",self.zcdcObj);
    self.titleLab.text = self.zcdcObj.sheader;
    self.infoLab.text = [NSString stringWithFormat:@"您好,这是一份关于%@的调查问卷,希望能占用您两分钟的时间来完成这份问卷,非常感谢!",self.zcdcObj.jianjie];
    
    //默认当前问题
    self.questionIndex = 0;
    //初始化隐藏上一题
    self.lastQuestionBtn.hidden = YES;
    
    //tableView样式
    self.tableView.tableFooterView = [[UIView alloc]init];
    
}
-(void)viewWillAppear:(BOOL)animated{
    self.dataArr = [[NSMutableArray alloc]init];
    self.resultArr = [[NSMutableArray alloc]init];
    [self getZcdcDeatil];
}
-(void)getZcdcDeatil{
    NSMutableDictionary *parametersDic = [[NSMutableDictionary alloc]init];
    
    [DYRequestBase GetZcdcDetailByWenJuanId:self.zcdcObj.idcode requestStartBlock:^{
        [PublicObject showHUDBegain:self.view title:@"正在获取……"];
    } responseBlock:^(id dataObj, NSError *error) {
        [PublicObject dissMissHUDEnd];
        if (dataObj) {
            int status = [[dataObj objectForKey:@"status"] intValue];
            NSString *msg = [PublicObject convertNullString:[dataObj objectForKey:@"msg"]];
            if (status == 0) {
                NSArray *objArr = [dataObj objectForKey:@"list"];
                NSLog(@"%@",objArr);
                //json转对象
                for (int i = 0; i < objArr.count; i++) {
                    NSDictionary *dic = [objArr objectAtIndex:i];
                    ZcdcQuestionObject *zcdcQuestionObj = [ZcdcQuestionObject mj_objectWithKeyValues:dic];
                    zcdcQuestionObj.xuanxiang = [ZcdcOptionalObject mj_objectArrayWithKeyValuesArray:zcdcQuestionObj.xuanxiang];
                    [self.dataArr addObject:zcdcQuestionObj];
                }
                NSLog(@"%@",self.dataArr);
                [self.tableView reloadData];
                [self refreshBottomView];
            } else {
                [PublicObject showHUDView:self.view title:msg content:@"" time:kHUDTime andCodes:^{
                }];
            }
            
        }else{
            [PublicObject showHUDView:self.view title:@"请求失败" content:@"" time:kHUDTime andCodes:^{
            }];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.dataArr.count) {
        ZcdcQuestionObject *zcdcQuestionObj = [self.dataArr objectAtIndex:self.questionIndex];
        return zcdcQuestionObj.xuanxiang.count;
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
        ZcdcQuestionObject *zcdcQuestionObj = [self.dataArr objectAtIndex:self.questionIndex];
        NSString *str = [NSString stringWithFormat:@"%d.%@",self.questionIndex+1,zcdcQuestionObj.scontent];
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
        ZcdcQuestionObject *zcdcQuestionObj = [self.dataArr objectAtIndex:self.questionIndex];
        NSString *str = [NSString stringWithFormat:@"%d.%@",self.questionIndex,zcdcQuestionObj.scontent];
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
        
        ZcdcQuestionObject *zcdcQuestionObj = [self.dataArr objectAtIndex:self.questionIndex];
        ZcdcOptionalObject *zcdcOptionalObj = [zcdcQuestionObj.xuanxiang objectAtIndex:indexPath.row];
        
        NSString *str = [NSString stringWithFormat:@"%@.%@",zcdcOptionalObj.sheader,zcdcOptionalObj.scontent];
        if ([zcdcOptionalObj.isshow intValue] == 1) {//1 为 未选中状态 0 为选中状态
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
        ZcdcQuestionObject *zcdcQuestionObj = [self.dataArr objectAtIndex:self.questionIndex];
        ZcdcOptionalObject *zcdcOptionalObj = [zcdcQuestionObj.xuanxiang objectAtIndex:indexPath.row];
        
        NSLog(@"%ld",(long)indexPath.row);
        NSLog(@"%@",zcdcOptionalObj.sheader);
        NSLog(@"%@",zcdcOptionalObj.scontent);
        
        NSString *str = [NSString stringWithFormat:@"%@.%@",zcdcOptionalObj.sheader,zcdcOptionalObj.scontent];
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
        ZcdcQuestionObject *zcdcQuestionObj = [self.dataArr objectAtIndex:self.questionIndex];
        ZcdcOptionalObject *zcdcOptionalObj = [zcdcQuestionObj.xuanxiang objectAtIndex:backView.tag];
        
        NSString *answerStr = @"";//存放 选中的选项idcode
        //单选
        if ([zcdcQuestionObj.xuanxiangtype isEqualToString:@"0"]) {
            //把所有选项变为未选中状态
            for (int i = 0; i < zcdcQuestionObj.xuanxiang.count; i++) {
                ZcdcOptionalObject *zcdcOptionalObj = [zcdcQuestionObj.xuanxiang objectAtIndex:i];
                zcdcOptionalObj.isshow = [NSNumber numberWithInt:1];
            }
            //把点击的选项变为选中状态
            zcdcOptionalObj.isshow = [NSNumber numberWithInt:0];
            //把选项idcode添加到answerStr中
            answerStr = zcdcOptionalObj.idcode;
        }else{//多选
            if (zcdcOptionalObj.isshow == 0) {//选中 变 未选中
                zcdcOptionalObj.isshow = [NSNumber numberWithInt:1];
            }else{//未选中 变 选中
                zcdcOptionalObj.isshow = [NSNumber numberWithInt:0];
            }
            //遍历所有选项，把选中的选项idcode添加到answerStr中
            for (int i = 0; i < zcdcQuestionObj.xuanxiang.count; i++) {
                if (zcdcOptionalObj.isshow == 0) {
                    if (answerStr.length == 0) {
                        answerStr = [answerStr stringByAppendingString:zcdcOptionalObj.idcode];
                    }else{
                        answerStr = [answerStr stringByAppendingString:@","];
                        answerStr = [answerStr stringByAppendingString:zcdcOptionalObj.idcode];
                    }
                }
            }
        }
        NSLog(@"%@",answerStr);
        //遍历resultArr，看看是已存在该问题，若存在，则用户的操作是修改答案；若不存在，则直接添加
        BOOL isExist;
        NSLog(@"%@",self.resultArr);
        for (int i = 0; i < self.resultArr.count; i++) {
            NSMutableDictionary *dic = [self.resultArr objectAtIndex:i];
            NSString *questionId = [dic objectForKey:@"question"];
            if ([zcdcQuestionObj.idcode isEqualToString:questionId]) {
                isExist = YES;
                [dic setValue:answerStr forKey:@"answer"];
                break;
            }
        }
        if (!isExist) {
            NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithObjectsAndKeys:zcdcQuestionObj.idcode,@"question",zcdcOptionalObj.idcode,@"answer",@"stcont is null",@"stcont", nil];
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
    UIButton *btn = (UIButton *)sender;
    if (self.questionIndex == self.dataArr.count-1) {
        self.questionIndex = (int)self.dataArr.count-1;
    }else{
        self.questionIndex++;
    }
    //刷新bottomBtn
    [self refreshBottomView];
    if([btn.titleLabel.text isEqualToString:@"提交问卷"]){
        [self submitResults];
        
    }else{
        //刷新数据
        [self.tableView reloadData];
    }
    //    }else{//提交问卷
    //        [self submitResults];
    //    }
    
}
-(void)submitResults{
    AccoutObject *userObj = [PublicObject getUserInfoDefault];
    NSLog(@"%@",[self.resultArr JSONString]);
    [DYRequestBase SubmitZcdcResultsByResultJson:[self.resultArr JSONString] UserId:userObj.idcode DiaoChaBiaoId:self.zcdcObj.idcode UserType:@"0" requestStartBlock:^{
        [PublicObject showHUDBegain:self.view title:@"正在提交……"];
    } responseBlock:^(id dataObj, NSError *error) {
        [PublicObject dissMissHUDEnd];
        if (dataObj) {
            int status = [[dataObj objectForKey:@"status"] intValue];
            NSString *msg = [PublicObject convertNullString:[dataObj objectForKey:@"msg"]];
            if (status == 0) {
                [PublicObject showHUDView:self.view title:@"提交成功" content:@"" time:kHUDTime andCodes:^{
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }];
            } else {
                [PublicObject showHUDView:self.view title:msg content:@"" time:kHUDTime andCodes:^{
                }];
            }
        }else{
            [PublicObject showHUDView:self.view title:@"请求失败" content:@"" time:kHUDTime andCodes:^{
            }];
        }
    }];
}
@end
