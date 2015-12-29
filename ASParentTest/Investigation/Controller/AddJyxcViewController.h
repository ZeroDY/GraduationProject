//
//  AddJyxcViewController.h
//  ASParentTest
//
//  Created by 张浩 on 15/11/20.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AutoScrollView.h"

@interface AddJyxcViewController : UIViewController<UIScrollViewDelegate,UITextFieldDelegate,UITextViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet AutoScrollView *autoScrollView;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *objLab;
@property (weak, nonatomic) IBOutlet UILabel *infoLab;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UIButton *objBtn;
@property (weak, nonatomic) IBOutlet UITextView *infoTextView;
//pickView
@property (nonatomic, strong) UIToolbar *toolbar;
@property(nonatomic,strong)UIView *pickBgView;
@property(nonatomic,strong)UIPickerView *pickView;
@property(nonatomic)NSInteger pickOneIndex;
@property(nonatomic)NSInteger pickTwoIndex;
//假数据
@property (nonatomic ,strong)NSMutableArray *componentTypeArr;
@property (nonatomic ,strong)NSMutableDictionary *componentInfoDic;

- (IBAction)objBtnClick:(id)sender;
@end
