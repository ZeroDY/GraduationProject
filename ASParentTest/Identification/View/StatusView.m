//
//  StatusView.m
//  ASParentTest
//
//  Created by 张浩 on 15/11/21.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "StatusView.h"

@implementation StatusView

/*
 Only override drawRect: if you perform custom drawing.
 An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
     Drawing code
}
*/
- (void)showStuStatus{
    NSString *stuStatus = @"";
    if ([self.stuStatus isEqualToString:@"0"]) {
        stuStatus = @"在校";
    }else if ([self.stuStatus isEqualToString:@"1"]){
        stuStatus = @"休学";
    }else if ([self.stuStatus isEqualToString:@"2"]){
        stuStatus = @"请假";
    }else if ([self.stuStatus isEqualToString:@"3"]){
        stuStatus = @"毕业";
    }else if ([self.stuStatus isEqualToString:@"4"]){
        stuStatus = @"处分";
    }
    self.infoLab.text = stuStatus;
}

- (IBAction)cancelClick:(id)sender {
    [self.delegate cancelClick];
}

- (IBAction)submitClick:(id)sender {
    [self.delegate submitClick];
}
@end
