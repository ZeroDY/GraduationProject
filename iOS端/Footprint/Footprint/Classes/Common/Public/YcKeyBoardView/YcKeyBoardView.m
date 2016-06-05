//
//  YcKeyBoardView.m
//  KeyBoardAndTextView
//
//  Created by zzy on 14-5-28.
//  Copyright (c) 2014年 zzy. All rights reserved.
//

#import "YcKeyBoardView.h"

@interface YcKeyBoardView()<UITextViewDelegate>
@property (nonatomic,assign) CGFloat textViewWidth;
@property (nonatomic,assign) BOOL isChange;
@property (nonatomic,assign) BOOL reduce;
@property (nonatomic,assign) CGRect originalKey;
@property (nonatomic,assign) CGRect originalText;
@end

@implementation YcKeyBoardView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        [self initTextView:frame];
    }
    return self;
}
-(void)initTextView:(CGRect)frame
{
    self.textView=[[UITextView alloc]init];
    self.textView.delegate=self;
    CGFloat textX=kStartLocation*0.5;
    self.textViewWidth=frame.size.width-2*textX;
    self.textView.frame=CGRectMake(textX, kStartLocation*0.2,self.textViewWidth , frame.size.height-2*kStartLocation*0.2);
    self.textView.backgroundColor=[UIColor colorWithRed:233.0/255 green:232.0/255 blue:250.0/255 alpha:1.0];
    self.textView.font=[UIFont systemFontOfSize:18];
    [self addSubview:self.textView];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ([text isEqualToString:@"\n"]){
        
        if([self.delegate respondsToSelector:@selector(keyBoardViewHide: textView:)]){
        
            [self.delegate keyBoardViewHide:self textView:self.textView];
        }
        return NO;
    }
    UITextRange * selectedRange = textView.markedTextRange;
    if(selectedRange == nil || selectedRange.empty){
        NSString * toBeString = [textView.text stringByReplacingCharactersInRange:range withString:text]; //得到输入框的内容
        if (self.textView == textView) //判断是否时我们想要限定的那个输入框
        {
            if ([toBeString length] > kContentLength) { //如果输入框内容大于200则弹出警告
                textView.text = [toBeString substringToIndex:kContentLength];

                //定义广播
                [[NSNotificationCenter defaultCenter] postNotificationName:@"commentLength" object:nil userInfo:nil];
                return NO;
            }
        }
    }
    return YES;
    
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    UITextRange *selectedRange = textView.markedTextRange;
    if (selectedRange == nil || selectedRange.empty) {
        if (self.textView == textView) {//判断是否时我们想要限定的那个输入框
            if ([textView.text length] > kContentLength) { //如果输入框内容大于200则弹出警告
                textView.text = [textView.text substringToIndex:kContentLength];
                AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                [PublicObject showHUDView:appDelegate.window title:@"注意" content:@"字数超过限制" time:kHUDTime];
            }
        }
    }
}

- (void)textViewDidChange:(UITextView *)textView {
    NSString *content = textView.text;
    //定义广播数据，其类型为NSDisdictionary
    NSDictionary *dictData = [NSDictionary dictionaryWithObject:content forKey:@"comment"];
    //定义广播
    [[NSNotificationCenter defaultCenter] postNotificationName:@"comment" //广播名称
                                                        object:nil userInfo:dictData];
    CGSize contentSize = [content sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]}];
      if(contentSize.width>self.textViewWidth){
          
          if(!self.isChange){
              
              CGRect keyFrame=self.frame;
              self.originalKey=keyFrame;
              keyFrame.size.height+=keyFrame.size.height;
              keyFrame.origin.y-=keyFrame.size.height*0.25;
              self.frame=keyFrame;
              
              CGRect textFrame=self.textView.frame;
              self.originalText=textFrame;
              textFrame.size.height+=textFrame.size.height*0.5+kStartLocation*0.2;
              self.textView.frame=textFrame;
              self.isChange=YES;
              self.reduce=YES;
            }
      }
    
    if(contentSize.width<=self.textViewWidth){
        
        if(self.reduce){
            
            self.frame=self.originalKey;
            self.textView.frame=self.originalText;
            self.isChange=NO;
            self.reduce=NO;
        }
    }

}
@end
