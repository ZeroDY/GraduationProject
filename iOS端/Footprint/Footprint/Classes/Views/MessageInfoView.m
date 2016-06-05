//
//  MessageInfoView.m
//  Footprint
//
//  Created by 周德艺 on 15/5/4.
//  Copyright (c) 2015年 周德艺. All rights reserved.
//

#import "MessageInfoView.h"

@interface MessageInfoView ()

@end

@implementation MessageInfoView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        
        self.info_Label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        [self.info_Label setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.4]];
        [self.info_Label setText:@"这里是小纸条信息等"];
        [self.info_Label setTextColor:[UIColor whiteColor]];
        [self.info_Label setTextAlignment:NSTextAlignmentCenter];
        [self.info_Label setNumberOfLines: 0];
        
        self.goNext_btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        [self.goNext_btn setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.4]];
        [self.goNext_btn setTitle:@"进  入" forState:UIControlStateNormal];
        [self.goNext_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
//        self.collect_btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
//        [self.collect_btn setBackgroundImage:[UIImage imageNamed:@"shoucang2"] forState:UIControlStateNormal];
//        [self addSubview:self.collect_btn];
        
        [self addSubview:self.info_Label];
        [self addSubview:self.goNext_btn];
    }
    return self;
}


@end
