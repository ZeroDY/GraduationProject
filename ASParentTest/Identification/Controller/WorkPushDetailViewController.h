//
//  WorkPushDetailViewController.h
//  ASParentTest
//
//  Created by 张浩 on 15/11/29.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface WorkPushDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *timeView;
@property (weak, nonatomic) IBOutlet UIView *questionNumView;
@property (weak, nonatomic) IBOutlet UIView *pointAlertView;
@property (weak, nonatomic) IBOutlet UIButton *onlineBtn;
- (IBAction)onlineClick:(id)sender;
@end
