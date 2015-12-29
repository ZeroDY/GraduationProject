//
//  RegistOneViewController.h
//  ASParentTest
//
//  Created by 张浩 on 15/11/19.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AutoScrollView.h"

@interface RegistOneViewController : UIViewController<UITextFieldDelegate>
@property (nonatomic, strong) AutoScrollView *scrollView;
@property (nonatomic, strong) UILabel *infoLab;
@property (nonatomic, strong) UITextField *phoneTextField;

@property (nonatomic, strong) UIButton *nextStepBtn;
@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UILabel *loginLab;

@end
