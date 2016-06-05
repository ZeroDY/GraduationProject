//
//  PersonalTableViewCell.h
//  FootprintWall
//
//  Created by 张浩 on 15/4/14.
//  Copyright (c) 2015年 张浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *menuImage;
@property (weak, nonatomic) IBOutlet UILabel *menuLabel;

@property (weak, nonatomic) IBOutlet UISwitch *menuSwitch;
@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;
@end
