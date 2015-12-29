//
//  HomeWorkOnlineViewController.h
//  ASParentTest
//
//  Created by 张浩 on 15/12/3.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZcdcDetailTableViewCell.h"
@interface HomeWorkOnlineViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,ZcdcDetailTableViewCellDelegate>


@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (weak, nonatomic) IBOutlet UIView *bottomBackView;

@property (weak, nonatomic) IBOutlet UIButton *lastQuestionBtn;
@property (weak, nonatomic) IBOutlet UIButton *nextQuestionBtn;



@property (nonatomic , assign) int questionIndex;
@property (nonatomic , strong) NSMutableArray *resultArr;//提交的结果数组
- (IBAction)lastQuestionClick:(id)sender;
- (IBAction)nextQuestionClick:(id)sender;
@property (nonatomic , strong) NSMutableArray *dataArr;
@property (nonatomic , assign) NSInteger oldIndex;
@end
