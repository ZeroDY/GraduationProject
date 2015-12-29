//
//  RecBookDetailViewController.h
//  ASParentTest
//
//  Created by 张浩 on 15/11/22.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AutoScrollView.h"
@interface RecBookDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet AutoScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIView *titleBackView;
@property (weak, nonatomic) IBOutlet UIView *infoTitleBackView;
@property (weak, nonatomic) IBOutlet UIView *infoBackView;
@property (weak, nonatomic) IBOutlet UIView *contentTitleBackView;
@property (weak, nonatomic) IBOutlet UIView *contentBackView;

@property (weak, nonatomic) IBOutlet UIImageView *titleImg;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *titleInfoLab;

@property (weak, nonatomic) IBOutlet UILabel *infoTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *infoLab;


@property (weak, nonatomic) IBOutlet UILabel *contentTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@end
