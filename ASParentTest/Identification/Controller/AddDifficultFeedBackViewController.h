//
//  AddDifficultFeedBackViewController.h
//  ASParentTest
//
//  Created by 张浩 on 15/11/21.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AutoScrollView.h"
@interface AddDifficultFeedBackViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *titleBackView;
@property (weak, nonatomic) IBOutlet UIView *contentBackView;
@property (weak, nonatomic) IBOutlet UIImageView *onePointView;
@property (weak, nonatomic) IBOutlet UIImageView *twoPointView;
@property (weak, nonatomic) IBOutlet UIButton *teacherBtn;
@property (weak, nonatomic) IBOutlet UITextField *infoTextField;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
- (IBAction)submitClick:(id)sender;
@end
