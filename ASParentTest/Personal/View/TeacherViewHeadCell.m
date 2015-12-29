//
//  TeacherViewHeadCell.m
//  ASTeacher
//
//  Created by 周德艺 on 15/11/21.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "TeacherViewHeadCell.h"

@implementation TeacherViewHeadCell

- (void)awakeFromNib {
    // Initialization code
    self.head_imageView.layer.masksToBounds = YES;
    self.head_imageView.layer.cornerRadius = 30;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
