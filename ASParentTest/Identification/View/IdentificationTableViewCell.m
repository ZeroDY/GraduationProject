//
//  IdentificationTableViewCell.m
//  ASParentTest
//
//  Created by 张浩 on 15/11/19.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "IdentificationTableViewCell.h"

@implementation IdentificationTableViewCell

- (void)awakeFromNib {
    // Initialization code
    //给infoView添加点击手势
    self.infoView.userInteractionEnabled = YES;
    UITapGestureRecognizer *click = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showDetailClick)];
    [self.infoView addGestureRecognizer:click];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)leaveClick:(id)sender {
    [self.delegate leaveClick:sender];
}

- (IBAction)statusClick:(id)sender {
    [self.delegate statusClick:sender];
}

- (IBAction)followClick:(id)sender {
    [self.delegate followClick:sender];
}
-(void)showDetailClick{
    [self.delegate showDetailClick:self.infoView];
}
- (IBAction)detailClick:(id)sender {
    [self.delegate detailClick:self.detailBtn];
}
@end
