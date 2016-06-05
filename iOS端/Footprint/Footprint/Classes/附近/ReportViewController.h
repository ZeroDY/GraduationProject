//
//  ReportViewController.h
//  Footprint
//
//  Created by 张浩 on 15/6/9.
//  Copyright (c) 2015年 周德艺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReportViewController : UIViewController<UITextViewDelegate>

@property (nonatomic, strong) NSString *reportid;
@property (weak, nonatomic) IBOutlet UITextView *reportContentTextView;
@property (weak, nonatomic) IBOutlet UIButton *imageBtn;
- (IBAction)imageClick:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
- (IBAction)submitClick:(id)sender;
@end
