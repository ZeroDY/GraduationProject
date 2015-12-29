//
//  StatusView.h
//  ASParentTest
//
//  Created by 张浩 on 15/11/21.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol StatusViewDelegate
-(void)cancelClick;
-(void)submitClick;
@end

@interface StatusView : UIView
@property (nonatomic,assign)id <StatusViewDelegate>delegate;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIView *titleView;
@property (weak, nonatomic) IBOutlet UILabel *statusLab;
@property (weak, nonatomic) IBOutlet UILabel *infoLab;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@property (nonatomic , strong)NSString *stuStatus;
- (IBAction)cancelClick:(id)sender;
- (IBAction)submitClick:(id)sender;
- (void)showStuStatus;
@end
