//
//  AddStudentCommunicationView.m
//  ASParentTest
//
//  Created by 张浩 on 15/11/22.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "AddStudentCommunicationView.h"

@implementation AddStudentCommunicationView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)cancelClick:(id)sender {
    [self.delegate cancelClick];
}

- (IBAction)submitClick:(id)sender {
    [self.delegate submitClick];
}
@end
