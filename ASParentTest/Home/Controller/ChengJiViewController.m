//
//  ChengJiViewController.m
//  ASParentTest
//
//  Created by 周德艺 on 15/11/20.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "ChengJiViewController.h"
#import "ChengJiViewCell.h"
#import "ScoreObject.h"
#import "ScoreHeaderView.h"
#import "ScroreTableViewCell.h"
//接口
#import "DYRequestBase+GetScoreRequest.h"
@interface ChengJiViewController ()

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ChengJiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.title = @"成绩查询";
    [self.view addSubview:self.tableView];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    self.name = @"";
    self.sex = @"";
    self.school = @"";
    self.dataArr = [[NSMutableArray alloc]init];
}

#pragma mark - tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    else{
        return self.dataArr.count/2;
    }
}
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    if (section == 0) {
//        return 20;
//    }else{
//        return 0.1;
//    }
//}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 8;
    }else{
        return 44;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        //获得nib视图数组
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ScoreHeaderView" owner:self options:nil];
        //得到第一个UIView
        ScoreHeaderView *headView = [nib objectAtIndex:0];
        //添加视图
        headView.nameLab.text = [NSString stringWithFormat:@"姓名:%@",self.name];
        headView.sexLab.text = [NSString stringWithFormat:@"性别:%@",self.sex];
        headView.schoolLab.text = [NSString stringWithFormat:@"毕业学校:%@",self.school];
        headView.nameLab.textColor = MainColor;
        headView.sexLab.textColor = MainColor;
        headView.schoolLab.textColor = MainColor;
        return headView;
    }
    else{
        return nil;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *cellIdentifier = @"ChengJiViewCell";
        ChengJiViewCell *cell = (ChengJiViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            NSBundle *bundle = [NSBundle mainBundle];
            NSArray *nibArray = [bundle loadNibNamed:cellIdentifier owner:nil options:nil];
            cell = (ChengJiViewCell *)[nibArray objectAtIndex:0];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        cell.delegate = self;
        return cell;
    }
    else{
        static NSString *cellIdentifier = @"ScroreTableViewCell";
        ScroreTableViewCell *cell = (ScroreTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            NSBundle *bundle = [NSBundle mainBundle];
            NSArray *nibArray = [bundle loadNibNamed:cellIdentifier owner:nil options:nil];
            cell = (ScroreTableViewCell *)[nibArray objectAtIndex:0];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        //样式
        cell.firstBackView.backgroundColor = [UIColor whiteColor];
        cell.lastBackView.backgroundColor = [UIColor whiteColor];
        cell.firstPointImg.backgroundColor = MainColor;
        cell.lastPointImg.backgroundColor = MainColor;
        cell.firstPointImg.layer.masksToBounds = YES;
        cell.firstPointImg.layer.cornerRadius = cell.firstPointImg.frame.size.height/2;
        cell.lastPointImg.layer.masksToBounds = YES;
        cell.lastPointImg.layer.cornerRadius = cell.lastPointImg.frame.size.height/2;
        
        //数据
        int firstIndex = (int)indexPath.row * 2;
        int lastIndex = firstIndex + 1;
        ScoreObject *firstScoreObj = [self.dataArr objectAtIndex:firstIndex];
        ScoreObject *lastScoreObj = [self.dataArr objectAtIndex:lastIndex];

        cell.firstLab.text = [NSString stringWithFormat:@"%@%@",firstScoreObj.subjectName,firstScoreObj.subjectScore];
        cell.lastLab.text = [NSString stringWithFormat:@"%@%@",lastScoreObj.subjectName,lastScoreObj.subjectScore];
        
        return cell;
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark - getter and setter

-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView setTableFooterView:[[UIView alloc]init]];
        //[_tableView setSeparatorColor:[UIColor clearColor]];
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 100;
        
    }
    return _tableView;
}
#pragma  mark - delegate
-(void)submitClick:(NSString *)name andCensus:(NSString *)census andTicket:(NSString *)ticket{
    NSString *nameEn = [name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableDictionary *parametersDic = [[NSMutableDictionary alloc]init];
    [parametersDic setValue:ticket forKey:@"ticket"];
    [parametersDic setValue:census forKey:@"studentCensus"];
    [parametersDic setValue:nameEn forKey:@"stuName"];
    [DYRequestBase GetScoreByName:nameEn XuejiNum:census ZhunkaozhengNum:ticket requestStartBlock:^{
        [PublicObject showHUDBegain:self.view title:@"正在获取……"];
    } responseBlock:^(id dataObj, NSError *error) {
        [PublicObject dissMissHUDEnd];
        if (dataObj) {
            int status = [[dataObj objectForKey:@"status"] intValue];
            NSString *msg = [PublicObject convertNullString:[dataObj objectForKey:@"msg"]];
            if (status == 0) {
                NSDictionary *objDic = [dataObj objectForKey:@"obj"];
                self.name = [PublicObject convertNullString:[objDic objectForKey:@"stuname"]];
                self.sex = [PublicObject convertNullString:[objDic objectForKey:@"studentsex"]];
                self.school = [PublicObject convertNullString:[objDic objectForKey:@"schoolname"]];
                NSDictionary *dic = [objDic objectForKey:@"score"];
                NSLog(@"%@",dic);
                //解析封装数据
                [self packageData:dic];
                [_tableView reloadData];
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
-(void)packageData:(NSDictionary *)dic{
    //生物等级
    NSString *swScore = [PublicObject convertNullString:[dic objectForKey:@"sw"]];
    NSString *swName = @"生物等级:";
    NSDictionary *swDic = [[NSDictionary alloc]initWithObjectsAndKeys:swName,@"subjectName",swScore,@"subjectScore", nil];
    //json转对象
    ScoreObject *swObj = [ScoreObject mj_objectWithKeyValues:swDic];
    [self.dataArr addObject:swObj];
    //地理等级
    NSString *dlScore = [PublicObject convertNullString:[dic objectForKey:@"dl"]];
    NSString *dlName = @"地理等级:";
    NSDictionary *dlDic = [[NSDictionary alloc]initWithObjectsAndKeys:dlName,@"subjectName",dlScore,@"subjectScore", nil];
    //json转对象
    ScoreObject *dlObj = [ScoreObject mj_objectWithKeyValues:dlDic];
    [self.dataArr addObject:dlObj];
    //生物实验
    NSString *swsyScore = [PublicObject convertNullString:[dic objectForKey:@"swsy"]];
    NSString *swsyName = @"生物实验:";
    NSDictionary *swsyDic = [[NSDictionary alloc]initWithObjectsAndKeys:swsyName,@"subjectName",swsyScore,@"subjectScore", nil];
    //json转对象
    ScoreObject *swsyObj = [ScoreObject mj_objectWithKeyValues:swsyDic];
    [self.dataArr addObject:swsyObj];
    //理化实验
    NSString *lhsyScore = [PublicObject convertNullString:[dic objectForKey:@"lhsy"]];
    NSString *lhsyName = @"理化试验:";
    NSDictionary *lhsyDic = [[NSDictionary alloc]initWithObjectsAndKeys:lhsyName,@"subjectName",lhsyScore,@"subjectScore", nil];
    //json转对象
    ScoreObject *lhsyObj = [ScoreObject mj_objectWithKeyValues:lhsyDic];
    [self.dataArr addObject:lhsyObj];
    // 信息技术
    NSString *xxjsScore = [PublicObject convertNullString:[dic objectForKey:@"xxjs"]];
    NSString *xxjsName = @"信息技术:";
    NSDictionary *xxjsDic = [[NSDictionary alloc]initWithObjectsAndKeys:xxjsName,@"subjectName",xxjsScore,@"subjectScore", nil];
    //json转对象
    ScoreObject *xxjsObj = [ScoreObject mj_objectWithKeyValues:xxjsDic];
    [self.dataArr addObject:xxjsObj];
    //基础等级
    NSString *jcdjScore = [PublicObject convertNullString:[dic objectForKey:@"jcdj"]];
    NSString *jcdjName = @"基础等级:";
    NSDictionary *jcdjDic = [[NSDictionary alloc]initWithObjectsAndKeys:jcdjName,@"subjectName",jcdjScore,@"subjectScore", nil];
    //json转对象
    ScoreObject *jcdjObj = [ScoreObject mj_objectWithKeyValues:jcdjDic];
    [self.dataArr addObject:jcdjObj];
    //日常等级
    NSString *rcdjScore = [PublicObject convertNullString:[dic objectForKey:@"rcdj"]];
    NSString *rcdjName = @"日常等级:";
    NSDictionary *rcdjDic = [[NSDictionary alloc]initWithObjectsAndKeys:rcdjName,@"subjectName",rcdjScore,@"subjectScore", nil];
    //json转对象
    ScoreObject *rcdjObj = [ScoreObject mj_objectWithKeyValues:rcdjDic];
    [self.dataArr addObject:rcdjObj];
    //语文
    NSNumber *ywScore = [PublicObject convertNullNumber:[dic objectForKey:@"yw"]];
    NSString *ywName = @"语文:";
    NSDictionary *ywDic = [[NSDictionary alloc]initWithObjectsAndKeys:ywName,@"subjectName",ywScore,@"subjectScore", nil];
    //json转对象
    ScoreObject *ywObj = [ScoreObject mj_objectWithKeyValues:ywDic];
    [self.dataArr addObject:ywObj];
    //数学
    NSNumber *sxScore = [PublicObject convertNullNumber:[dic objectForKey:@"sx"]];
    NSString *sxName = @"数学:";
    NSDictionary *sxDic = [[NSDictionary alloc]initWithObjectsAndKeys:sxName,@"subjectName",sxScore,@"subjectScore", nil];
    //json转对象
    ScoreObject *sxObj = [ScoreObject mj_objectWithKeyValues:sxDic];
    [self.dataArr addObject:sxObj];
    //外语
    NSNumber *wyScore = [PublicObject convertNullNumber:[dic objectForKey:@"wy"]];
    NSString *wyName = @"外语:";
    NSDictionary *wyDic = [[NSDictionary alloc]initWithObjectsAndKeys:wyName,@"subjectName",wyScore,@"subjectScore", nil];
    //json转对象
    ScoreObject *wyObj = [ScoreObject mj_objectWithKeyValues:wyDic];
    [self.dataArr addObject:wyObj];
    //物理
    NSNumber *wlScore = [PublicObject convertNullNumber:[dic objectForKey:@"wl"]];
    NSString *wlName = @"物理:";
    NSDictionary *wlDic = [[NSDictionary alloc]initWithObjectsAndKeys:wlName,@"subjectName",wlScore,@"subjectScore", nil];
    //json转对象
    ScoreObject *wlObj = [ScoreObject mj_objectWithKeyValues:wlDic];
    [self.dataArr addObject:wlObj];
    //化学
    NSNumber *hxScore = [PublicObject convertNullNumber:[dic objectForKey:@"hx"]];
    NSString *hxName = @"化学:";
    NSDictionary *hxDic = [[NSDictionary alloc]initWithObjectsAndKeys:hxName,@"subjectName",hxScore,@"subjectScore", nil];
    //json转对象
    ScoreObject *hxObj = [ScoreObject mj_objectWithKeyValues:hxDic];
    [self.dataArr addObject:hxObj];
    //体育分
    NSNumber *tyfScore = [PublicObject convertNullNumber:[dic objectForKey:@"tyf"]];
    NSString *tyfName = @"体育分:";
    NSDictionary *tyfDic = [[NSDictionary alloc]initWithObjectsAndKeys:tyfName,@"subjectName",tyfScore,@"subjectScore", nil];
    //json转对象
    ScoreObject *tyfObj = [ScoreObject mj_objectWithKeyValues:tyfDic];
    [self.dataArr addObject:tyfObj];
    //特殊加分
    NSNumber *tjfScore = [PublicObject convertNullNumber:[dic objectForKey:@"tjf"]];
    NSString *tjfName = @"特殊加分:";
    NSDictionary *tjfDic = [[NSDictionary alloc]initWithObjectsAndKeys:tjfName,@"subjectName",tjfScore,@"subjectScore", nil];
    //json转对象
    ScoreObject *tjfObj = [ScoreObject mj_objectWithKeyValues:tjfDic];
    [self.dataArr addObject:tjfObj];
    //思品等级
    NSString *zzdjScore = [PublicObject convertNullString:[dic objectForKey:@"zzdj"]];
    NSString *zzdjName = @"思品等级:";
    NSDictionary *zzdjDic = [[NSDictionary alloc]initWithObjectsAndKeys:zzdjName,@"subjectName",zzdjScore,@"subjectScore", nil];
    //json转对象
    ScoreObject *zzdjObj = [ScoreObject mj_objectWithKeyValues:zzdjDic];
    [self.dataArr addObject:zzdjObj];
    //历史等级
    NSString *lsdjScore = [PublicObject convertNullString:[dic objectForKey:@"lsdj"]];
    NSString *lsdjName = @"历史等级:";
    NSDictionary *lsdjDic = [[NSDictionary alloc]initWithObjectsAndKeys:lsdjName,@"subjectName",lsdjScore,@"subjectScore", nil];
    //json转对象
    ScoreObject *lsdjObj = [ScoreObject mj_objectWithKeyValues:lsdjDic];
    [self.dataArr addObject:lsdjObj];
    
    
    
    //作弊记号
    NSString *zbjhScore = [PublicObject convertNullString:[dic objectForKey:@"zbjh"]];
    NSString *zbjhName = @"作弊记号:";
    NSDictionary *zbjhDic = [[NSDictionary alloc]initWithObjectsAndKeys:zbjhName,@"subjectName",zbjhScore,@"subjectScore", nil];
    //json转对象
    ScoreObject *zbjhObj = [ScoreObject mj_objectWithKeyValues:zbjhDic];
    [self.dataArr addObject:zbjhObj];
    //总分
    NSNumber *zfScore = [PublicObject convertNullNumber:[dic objectForKey:@"zf"]];
    NSString *zfName = @"总分:";
    NSDictionary *zfDic = [[NSDictionary alloc]initWithObjectsAndKeys:zfName,@"subjectName",zfScore,@"subjectScore", nil];
    //json转对象
    ScoreObject *zfObj = [ScoreObject mj_objectWithKeyValues:zfDic];
    [self.dataArr addObject:zfObj];
}
@end
