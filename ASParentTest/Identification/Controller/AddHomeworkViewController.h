//
//  AddHomeworkViewController.h
//  ASTeacher
//
//  Created by 周德艺 on 15/11/23.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WorkPushDetailObject.h"
@interface AddHomeworkViewController : UIViewController
@property (nonatomic ,strong)WorkPushDetailObject *workDetailObj;
@property (nonatomic , copy)NSString *homeworkId;
@end
