//
//  CommentTitleTableViewCell.h
//  Footprint
//
//  Created by 张浩 on 15/5/5.
//  Copyright (c) 2015年 周德艺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentTitleTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImg;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UIImageView *userPhoto_image;
@property (strong, nonatomic) UIButton *content_btn;
@property (strong, nonatomic) UILabel *msgContent_label;
@property (strong, nonatomic) UIView *changeView;
@property (nonatomic) BOOL isChange;

@end
