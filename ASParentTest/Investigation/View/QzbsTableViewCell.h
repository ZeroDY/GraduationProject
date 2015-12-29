//
//  QzbsTableViewCell.h
//  ASParentTest
//
//  Created by 张浩 on 15/12/23.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QzbsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIImageView *titleImg;
@property (weak, nonatomic) IBOutlet UILabel *lineLab;
@property (weak, nonatomic) IBOutlet UIView *contentBackView;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;

@property (weak, nonatomic) IBOutlet UILabel *timeLab;
+ (CGFloat)calculateCellHeightWithContentStr:(NSString *)contentStr;
@end
