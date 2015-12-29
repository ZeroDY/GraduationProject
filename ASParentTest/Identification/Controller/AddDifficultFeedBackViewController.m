//
//  AddDifficultFeedBackViewController.m
//  ASParentTest
//
//  Created by 张浩 on 15/11/21.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "AddDifficultFeedBackViewController.h"

@interface AddDifficultFeedBackViewController ()

@end

@implementation AddDifficultFeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"新建疑难";
    self.teacherBtn.layer.masksToBounds = YES;
    self.teacherBtn.layer.cornerRadius = self.teacherBtn.frame.size.height/5;
    
    self.onePointView.layer.masksToBounds = YES;
    self.onePointView.layer.cornerRadius = self.onePointView.frame.size.width/2;
    
    self.twoPointView.layer.masksToBounds = YES;
    self.twoPointView.layer.cornerRadius = self.twoPointView.frame.size.width/2;
    
    self.contentTextView.layer.masksToBounds = YES;
    self.contentTextView.layer.cornerRadius = self.twoPointView.frame.size.width/5;
    self.contentTextView.backgroundColor = BackGroundColor;
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

- (IBAction)submitClick:(id)sender {
}
@end
