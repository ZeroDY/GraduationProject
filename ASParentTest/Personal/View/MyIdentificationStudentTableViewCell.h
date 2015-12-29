//
//  MyIdentificationStudentTableViewCell.h
//  ASParentTest
//
//  Created by 张浩 on 15/11/25.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyIdentificationStudentTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIImageView *titleImg;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *infoLab;
@property (weak, nonatomic) IBOutlet UILabel *typeLab;
@end
