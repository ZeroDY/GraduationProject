//
//  IdentificationDetailViewController.h
//  ASParentTest
//
//  Created by 张浩 on 15/11/19.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StatusView.h"
#import "StudentObject.h"
@interface IdentificationDetailViewController : UIViewController<StatusViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *titleView;
@property (weak, nonatomic) IBOutlet UIImageView *titleImg;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *infoLab;

@property (weak, nonatomic) IBOutlet UIView *titleBtnView;
@property (weak, nonatomic) IBOutlet UIButton *leaveBtn;
@property (weak, nonatomic) IBOutlet UIButton *statusBtn;
@property (weak, nonatomic) IBOutlet UIButton *followBtn;

@property (weak, nonatomic) IBOutlet UILabel *centerLab;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIButton *workPushBtn;
@property (weak, nonatomic) IBOutlet UIButton *todaySubjectBtn;
@property (weak, nonatomic) IBOutlet UIButton *difficultFeedbackBtn;
@property (weak, nonatomic) IBOutlet UIButton *studentCommunicationBtn;

- (IBAction)studentCommunicationClick:(id)sender;

- (IBAction)workPushClick:(id)sender;
- (IBAction)todaySubjectClick:(id)sender;
- (IBAction)difficultFeedbackClick:(id)sender;

@property (nonatomic , strong) StatusView *statusView;
@property (nonatomic , strong) StudentObject *studentObj;

- (IBAction)leaveClick:(id)sender;
- (IBAction)statusClick:(id)sender;
- (IBAction)followClick:(id)sender;
@end
