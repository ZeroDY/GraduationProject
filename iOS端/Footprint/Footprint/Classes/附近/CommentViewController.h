//
//  CommentViewController.h
//  FootprintWall
//
//  Created by 张浩 on 15/4/23.
//  Copyright (c) 2015年 张浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentObject.h"
#import "UserObject.h"
#import "YcKeyBoardView.h"

@interface CommentViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

//@property(nonatomic, strong) CommentObject *comment;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic , strong) NSMutableArray *commentArr;

@property (nonatomic,strong) NoteObject *msg;
@property (nonatomic) int touchPointX;
@property (nonatomic) int touchPointY;
@property (nonatomic,strong) NSMutableArray *typeArr;
//评论
@property(nonatomic,strong)YcKeyBoardView *commentView;
@property(nonatomic ,assign)float keyBoardHeight;
@property (nonatomic,strong) NSString *comContent;
@property (nonatomic,strong) UserObject *user;

- (IBAction)comment:(id)sender;
@end
