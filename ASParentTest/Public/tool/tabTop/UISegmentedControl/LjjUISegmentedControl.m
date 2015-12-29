//
//  LjjUIsegumentViewController.m
//  HappyHall
//
//  Created by 张浩 on 15/6/30.
//  Copyright (c) 2015年 rencong. All rights reserved.
//

#import "LjjUISegmentedControl.h"
@interface LjjUISegmentedControl ()<LjjUISegmentedControlDelegate>
{
    CGFloat witdFloat;
    UIView* buttonDown;
    NSInteger selectSeugment;
}
@end

@implementation LjjUISegmentedControl
-(void)AddSegumentArray:(NSArray *)SegumentArray
{
    NSInteger seugemtNumber=SegumentArray.count;
    witdFloat=(self.bounds.size.width)/seugemtNumber;
    for (int i=0; i<SegumentArray.count; i++) {
        UIButton* button=[[UIButton alloc]initWithFrame:CGRectMake(i*witdFloat, 0, witdFloat, self.bounds.size.height-2)];
        [button setTitle:SegumentArray[i] forState:UIControlStateNormal];
//        NSLog(@"这里defont%@",[button.titleLabel.font familyName]);
        [button.titleLabel setFont:self.titleFont];
        [button setTitleColor:MainColor forState:UIControlStateNormal];
        [button setTitleColor:MainColor forState:UIControlStateSelected];
        [button setTag:i];
        [button addTarget:self action:@selector(changeTheSegument:) forControlEvents:UIControlEventTouchUpInside];
        if (i==0) {
            buttonDown=[[UIView alloc]initWithFrame:CGRectMake(i*witdFloat, self.bounds.size.height-2, witdFloat, 2)];
            [buttonDown setBackgroundColor:MainColor];
            [self addSubview:buttonDown];
        }
        [self addSubview:button];
        [self.ButtonArray addObject:button];
    }
    [[self.ButtonArray firstObject] setSelected:YES];
}
-(void)changeTheSegument:(UIButton*)button
{
    [self selectTheSegument:button.tag];
    
}
-(void)selectTheSegument:(NSInteger)segument
{
    if (selectSeugment!=segument) {
        NSLog(@"我点击了");
        [self.ButtonArray[selectSeugment] setSelected:NO];
        [self.ButtonArray[segument] setSelected:YES];
        [UIView animateWithDuration:0.2 animations:^{
            [buttonDown setFrame:CGRectMake(segument*witdFloat,self.bounds.size.height-2, witdFloat, 2)];
        }];
        selectSeugment=segument;
        [self.delegate uisegumentSelectionChange:selectSeugment];
    }
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self.ButtonArray=[NSMutableArray array];
    selectSeugment=0;
    self.titleFont=[UIFont fontWithName:@".Helvetica Neue Interface" size:12.0f];
    self=[super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 34)];
//    self.LJBackGroundColor=[UIColor colorWithRed:253.0f/255 green:239.0f/255 blue:230.0f/255 alpha:1.0f];
    self.LJBackGroundColor = [UIColor whiteColor];
    self.titleColor=MainColor;
    self.selectColor=MainColor;
    [self setBackgroundColor:self.LJBackGroundColor];
    return self;
}
//-(void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
//{
//    UISegmentedControl* sgement=[[UISegmentedControl alloc]init];
//    [sgement addTarget:target action:action forControlEvents:controlEvents];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
