//
//  DifficultFeedBackDetailViewController.h
//  ASParentTest
//
//  Created by 张浩 on 15/11/21.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DifficultFeedBackDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *questionView;
@property (weak, nonatomic) IBOutlet UIView *solutionView;
@property (weak, nonatomic) IBOutlet UIView *tabView;

@property (weak, nonatomic) IBOutlet UILabel *questionTitleLab;
@property (weak, nonatomic) IBOutlet UIImageView *questionTitleImg;
@property (weak, nonatomic) IBOutlet UILabel *questionInfoLab;

@property (weak, nonatomic) IBOutlet UILabel *solutionTitleLab;
@property (weak, nonatomic) IBOutlet UIImageView *solutionTitleImg;
@property (weak, nonatomic) IBOutlet UILabel *solutionInfoLab;

@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;

@end
