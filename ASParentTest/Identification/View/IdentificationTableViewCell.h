//
//  IdentificationTableViewCell.h
//  ASParentTest
//
//  Created by 张浩 on 15/11/19.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol IdentificationTableViewCellDelegate
-(void)leaveClick:(UIButton *)leaveBtn;
-(void)statusClick:(UIButton *)statusBtn;
-(void)followClick:(UIButton *)followBtn;
-(void)detailClick:(UIButton *)detailBtn;
-(void)showDetailClick:(UIView *)infoView;

@end
@interface IdentificationTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *infoView;
@property (weak, nonatomic) IBOutlet UIImageView *titleImg;
@property (weak, nonatomic) IBOutlet UILabel *lab1;
@property (weak, nonatomic) IBOutlet UILabel *lab2;
@property (weak, nonatomic) IBOutlet UILabel *lab3;
@property (weak, nonatomic) IBOutlet UIButton *detailBtn;

@property (weak, nonatomic) IBOutlet UIView *btnView;
@property (weak, nonatomic) IBOutlet UIButton *leaveBtn;
@property (weak, nonatomic) IBOutlet UIButton *statusBtn;
@property (weak, nonatomic) IBOutlet UIButton *followBtn;

@property (nonatomic,assign)id <IdentificationTableViewCellDelegate>delegate;
- (IBAction)leaveClick:(id)sender;
- (IBAction)statusClick:(id)sender;
- (IBAction)followClick:(id)sender;
- (IBAction)detailClick:(id)sender;
@end
