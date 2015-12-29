//
//  LeaveDetailViewController.h
//  ASParentTest
//
//  Created by 张浩 on 15/11/21.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AutoScrollView.h"
#import "StudentObject.h"
@interface LeaveDetailViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet AutoScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *backView;

@property (weak, nonatomic) IBOutlet UIView *typeBackView;
@property (weak, nonatomic) IBOutlet UIView *startTimeBackView;
@property (weak, nonatomic) IBOutlet UIView *endTimeBackView;
@property (weak, nonatomic) IBOutlet UIView *reasonBackView;

@property (weak, nonatomic) IBOutlet UILabel *typeTitleLab;
@property (weak, nonatomic) IBOutlet UIView *typeInfoBackView;
@property (weak, nonatomic) IBOutlet UIView *typeImgBackView;
@property (weak, nonatomic) IBOutlet UIImageView *typeImg;
@property (weak, nonatomic) IBOutlet UIButton *typeBtn;

@property (weak, nonatomic) IBOutlet UILabel *startTitleLab;
@property (weak, nonatomic) IBOutlet UIView *startInfoBackView;
@property (weak, nonatomic) IBOutlet UIView *startTimeImgBackView;
@property (weak, nonatomic) IBOutlet UIImageView *startTimeImg;
@property (weak, nonatomic) IBOutlet UIButton *startTimeYearMonthBtn;
@property (weak, nonatomic) IBOutlet UIButton *startTimeHourMiniutesBtn;


@property (weak, nonatomic) IBOutlet UILabel *endTitleLab;
@property (weak, nonatomic) IBOutlet UIView *endInfoBackView;
@property (weak, nonatomic) IBOutlet UIView *endTimeImgBackView;
@property (weak, nonatomic) IBOutlet UIImageView *endTimeImg;
@property (weak, nonatomic) IBOutlet UIButton *endTimeStartYearMonthBtn;
@property (weak, nonatomic) IBOutlet UIButton *endTimeHourMiniutesMonthBtn;

@property (weak, nonatomic) IBOutlet UILabel *reasonTitleLab;
@property (weak, nonatomic) IBOutlet UIView *reasonInfoBackView;
@property (weak, nonatomic) IBOutlet UITextView *reasonTextView;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;


- (IBAction)typeClick:(id)sender;
- (IBAction)startTimeYearMonthClick:(id)sender;
- (IBAction)startTimeHourMinituesClick:(id)sender;

- (IBAction)endTimeYearMonthClick:(id)sender;
- (IBAction)endTimeHourMiniutesClick:(id)sender;

- (IBAction)submitClick:(id)sender;

@property (nonatomic , strong)NSMutableArray *typeArr;
@property (nonatomic , strong)NSMutableArray *HourArr;
@property (nonatomic , strong)NSMutableArray *MinituesArr;
@property (nonatomic , strong)NSString *typeStr;
@property (nonatomic , strong)NSString *startTimeYearMonthStr;
@property (nonatomic , strong)NSString *startTimeHourMiniutesStr;
@property (nonatomic , strong)NSString *endTimeYearMonthStr;
@property (nonatomic , strong)NSString *endTimeHourMiniutesStr;
@property (nonatomic , assign)int pickType; //0：选择类型  1:选择时分   2：选择年月日

//pickView
@property (nonatomic, strong) UIToolbar *toolbar;
@property(nonatomic,strong)UIView *pickBgView;
//normalPickView根据tag值区分类型   0：选择开始时间 时分  1：选择结束时间 时分
@property(nonatomic,strong)UIPickerView *normalPickView;
//datePickView根据tag值区分类型   0：选择开始时间 年月日  1：选择结束时间 年月日
@property(nonatomic,strong)UIDatePicker *datePickView;
@property(nonatomic)NSInteger pickOneIndex;
@property(nonatomic)NSInteger pickTwoIndex;
@property (nonatomic , strong)StudentObject *stuObj;
@end
