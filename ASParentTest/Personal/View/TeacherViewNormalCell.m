//
//  TeacherViewNormalCell.m
//  ASTeacher
//
//  Created by 周德艺 on 15/11/21.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "TeacherViewNormalCell.h"

@implementation TeacherViewNormalCell

- (void)awakeFromNib {
    // Initialization code
    self.isNew_view.backgroundColor = [UIColor colorWithRed:0.986 green:0.192 blue:0.036 alpha:1.000];
    self.isNew_view.layer.cornerRadius = 6;
    self.isNew_view.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
