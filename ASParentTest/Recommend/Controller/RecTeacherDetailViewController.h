//
//  RecTeacherDetailViewController.h
//  ASParentTest
//
//  Created by 张浩 on 15/11/22.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodTeacherObject.h"
@interface RecTeacherDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *oneView;
@property (weak, nonatomic) IBOutlet UIView *twoView;
@property (weak, nonatomic) IBOutlet UIView *threeView;
@property (weak, nonatomic) IBOutlet UIView *fourView;

@property (weak, nonatomic) IBOutlet UIImageView *titleImg;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *infoLab1;
@property (weak, nonatomic) IBOutlet UILabel *infoLab2;
@property (weak, nonatomic) IBOutlet UILabel *infoLab3;
@property (weak, nonatomic) IBOutlet UILabel *infoLab4;

@property (weak, nonatomic) IBOutlet UILabel *twoViewTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *twoViewInfoLab;

@property (weak, nonatomic) IBOutlet UILabel *threeViewTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *threeViewInfoLab;

@property (weak, nonatomic) IBOutlet UILabel *fourViewTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *fourViewInfoLab;

@property (nonatomic , strong)GoodTeacherObject *teacherObj;
@end
