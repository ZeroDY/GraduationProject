//
//  WorkPushTableViewCell.h
//  ASParentTest
//
//  Created by 张浩 on 15/12/3.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WorkPushTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *backView;

@property (weak, nonatomic) IBOutlet UIView *titlebackView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@property (weak, nonatomic) IBOutlet UILabel *infoLab1;
@property (weak, nonatomic) IBOutlet UILabel *infoLab2;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;

@property (weak, nonatomic) IBOutlet UILabel *questionNumLab;

@property (weak, nonatomic) IBOutlet UILabel *statusLab;
@property (weak, nonatomic) IBOutlet UIView *statusView;
@property (weak, nonatomic) IBOutlet UIView *statusBackView;


@end
