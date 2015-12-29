//
//  NoticeViewCell.m
//  ASTeacher
//
//  Created by 周德艺 on 15/11/24.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "NoticeViewCell.h"
#import "NoticeObject.h"

@implementation NoticeViewCell

- (void)awakeFromNib {
    // Initialization code
    self.isNew_view.layer.cornerRadius = 5;
    self.isNew_view.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)loadData:(NoticeObject *)notice{
    self.title_label.text = notice.theader;
    self.date_label.text = notice.addtime;
    self.people_label.text = [NSString stringWithFormat:@"接收者：%@",notice.szname];
}

@end
