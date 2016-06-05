//
//  CommentViewController.m
//  FootprintWall
//
//  Created by 张浩 on 15/4/23.
//  Copyright (c) 2015年 张浩. All rights reserved.
//
#define kWinSize [UIScreen mainScreen].bounds.size

#import "CommentViewController.h"
#import "CommentTableViewCell.h"
#import "CommentTitleTableViewCell.h"
#import "CommentObject.h"

@interface CommentViewController ()<YcKeyBoardViewDelegate>
@property (nonatomic,strong)YcKeyBoardView *key;
@property (nonatomic,assign) CGRect originalKey;
@property (nonatomic,assign) CGRect originalText;
@end

@implementation CommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getCommentInfo:self.msg.msgid];
    [self.tableView setSeparatorColor:[UIColor clearColor]];
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    self.typeArr = [[NSMutableArray alloc]initWithObjects:@"举报", nil];
    
    //监听
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(getComment:)
                                                 name:@"comment"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(getCommentLength:)
                                                 name:@"commentLength"
                                               object:nil];

}

-(void)viewWillAppear:(BOOL)animated{
    /**
     *  隐藏
//     */
//    MainViewController *mainVC = (MainViewController *)self.tabBarController;
//    mainVC.fancyTabBar.hidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    [self.tableView reloadData];
}

-(void)viewWillDisappear:(BOOL)animated{
    
//    //显示
//    MainViewController *mainVC = (MainViewController *)self.tabBarController;
//    mainVC.fancyTabBar.hidden = NO;
    self.tabBarController.tabBar.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)getCommentInfo:(NSString *)msgId{
    [FtService GETmethod:KFindreviewbymsgid andParameters:msgId andHandle:^(NSDictionary *myresult) {
        NSDictionary *result = myresult;
        int status = [[result objectForKey:@"status"]intValue];
        if (status == 1) {
            NSArray *commentDic = [result objectForKey:@"result"];
            NSArray *comArr = [CommentObject objectArrayWithKeyValuesArray:commentDic];
            self.commentArr = [[NSMutableArray alloc]initWithArray:comArr];
            [self.tableView reloadData];
        }
        else{
            NSLog(@"失败");
        }
    }];
    
    
}
#pragma mark -
#pragma mark UITableView Datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return [self.commentArr count]+1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSInteger row = indexPath.row;
    if (row == 0) {
        static NSString *CellIdentifier = @"CommentTitleTableViewCell";
        CommentTitleTableViewCell *cell = (CommentTitleTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            NSBundle *bundle = [NSBundle mainBundle];
            NSArray *NibArray = [bundle loadNibNamed:@"CommentTitleTableViewCell" owner:self options:nil];
            cell = (CommentTitleTableViewCell *)[NibArray objectAtIndex:0];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            [cell.contentView setBackgroundColor:[UIColor clearColor]];
        }
        
        NSLog(@"%@",self.commentArr);
        NSString *backImg = [NSString stringWithFormat:@"%@%@",KGetImage_URL,self.msg.msgimage];
        [cell.backgroundImg sd_setImageWithURL:[NSURL URLWithString:backImg] placeholderImage:[UIImage imageNamed:@"wall_image01"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) { }];
        
        NSString *userImg = [NSString stringWithFormat:@"%@%@",KGetImage_URL,self.msg.user.photourl];
        [cell.userPhoto_image sd_setImageWithURL:[NSURL URLWithString:userImg] placeholderImage:[UIImage imageNamed:@"userphoto"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {}];
        cell.userPhoto_image.layer.cornerRadius = cell.userPhoto_image.frame.size.width/2;
        [cell.userPhoto_image.layer setMasksToBounds:YES];
        
        cell.changeView = [[UIView alloc]initWithFrame:CGRectMake(0, cell.frame.size.height - 38,  SCREEN_WIDTH, 38)];
        cell.changeView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
        cell.msgContent_label= [[UILabel alloc]initWithFrame: CGRectMake(10, 10,  SCREEN_WIDTH - 20, 20)];
        [cell.msgContent_label setNumberOfLines:1];
        cell.msgContent_label.font = [UIFont systemFontOfSize:16];
        cell.msgContent_label.textColor = [UIColor whiteColor];
        cell.msgContent_label.text = self.msg.msgcontent;
        
        cell.content_btn = [[UIButton alloc]initWithFrame:cell.msgContent_label.frame];
        [cell.content_btn addTarget:self action:@selector(changeFrame:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.changeView addSubview:cell.msgContent_label];
        [cell.changeView addSubview:cell.content_btn];
        [cell addSubview:cell.changeView];
        
        NSString *userName = self.msg.user.truename;
        cell.nameLab.text = userName;
        return cell;
        
    } else {
        CommentObject *comment = [self.commentArr objectAtIndex:row-1];
        static NSString *CellIdentifier = @"CommentTableViewCell";
        CommentTableViewCell *cell = (CommentTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            NSBundle *bundle = [NSBundle mainBundle];
            NSArray *NibArray = [bundle loadNibNamed:@"CommentTableViewCell" owner:self options:nil];
            cell = (CommentTableViewCell *)[NibArray objectAtIndex:0];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            [cell.contentView setBackgroundColor:[UIColor clearColor]];
        }
        
        cell.comLab.layer.borderColor = [UIColor lightGrayColor].CGColor;
        cell.comLab.layer.borderWidth = 1.0;
        cell.comLab.layer.cornerRadius = 8;
        [[cell.comLab layer] setMasksToBounds:YES];
        cell.comTextView.text = comment.revcontent;
        
        NSString *userImg = [NSString stringWithFormat:@"%@%@",KGetImage_URL,comment.userByFromuser.photourl];
        NSString *userName = self.msg.user.username;
//        [cell.iconBtn setImage:[UIImage imageNamed:@"userphoto"] forState:UIControlStateNormal];
        [cell.iconBtn sd_setImageWithURL:[NSURL URLWithString:userImg] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"userphoto"]];
        cell.iconBtn.layer.cornerRadius = cell.iconBtn.frame.size.width/2;
        [cell.iconBtn.layer setMasksToBounds:YES];
        return cell;
        
        
    }
}

#pragma mark-改变label大小
- (IBAction)changeFrame:(id)sender {
    CommentTitleTableViewCell *cell = (CommentTitleTableViewCell*) [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    if (cell.isChange) {
        cell.changeView.frame = CGRectMake(0, cell.frame.size.height - 38,  SCREEN_WIDTH, 38);
        cell.msgContent_label.frame = CGRectMake(10,10, SCREEN_WIDTH-20, 20);
        cell.content_btn.frame = cell.msgContent_label.frame;
        [cell.msgContent_label setNumberOfLines:1];
        cell.isChange = NO;
    }else{
        CGRect rect = [cell.msgContent_label.text boundingRectWithSize:CGSizeMake(cell.frame.size.width-38, 8000)
                                                               options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                                            attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16]}//传人的字体字典
                                                               context:nil];
        
        if (rect.size.height > 18) {
            [cell.msgContent_label setNumberOfLines:0];
            cell.changeView.frame = CGRectMake(0,cell.frame.size.height - rect.size.height - 20, cell.frame.size.width, rect.size.height+20);
            cell.msgContent_label.frame = CGRectMake(10,10, cell.frame.size.width-20, rect.size.height);
            cell.content_btn.frame = cell.msgContent_label.frame;
            
            cell.isChange = YES;
        }
    }
}

// 定义成方法方便多个label调用 增加代码的复用性
- (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font
{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(self.view.frame.size.width-140, 8000)//限制最大的宽度和高度
                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                    attributes:@{NSFontAttributeName: font}//传人的字体字典
                                       context:nil];
    
    return rect.size;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    CGPoint point = CGPointMake(self.touchPointX,self.touchPointY);
//    NSLog(@"%@",self.typeArr);
//    PopoverView *pop = [[PopoverView alloc] initWithPoint:point titles:self.typeArr images:nil];
//    pop.selectRowAtIndex = ^(NSInteger index){
//        NSLog(@"select index:%ld", (long)index);
//        
//    };
//    [pop show];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 280;
    }else{
        CommentObject *comment = [self.commentArr objectAtIndex:indexPath.row-1];
        CGSize size = [self sizeWithString:comment.revcontent font:[UIFont systemFontOfSize:14]];
        if (size.height<40) {
            return 100;
        }else{
            return size.height+60;
        }
        
    }
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event

{
    
    UITouch *touch = [touches anyObject];
    
    CGPoint touchPoint = [touch locationInView:self.view];
    
    NSLog(@"%f==%f",touchPoint.x,touchPoint.y);
    self.touchPointX = (int)(touchPoint.x);
    self.touchPointY = (int)(touchPoint.y);
    NSLog(@"%i%i",self.touchPointX,self.touchPointY);
    
    
    //touchPoint.x ，touchPoint.y 就是触点的坐标。
    
}


- (void)keyboardShow:(NSNotification *)note {
    CGRect keyBoardRect = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat deltaY = keyBoardRect.size.height;
    self.keyBoardHeight = deltaY;
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        self.key.transform = CGAffineTransformMakeTranslation(0, -deltaY);
    }];
}

- (void)keyboardHide:(NSNotification *)note {
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        self.key.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        self.key.textView.text = @"";
        [self.key removeFromSuperview];
    }];
}

- (void)keyBoardViewHide:(YcKeyBoardView *)keyBoardView textView:(UITextView *)contentView {
    [contentView resignFirstResponder];
    //接口请求
    [self commentBtnClick];
}
- (void)getComment:(NSNotification *)notification {
    NSDictionary *myComm = [notification userInfo];
    self.comContent = [myComm objectForKey:@"comment"];
}

- (void)getCommentLength:(NSNotification *)notification {
    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
    [PublicObject showHUDView:window title:@"注意" content:@"字数超过限制" time:kHUDTime];
}

- (IBAction)comment:(id)sender {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    if (self.key == nil) {
        self.key = [[YcKeyBoardView alloc]initWithFrame:CGRectMake(0, kWinSize.height-44, kWinSize.width, 44)];
    }
    [self.key setFrame:CGRectMake(0, kWinSize.height - 44, kWinSize.width, 44)];
    [self.key.textView setText:@""];
    self.key.delegate = self;
    [self.key.textView becomeFirstResponder];
    self.key.textView.returnKeyType = UIReturnKeySend;
    [self.view addSubview:self.key];
}
- (void)commentBtnClick {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *userDic = [defaults objectForKey:USERINFO];
    self.user = [UserObject objectWithKeyValues:userDic];
    NSString *parameters = [NSString stringWithFormat:@"%@,%@,%@,%@",self.msg.msgid,self.user.username,self.msg.user.username,self.comContent];
    [FtService GETmethod:KComment andParameters:parameters andHandle:^(NSDictionary *myresult) {
        NSDictionary *result = myresult;
        int status = [[result objectForKey:@"status"]intValue];
        if (status == 1) {
            self.tabBarController.selectedIndex = 1;
            [PublicObject showHUDView:self.view title:@"提示" content:@"评论成功" time:kHUDTime];
            [self getCommentInfo:self.msg.msgid];
            [self.tableView reloadData];
        }
        else{
            NSLog(@"失败");
            [PublicObject showHUDView:self.view title:@"提示" content:@"评论失败" time:kHUDTime];

        }
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }];

}
@end
