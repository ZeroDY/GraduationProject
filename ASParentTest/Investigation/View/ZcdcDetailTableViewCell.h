//
//  ZcdcDetailTableViewCell.h
//  ASParentTest
//
//  Created by 张浩 on 15/11/29.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ZcdcDetailTableViewCellDelegate
-(void)chooseOptionalClick:(UIView *)backView;
@end
@interface ZcdcDetailTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIImageView *titleImg;
@property (nonatomic,assign)id <ZcdcDetailTableViewCellDelegate>delegate;

+ (CGFloat)calculateCellHeightWithContentStr:(NSString *)contentStr;
@end
