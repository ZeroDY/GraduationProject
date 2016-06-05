//
//  WallTableViewCell.h
//  FootprintWall
//
//  Created by 张浩 on 15/4/23.
//  Copyright (c) 2015年 张浩. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol WallTableDelegate <NSObject>

@optional
-(void)likeInfo:(int)curruntRow;
-(void)commentInfo:(int)curruntRow;
-(void)showUserVote:(int)curruntRow;

@end
@interface WallTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *mainTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *dateLab;
@property (weak, nonatomic) IBOutlet UILabel *likeLab;
@property (weak, nonatomic) IBOutlet UILabel *commentLab;
@property (weak, nonatomic) IBOutlet UIScrollView *imgScrollView;
@property (nonatomic,assign)id <WallTableDelegate>delegate;
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
@property (weak, nonatomic) IBOutlet UIButton *iconBtn;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet UIButton *nickBtn;
@property (weak, nonatomic) IBOutlet UILabel *bgLabel;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;

-(IBAction)like:(id)sender;
-(IBAction)comment:(id)sender;
-(IBAction)user:(id)sender;
@end
