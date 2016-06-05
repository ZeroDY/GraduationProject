//
//  MessageInfoView.h
//  Footprint
//
//  Created by 周德艺 on 15/5/4.
//  Copyright (c) 2015年 周德艺. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoteObject.h"

@interface MessageInfoView : UIView

//@property (strong, nonatomic)  UIButton *collect_btn;
@property (strong, nonatomic)  UIButton *goNext_btn;
@property (strong, nonatomic)  UILabel *info_Label;

@property (nonatomic,strong) NoteObject *msg;

@end
