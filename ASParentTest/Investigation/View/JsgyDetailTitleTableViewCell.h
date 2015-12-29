//
//  JsgyDetailTitleTableViewCell.h
//  ASParentTest
//
//  Created by 张浩 on 15/11/20.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JsgyDetailTitleTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIView *titleBackView;
@property (weak, nonatomic) IBOutlet UIImageView *titleImg;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UIImageView *pointImg;

+ (CGFloat)calculateCellHeightWithContentStr:(NSString *)contentStr;
@end
