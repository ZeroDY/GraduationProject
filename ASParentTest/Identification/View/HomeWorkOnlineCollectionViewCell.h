//
//  HomeWorkOnlineCollectionViewCell.h
//  ASParentTest
//
//  Created by 张浩 on 15/12/4.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface HomeWorkOnlineCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIView *labBackView;
@property (weak, nonatomic) IBOutlet UILabel *lab;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backViewWidthConstraint;


@end
