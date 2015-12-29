//
//  NewsTableViewCell.h
//  ASParentTest
//
//  Created by 张浩 on 15/11/18.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *titleImg;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *infoLab;
@end
