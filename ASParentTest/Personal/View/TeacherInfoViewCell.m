//
//  TeacherInfoViewCell.m
//  ASTeacher
//
//  Created by 周德艺 on 15/11/23.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "TeacherInfoViewCell.h"

@implementation TeacherInfoViewCell

- (void)awakeFromNib {
    // Initialization code
    [self.head_imageView setBackgroundColor:MainColor];
    self.head_imageView.layer.cornerRadius = 22;
    self.head_imageView.layer.masksToBounds = YES;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
