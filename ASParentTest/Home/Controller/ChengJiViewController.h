//
//  ChengJiViewController.h
//  ASParentTest
//
//  Created by 周德艺 on 15/11/20.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChengJiViewCell.h"
@interface ChengJiViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,ChengJiViewCellDelegate>

@property (nonatomic , strong) NSMutableArray *dataArr;
@property (nonatomic , strong) NSString *name;
@property (nonatomic , strong) NSString *sex;
@property (nonatomic , strong) NSString *school;

@end
