//
//  ZcdcDetailHeaderView.h
//  ASParentTest
//
//  Created by 张浩 on 15/11/29.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZcdcDetailHeaderView : UIView
+ (CGFloat)calculateViewHeightWithContentStr:(NSString *)contentStr;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@end
