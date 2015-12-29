//
//  ScroreTableViewCell.h
//  ASParentTest
//
//  Created by 张浩 on 15/11/30.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScroreTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIView *firstBackView;
@property (weak, nonatomic) IBOutlet UIView *lastBackView;
@property (weak, nonatomic) IBOutlet UIImageView *firstPointImg;
@property (weak, nonatomic) IBOutlet UILabel *firstLab;
@property (weak, nonatomic) IBOutlet UIImageView *lastPointImg;
@property (weak, nonatomic) IBOutlet UILabel *lastLab;
@end
