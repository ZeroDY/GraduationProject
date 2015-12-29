//
//  LeaveDetailViewController.m
//  ASParentTest
//
//  Created by 张浩 on 15/11/21.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "LeaveDetailViewController.h"
//接口
#import "DYRequestBase+AddLeaveReport.h"
@interface LeaveDetailViewController ()

@end

@implementation LeaveDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"请假申请";
    
    self.pickBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.pickBgView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.pickBgView];
    //创建普通pick
    self.normalPickView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 200-60, SCREEN_WIDTH, 200)];
    self.normalPickView.backgroundColor = [UIColor whiteColor];
    self.normalPickView.dataSource = self;
    self.normalPickView.delegate = self;
    [self.normalPickView selectRow:0 inComponent:0 animated:YES];
    [self.pickBgView addSubview:self.normalPickView];
    //创建时间pick
    self.datePickView = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 200-60, SCREEN_WIDTH, 200)];
    self.datePickView.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    self.datePickView.datePickerMode = UIDatePickerModeDate;
    self.datePickView.backgroundColor = [UIColor whiteColor];
    [self.pickBgView addSubview:self.datePickView];
    
    [self setUpToolBar];
    
    self.normalPickView.hidden = YES;
    self.datePickView.hidden = YES;
    self.pickBgView.hidden = YES;
}
-(void)viewWillAppear:(BOOL)animated{
    
    NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:@"病假",@"name",@"0",@"typeIndex", nil];
    NSDictionary *dic1 = [[NSDictionary alloc]initWithObjectsAndKeys:@"事假",@"name",@"1",@"typeIndex", nil];
    self.typeArr = [[NSMutableArray alloc]initWithObjects:dic,dic1, nil];
    self.HourArr = [[NSMutableArray alloc]init];
    self.MinituesArr = [[NSMutableArray alloc]init];
    //构建hourArr
    for (int i = 0; i < 24; i++) {
        NSString *hour = @"";
        if (i < 10) {
            hour = [NSString stringWithFormat:@"0%d",i];
        }else{
            hour = [NSString stringWithFormat:@"%d",i];
        }
        [self.HourArr addObject:hour];
    }
    //构建minituesArr
    for (int i = 0; i < 60; i++) {
        NSString *minitues = @"";
        if (i < 10) {
            minitues = [NSString stringWithFormat:@"0%d",i];
        }else{
            minitues = [NSString stringWithFormat:@"%d",i];
        }
        [self.MinituesArr addObject:minitues];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)typeClick:(id)sender {
    self.normalPickView.hidden = NO;
    self.datePickView.hidden = YES;
    self.pickBgView.hidden = NO;
    self.pickType = 0;
    [self.normalPickView reloadAllComponents];
}

- (IBAction)startTimeYearMonthClick:(id)sender {
    self.normalPickView.hidden = YES;
    self.datePickView.hidden = NO;
    self.pickBgView.hidden = NO;
    self.pickType = 2;
    self.datePickView.tag = 0;
}
- (IBAction)startTimeHourMinituesClick:(id)sender {
    self.normalPickView.hidden = NO;
    self.datePickView.hidden = YES;
    self.pickBgView.hidden = NO;
    self.pickType = 1;
    self.normalPickView.tag = 0;
    [self.normalPickView reloadAllComponents];
}
- (IBAction)endTimeYearMonthClick:(id)sender {
    self.normalPickView.hidden = YES;
    self.datePickView.hidden = NO;
    self.pickBgView.hidden = NO;
    self.pickType = 2;
    self.datePickView.tag = 1;
}
- (IBAction)endTimeHourMiniutesClick:(id)sender {
    self.normalPickView.hidden = NO;
    self.datePickView.hidden = YES;
    self.pickBgView.hidden = NO;
    self.pickType = 1;
    self.normalPickView.tag = 1;
    [self.normalPickView reloadAllComponents];
}
- (IBAction)submitClick:(id)sender {
    NSLog(@"%@",self.typeStr);
    NSLog(@"%@",self.startTimeYearMonthStr);
    NSLog(@"%@",self.startTimeHourMiniutesStr);
    NSLog(@"%@",self.endTimeYearMonthStr);
    NSLog(@"%@",self.endTimeHourMiniutesStr);
    NSString *startTime = [NSString stringWithFormat:@"%@ %@:00",self.startTimeYearMonthStr,self.startTimeHourMiniutesStr];
    NSString *endTime = [NSString stringWithFormat:@"%@ %@:00",self.endTimeYearMonthStr,self.endTimeHourMiniutesStr];
    //中文转码
    NSString *reason = [self.reasonTextView.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableDictionary *parametersDic = [[NSMutableDictionary alloc]init];
    [parametersDic setValue:self.stuObj.schoolcensus forKey:@"census"];
    [parametersDic setValue:self.typeStr forKey:@"style"];
    [parametersDic setValue:startTime forKey:@"firsttime"];
    [parametersDic setValue:endTime forKey:@"lasttime"];
    [parametersDic setValue:reason forKey:@"reason"];
    [parametersDic setValue:@"beizhu" forKey:@"beizhu"];
    [DYRequestBase AddLeaveReportByXuejiNum:self.stuObj.schoolcensus LeaveType:self.typeStr StartTime:startTime FinishTime:endTime LeaveReason:reason leaveRemark:@"leaveRemark is null" requestStartBlock:^{
        [PublicObject showHUDBegain:self.view title:@"正在提交……"];
    } responseBlock:^(id dataObj, NSError *error) {
        [PublicObject dissMissHUDEnd];
        if (dataObj) {
            int status = [[dataObj objectForKey:@"status"] intValue];
            NSString *msg = [PublicObject convertNullString:[dataObj objectForKey:@"msg"]];
            if (status == 0) {
                [PublicObject showHUDView:self.view title:@"申请成功" content:@"" time:kHUDTime andCodes:^{
                    [self.navigationController popViewControllerAnimated:YES];
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
#pragma mark ToolBar
- (void)setUpToolBar {
    self.toolbar = [self setToolbarStyle];
    [self.pickBgView addSubview:self.toolbar];
}
- (UIToolbar *)setToolbarStyle {
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    toolbar.frame = CGRectMake(0, SCREEN_HEIGHT-200-100 ,SCREEN_WIDTH, 40);
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelSelected)];
    leftItem.tintColor = [UIColor whiteColor];
    UIBarButtonItem *centerSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(selectdRow)];
    rightItem.tintColor = [UIColor whiteColor];
    
    toolbar.items = @[leftItem,centerSpace,rightItem];
    toolbar.backgroundColor = MainColor;
    return toolbar;
}
- (void)selectdRow {
    self.pickBgView.hidden = YES;
    
    if (self.pickType == 0) {//类型
        self.pickOneIndex = [self.normalPickView selectedRowInComponent:0];
        NSDictionary *dic = [self.typeArr objectAtIndex:self.pickOneIndex];
        self.typeStr = [dic objectForKey:@"typeIndex"];
        //显示
        [self.typeBtn setTitle:[dic objectForKey:@"name"] forState:UIControlStateNormal];
    }else if(self.pickType == 1){//时分
        if (self.normalPickView.tag == 0) {//开始时间的分秒
            self.pickOneIndex = [self.normalPickView selectedRowInComponent:0];
            self.pickTwoIndex = [self.normalPickView selectedRowInComponent:1];
            
            NSString *hourStr = [self.HourArr objectAtIndex:self.pickOneIndex];
            NSString *miniutesStr = [self.MinituesArr objectAtIndex:self.pickTwoIndex];
            self.startTimeHourMiniutesStr = [NSString stringWithFormat:@"%@:%@",hourStr,miniutesStr];
            //显示
            [self.startTimeHourMiniutesBtn setTitle:self.startTimeHourMiniutesStr forState:UIControlStateNormal];
        }else{//结束时间的分秒
            self.pickOneIndex = [self.normalPickView selectedRowInComponent:0];
            self.pickTwoIndex = [self.normalPickView selectedRowInComponent:1];
            
            NSString *hourStr = [self.HourArr objectAtIndex:self.pickOneIndex];
            NSString *miniutesStr = [self.MinituesArr objectAtIndex:self.pickTwoIndex];
            self.endTimeHourMiniutesStr = [NSString stringWithFormat:@"%@:%@",hourStr,miniutesStr];
            //显示
            [self.endTimeHourMiniutesMonthBtn setTitle:self.endTimeHourMiniutesStr forState:UIControlStateNormal];
        }
    }else{//年月日
        if (self.datePickView.tag == 0) {//开始时间的年月日
            self.startTimeYearMonthStr = [[NSString stringWithFormat:@"%@",self.datePickView.date] substringWithRange:NSMakeRange(0, 10)];
            //显示
            [self.startTimeYearMonthBtn setTitle:self.startTimeYearMonthStr forState:UIControlStateNormal];
        }else{//结束时间的年月日
            self.endTimeYearMonthStr = [[NSString stringWithFormat:@"%@",self.datePickView.date] substringWithRange:NSMakeRange(0, 10)];
            //显示
            [self.endTimeStartYearMonthBtn setTitle:self.endTimeYearMonthStr forState:UIControlStateNormal];
        }
    }
    
}
- (void)cancelSelected {
    self.pickBgView.hidden = YES;
}
#pragma UIPickerViewDataSource
// UIPickerViewDataSource中定义的方法，该方法的返回值决定该控件包含多少列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView
{
    if (self.pickType == 0) {//类型
        return 1;
    }else if(self.pickType == 1){//时分
        return 2;
    }else{
        return 0;
    }
}
// UIPickerViewDataSource中定义的方法，该方法的返回值决定该控件指定列包含多少个列表项
- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    if (self.pickType == 0) {//类型
        return self.typeArr.count;
    }else if(self.pickType == 1){//时分
        if(component == 0){
            return self.HourArr.count;
        }else{
            return self.MinituesArr.count;
        }
    }else{
        return 0;
    }
}
// UIPickerViewDelegate中定义的方法，该方法返回的NSString将作为UIPickerView
// 中指定列和列表项的标题文本
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    // 由于该控件只包含一列，因此无须理会列序号参数component
    // 该方法根据row参数返回books中的元素，row参数代表列表项的编号，
    // 因此该方法表示第几个列表项，就使用books中的第几个元素
    if (self.pickType == 0) {
        NSDictionary *dic = [self.typeArr objectAtIndex:row];
        return [dic objectForKey:@"name"];
    }else if (self.pickType == 1){//时分
        if(component == 0){
            return [self.HourArr objectAtIndex:row];
        }else{
            return [self.MinituesArr objectAtIndex:row];
        }
    }
    else{
        return nil;
    }
}
//重写样式
//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
//    CFShow((__bridge CFTypeRef)(view));
//    UILabel *pickerLabel = view ? (UILabel *) view : [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, 25.0f)];
//    NSString *str= @"";
//    if (self.pickType == 0) {
//        NSDictionary *dic = [self.typeArr objectAtIndex:row];
//        str =  [dic objectForKey:@"name"];
//    }else if (self.pickType == 1){//时分
//        if(component == 0){
//            str =  [self.HourArr objectAtIndex:row];
//        }else{
//            str =  [self.MinituesArr objectAtIndex:row];
//        }
//    }
//    pickerLabel.text = str;
//    [pickerLabel setTextAlignment:NSTextAlignmentCenter];
//    [pickerLabel setFont:[UIFont systemFontOfSize:16]];
//    [pickerLabel setTextColor:MainColor];
//    pickerLabel.backgroundColor = [UIColor clearColor];
//    return pickerLabel;
//}

@end
