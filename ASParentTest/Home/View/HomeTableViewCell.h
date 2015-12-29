//
//  HomeTableViewCell.h
//  ASParentTest
//
//  Created by 周德艺 on 15/11/19.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HomeTableViewCellDelegate
-(void)showNewsDetail;
-(void)showNewsView;
@end
@interface HomeTableViewCell : UITableViewCell
@property (nonatomic,assign)id <HomeTableViewCellDelegate>delegate;

- (IBAction)showNewsDetailClick:(id)sender;
- (IBAction)showNewsViewClick:(id)sender;
@end
