//
//  SetUpViewController.h
//  Footprint
//
//  Created by 张浩 on 15/5/26.
//  Copyright (c) 2015年 周德艺. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserObject.h"
@interface SetUpViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong) UIButton *iconBtn;
@property (nonatomic,strong) UserObject *user;
@property (nonatomic,strong) UILabel *trueName;
@property (nonatomic,strong) UILabel *userName;
@property (nonatomic,strong) UILabel *sex;
@property (nonatomic,strong) UILabel *age;
@property (nonatomic,strong) UILabel *tel;

@property (nonatomic,strong) UIImage *photo;

@end
