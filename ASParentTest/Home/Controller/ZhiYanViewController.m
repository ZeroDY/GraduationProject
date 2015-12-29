//
//  ZhiYanViewController.m
//  ASParentTest
//
//  Created by 周德艺 on 15/11/21.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "ZhiYanViewController.h"
#import "ZhiYuanViewHeadCell.h"

@interface ZhiYanViewController ()
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ZhiYanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"志愿查询";
    [self.view addSubview:self.tableView];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

#pragma mark - tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return 5;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 20;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    if (indexPath.section == 0) {
        static NSString *cellIdentifier = @"ZhiYuanViewHeadCell";
        ZhiYuanViewHeadCell *cell = (ZhiYuanViewHeadCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            NSBundle *bundle = [NSBundle mainBundle];
            NSArray *nibArray = [bundle loadNibNamed:cellIdentifier owner:nil options:nil];
            cell = (ZhiYuanViewHeadCell *)[nibArray objectAtIndex:0];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        return cell;
    }else{
        static NSString *cellIdentifier = @"zhiyuanResualtCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
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
@end
