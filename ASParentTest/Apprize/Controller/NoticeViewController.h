//
//  NoticeViewController.h
//  ASTeacher
//
//  Created by 周德艺 on 15/11/24.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoticeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic , assign)NSInteger allPages;

@end
