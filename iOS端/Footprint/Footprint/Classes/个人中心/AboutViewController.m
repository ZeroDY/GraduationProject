//
//  AboutViewController.m
//  FootprintWall
//
//  Created by 张浩 on 15/4/16.
//  Copyright (c) 2015年 张浩. All rights reserved.
//

#import "AboutViewController.h"
#import "UIViewController+MMDrawerController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于";
    //设置导航按钮
    self.view.backgroundColor = BackGroundColor;
    
    //导航栏右侧的新建按钮
    //    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    //    [rightBtn setTitle:@"新建" forState:UIControlStateNormal];
    //    [rightBtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
    //    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    //    [rightBtn addTarget:self action:@selector(buildNewWall) forControlEvents:UIControlEventTouchUpInside];
    //    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 38, 38)];
    [leftBtn setImage:[UIImage imageNamed:@"leftMenu"] forState:UIControlStateNormal];
    //leftBtn.layer.shouldRasterize = YES;
    //    leftBtn.clipsToBounds = YES;
    //    leftBtn.layer.masksToBounds = YES;
    //    leftBtn.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    //    leftBtn.layer.borderWidth = 2.0f;
    //    leftBtn.layer.cornerRadius = leftBtn.frame.size.width / 2;
    //    [leftBtn setTitle:@"个人" forState:UIControlStateNormal];
    //    [leftBtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
    //    [leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [leftBtn addTarget:self action:@selector(leftDrawerButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];

    //设置行距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 8; //行距
    
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:17],
                                 NSParagraphStyleAttributeName:paragraphStyle};
    self.textViewFir.text = @"   “脚印墙”是由公司开发的一款社交APP。                                                                                                      ";
    self.textViewSec.text = @"    平台的主要功能有：搜寻附近人、建立留言墙、添加小纸条、个人中心、定位。";
    
    self.textViewFir.attributedText = [[NSAttributedString  alloc] initWithString:self.textViewFir.text attributes:attributes];
    self.textViewSec.attributedText = [[NSAttributedString alloc] initWithString:self.textViewSec.text attributes:attributes];
    self.textViewFir.textColor = DominantColor;
    self.textViewSec.textColor = DominantColor;
    self.textViewFir.backgroundColor = BackGroundColor;
    self.textViewSec.backgroundColor = BackGroundColor;
    
    
}
#pragma mark - Button Handlers
-(void)leftDrawerButtonPress:(id)sender{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}
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

@end
