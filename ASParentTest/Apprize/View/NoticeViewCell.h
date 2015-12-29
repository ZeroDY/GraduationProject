//
//  NoticeViewCell.h
//  ASTeacher
//
//  Created by 周德艺 on 15/11/24.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoticeObject.h"

@interface NoticeViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *isNew_view;
@property (weak, nonatomic) IBOutlet UILabel *title_label;
@property (weak, nonatomic) IBOutlet UILabel *people_label;
@property (weak, nonatomic) IBOutlet UILabel *date_label;

- (void)loadData:(NoticeObject *)notice;

@end
