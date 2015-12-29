//
//  RecTeacherDetailViewController.m
//  ASParentTest
//
//  Created by 张浩 on 15/11/22.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "RecTeacherDetailViewController.h"

@interface RecTeacherDetailViewController ()

@end

@implementation RecTeacherDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"推荐详情";
}
-(void)viewWillAppear:(BOOL)animated{
    //数据
    //                self.titleImg.image = [UIImage imageNamed:imgStr];
    self.titleLab.text = [PublicObject convertNullString:self.teacherObj.teaname];
    self.infoLab1.text = [PublicObject convertNullString:self.teacherObj.teacoursename];
    self.infoLab2.text = [PublicObject convertNullString:self.teacherObj.fromschoolname];
    self.infoLab3.text = [PublicObject convertNullString:self.teacherObj.jlinian];
    self.infoLab4.text = [PublicObject convertNullString:self.teacherObj.tdianzan];
    self.twoViewTitleLab.text = @"教学成果";
    self.twoViewInfoLab.text = [PublicObject convertNullString:self.teacherObj.tdianzan];
    
    self.threeViewTitleLab.text = @"教学特点";
    self.threeViewInfoLab.text = [PublicObject convertNullString:self.teacherObj.jtedian];
    
    
    self.fourViewTitleLab.text = @"教学荣誉";
    self.fourViewInfoLab.text = [PublicObject convertNullString:self.teacherObj.trongyu];
    
    
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
