//
//  AddStudentCommunicationView.h
//  ASParentTest
//
//  Created by 张浩 on 15/11/22.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol AddStudentCommunicationViewDelegate
-(void)cancelClick;
-(void)submitClick;
@end
@interface AddStudentCommunicationView : UIView

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIView *titleBackView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@property (nonatomic,assign)id <AddStudentCommunicationViewDelegate>delegate;

- (IBAction)cancelClick:(id)sender;
- (IBAction)submitClick:(id)sender;

@end
