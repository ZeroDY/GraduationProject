//
//  AddJyxcViewController.m
//  ASParentTest
//
//  Created by 张浩 on 15/11/20.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "AddJyxcViewController.h"
//接口
#import "DYRequestBase+GetJyxcAllObjectById.h"
@interface AddJyxcViewController ()

@end

@implementation AddJyxcViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"新建建言";
    //导航栏右侧按钮
    UIButton* rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,60,30)];
    [rightButton setTitle:@"发布" forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize: 14];
    [rightButton addTarget:self action:@selector(presentRightVC) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem= rightItem;
}
-(void)presentRightVC{
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
//    [self getJyxcObj];
    
    self.componentTypeArr = [[NSMutableArray alloc]initWithObjects:@"教育局",@"学校",@"老师", nil];
    NSArray *jyjArr = [[NSArray alloc]init];
    NSArray *xxArr = [[NSArray alloc]init];
    NSArray *teacherArr = [[NSArray alloc]initWithObjects:@"刘正刚",@"曹文",@"段东",@"胡歌",@"韩玉华",@"李冬冬",@"周医德", nil];
    self.componentInfoDic = [[NSMutableDictionary alloc]initWithObjectsAndKeys:jyjArr,@"教育局",xxArr,@"学校",teacherArr,@"老师", nil];
}
//- (void)getJyxcObj{
//    AccoutObject *userObj = [PublicObject getUserInfoDefault];
//    [DYRequestBase getJyxcAllObjectById:userObj.idcode requestStartBlock:^{
//        [PublicObject showHUDBegain:self.view title:@"正在获取……"];
//    } responseBlock:^(id dataObj, NSError *error) {
//        [PublicObject dissMissHUDEnd];
//        if (dataObj) {
//            int status = [[dataObj objectForKey:@"status"] intValue];
//            NSString *msg = [PublicObject convertNullString:[dataObj objectForKey:@"msg"]];
//            if (status == 0) {
//                NSLog(@"%@",dataObj);
//                NSArray *objArr = [dataObj objectForKey:@"obj"];
//                NSLog(@"%@",objArr);
//                NSDictionary *objDic = [objArr objectAtIndex:0];
//            } else {
//                [PublicObject showHUDView:self.view title:msg content:@"" time:kHUDTime andCodes:^{
//                }];
//            }
//        }else{
//            [PublicObject showHUDView:self.view title:@"请求失败" content:@"" time:kHUDTime andCodes:^{
//            }];
//        }
//    }];
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)objBtnClick:(id)sender {
    self.pickBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.pickBgView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.pickBgView];
    self.pickView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 200-60, SCREEN_WIDTH, 200)];
    self.pickView.backgroundColor = [UIColor lightGrayColor];
    self.pickView.dataSource = self;
    self.pickView.delegate = self;
    [self.pickBgView addSubview:self.pickView];
    [self.pickView selectRow:0 inComponent:0 animated:YES];
    [self setUpToolBar];
    
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
    UIBarButtonItem *centerSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(selectdRow)];
    toolbar.items = @[leftItem,centerSpace,rightItem];
    return toolbar;
}
- (void)selectdRow {
    self.pickBgView.hidden = YES;
    [self.toolbar removeFromSuperview];
    
    self.pickOneIndex = [self.pickView selectedRowInComponent:0];
    self.pickTwoIndex = [self.pickView selectedRowInComponent:1];
    NSString *str = @"";
    if (self.pickOneIndex == 2) {
        NSString *typeName = [self.componentTypeArr objectAtIndex:self.pickOneIndex];
        NSArray *tempArr = [self.componentInfoDic objectForKey:typeName];
        str = [NSString stringWithFormat:@"%@%@",[self.componentTypeArr objectAtIndex:self.pickOneIndex],[tempArr objectAtIndex:self.pickTwoIndex]];
    }else{
        str = [self.componentTypeArr objectAtIndex:self.pickOneIndex];
    }

    [self.objBtn setTitle:str forState:UIControlStateNormal];
}
- (void)cancelSelected {
    [self.toolbar removeFromSuperview];
    self.pickBgView.hidden = YES;
    [self.objBtn setTitle:@"请选择" forState:UIControlStateNormal];
    
}
#pragma UIPickerViewDataSource
// UIPickerViewDataSource中定义的方法，该方法的返回值决定该控件包含多少列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView
{
    return 2;
}
// UIPickerViewDataSource中定义的方法，该方法的返回值决定该控件指定列包含多少个列表项
- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    if(component == 0){
        return self.componentTypeArr.count;
    }else{
        NSInteger typeRow = [pickerView selectedRowInComponent:0];
        NSString *typeName = [self.componentTypeArr objectAtIndex:typeRow];
        NSArray *tempArr = [self.componentInfoDic objectForKey:typeName];
        return tempArr.count;
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
    if(component == 0){
        return [self.componentTypeArr objectAtIndex:row];
    }else{
        NSInteger typeRow = [pickerView selectedRowInComponent:0];
        NSString *typeName = [self.componentTypeArr objectAtIndex:typeRow];
        NSArray *tempArr = [self.componentInfoDic objectForKey:typeName];
        return [tempArr objectAtIndex:row];
    }
}
// 当用户选中UIPickerViewDataSource中指定列和列表项时激发该方法
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:
(NSInteger)row inComponent:(NSInteger)component
{
    //根据选中的type 更新pickview
    switch (component) {
        case 0:{
            [self.pickView reloadComponent:1];
        }
            break;
        default:
            break;
    }
}
@end
