//
//  MessageCollectionViewController.m
//  Footprint
//
//  Created by 周德艺 on 15/5/23.
//  Copyright (c) 2015年 周德艺. All rights reserved.
//

#import "MessageCollectionViewController.h"
#import "MessageCollectionCell.h"
#import "NoteObject.h"
#import "CommentViewController.h"
#import "PopupView.h"
#import "LewPopupViewAnimationDrop.h"
#import "MessagePhotoView.h"

#define IMAGEWIDTH 120
#define IMAGEHEIGHT 160

@interface MessageCollectionViewController ()

@end

@implementation MessageCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.wall.wallname;
    
    self.titleLab = [[UILabel alloc]init];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 200, 40)];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:self.wall.wallname forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(titleClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *titleView = [[UIView alloc]init];
    titleView.backgroundColor = [UIColor clearColor];
    titleView.frame = CGRectMake(self.navigationItem.titleView.frame.origin.x, self.navigationItem.titleView.frame.origin.y,200, 40);
    self.navigationItem.titleView = titleView;
    titleView.center = self.navigationItem.titleView.center;
    [titleView addSubview:btn];
    
    [self titleClicked];
    
    
}
-(void)titleClicked{
    for(UIView *view in [self.view subviews])
    {
        [view removeFromSuperview];
    }
    if (self.isLiudong) {
        [self addReloadView];
    }else{
        // Do any additional setup after loading the view, typically from a nib.
        self.collectionView = [[PSCollectionView alloc] initWithFrame:self.view.frame];
        self.collectionView.delegate = self; // This is for UIScrollViewDelegate
        self.collectionView.collectionViewDelegate = self;
        self.collectionView.collectionViewDataSource = self;
        self.collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.collectionView.autoresizingMask = ~UIViewAutoresizingNone;
        
        UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
        [rightBtn setTitle:@"新建" forState:UIControlStateNormal];
        [rightBtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
        [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [rightBtn addTarget:self action:@selector(newNote:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
        
        self.collectionView.numColsPortrait = 2;
        self.collectionView.numColsLandscape = 10;
        [self.view addSubview:self.collectionView];
        [self.collectionView reloadData];
    }
    self.isLiudong = self.isLiudong? NO : YES;
}

-(void)viewWillAppear:(BOOL)animated{
    [self getMsgArr];
}

#pragma mark - 获取数据
-(void)getMsgArr{
    [FtService GETmethod:KFindAllMsgByWallid andParameters:self.wall.wallid andHandle:^(NSDictionary *myresult) {
        NSDictionary *result = myresult;
        int status = [[result objectForKey:@"status"]intValue];
        if (status == 1) {
            self.msgArr = [[NSMutableArray alloc]init];
            NSArray *msgDic = [result objectForKey:@"result"];
            NSArray *msgs = [NoteObject objectArrayWithKeyValuesArray:msgDic];
            self.msgArr = [[NSMutableArray alloc]initWithArray:msgs];
            for (NoteObject *n in self.msgArr) {
                [n dateFormat];
            }

            [self.collectionView reloadData];
        }
        else{
            NSLog(@"失败");
        }
    }];
}

- (IBAction)newNote:(id)sender{
    PopupView *view = [PopupView defaultPopupView];
    view.parentVC = self;
    view.user = self.user;
    view.wall = self.wall;
    [self lew_presentPopupView:view animation:[LewPopupViewAnimationDrop new] dismissed:^{
        NSLog(@"动画结束");
    }];
}

#pragma mark - PSCollectionViewDelegate and DataSource
/**
 *  行数
 */
- (NSInteger)numberOfRowsInCollectionView:(PSCollectionView *)collectionView {
    return self.msgArr.count;
}

- (UIView *)collectionView:(PSCollectionView *)collectionView cellForRowAtIndex:(NSInteger)index {
    
    MessageCollectionCell *v = (MessageCollectionCell *)[self.collectionView dequeueReusableViewForClass:[MessageCollectionCell class]];
    if (!v) {
        v = [[MessageCollectionCell alloc] initWithFrame:CGRectZero];
    }
    [v collectionView:collectionView fillCellWithObject:(NoteObject*)[self.msgArr objectAtIndex:index] atIndex:index];
    
    return v;
}

/**
 *  行高
 */
- (CGFloat)collectionView:(PSCollectionView *)collectionView heightForRowAtIndex:(NSInteger)index {
    return [MessageCollectionCell rowHeightForObject:(NoteObject*)[self.msgArr objectAtIndex:index] inColumnWidth:self.collectionView.colWidth];//150+(index%5)*20;
}

- (void)collectionView:(PSCollectionView *)collectionView didSelectCell:(PSCollectionViewCell *)cell atIndex:(NSInteger)index{
    NSLog(@"++++++++>>%d",index);
    
    CommentViewController *commentVC = [[CommentViewController alloc]initWithNibName:@"CommentViewController" bundle:nil];
    commentVC.msg = (NoteObject*)[self.msgArr objectAtIndex:index] ;
    [self.navigationController pushViewController:commentVC animated:YES];
}

#pragma mark - 添加显示流动页面
-(void) addReloadView{
    if (self.msgArr) {
        //        [self.view removeFromSuperview];
        //        [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        for (int i = 0; i < self.msgArr.count; i++) {
            NoteObject *msg = [self.msgArr objectAtIndex:i];
            
            float X = arc4random()%((int)self.view.bounds.size.width - IMAGEWIDTH);
            float Y = arc4random()%((int)self.view.bounds.size.height - IMAGEHEIGHT);
            float W = IMAGEWIDTH;
            float H = IMAGEHEIGHT;
            
            MessagePhotoView *photo = [[MessagePhotoView alloc]initWithFrame:CGRectMake(X, Y, W, H)];
            photo.msgArr = self.msgArr;
            photo.user = self.user;
            photo.msg = msg;
            photo.msgVC = self;
            //photo.infoView.collect_btn.tag = i;
            photo.infoView.goNext_btn.tag = i;
            NSString *urlStr = [NSString stringWithFormat:@"%@%@",KGetImage_URL,msg.msgimage];
            [photo updateImageWithURL:[NSURL URLWithString:urlStr]];

            [self.view addSubview:photo];
            /**
             *  修改速度
             */
            float alpha = i*1.0/10+0.8;//+ 0.8;
            float speed = (i%10)/2+1;//(i+1)*1.0/50;
            float framex = (i%4)/2.2;
            switch (i%4) {
                case 0:
                    framex = 0.8;
                    break;
                case 1:
                    framex = 0.92;
                    break;
                case 2:
                    framex = 1.04;
                    break;
                case 3:
                    framex = 1.16;
                    break;
                case 4:
                    framex = 1.28;
                    break;
                    
                default:
                    break;
            }
            //  [photo setImageAlphaAndSpeedAndSize:alpha];
            [photo setImageAlphaAndSpeedAndSize:alpha speed:speed framex:framex framey:framex];
            
            [self.photos addObject:photo];
        }
    }
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleTap)];
    [doubleTap setNumberOfTapsRequired:2];
    [self.view addGestureRecognizer:doubleTap];
    
    [self.view addSubview:self.cancelBtn];
}


/**
 *  双击重新排列
 */
- (void)doubleTap {
    
    NSLog(@"DoubleTap...........");
    for (MessagePhotoView *photo in self.photos) {
        if (photo.state == XYZPhotoStateDraw || photo.state == XYZPhotoStateBig) {
            return;
        }
    }
    
    float W = (self.view.bounds.size.width - 20) / 3;
    float H = (self.view.bounds.size.height - 64) / 3;
    
    [UIView animateWithDuration:1 animations:^{
        for (int i = 0; i < self.photos.count; i++) {
            MessagePhotoView *photo = [self.photos objectAtIndex:i];
            
            if (photo.stateInVC == XYZPhotoStateNormal) {
                if (photo.isOld == 0) {
                    photo.normalAlpha = photo.alpha;
                    photo.normalFrame = photo.frame;
                    photo.normalSpeed = photo.speed;
                    photo.isOld = 1;
                }
                photo.alpha = 1;
                photo.frame = CGRectMake( i%3 * W + 5*( i%3 + 1 ), i/3*H + 5*( i/3 + 1 )+44, W, H);
                photo.imageView.frame = photo.bounds;
                photo.infoView.frame = photo.bounds;
                
                photo.infoView.info_Label.frame = CGRectMake(photo.infoView.frame.size.width/2-80, photo.infoView.frame.size.height/2-40, 160, 80);
                photo.infoView.goNext_btn.frame = CGRectMake(0, photo.infoView.frame.size.height-44, photo.infoView.frame.size.width, 44);
               // photo.infoView.collect_btn.frame = CGRectMake(photo.infoView.frame.size.width-40, 0, 40, 40);
                
                photo.speed = 0;
                photo.stateInVC = XYZPhotoStateTogether;
            } else if (photo.stateInVC == XYZPhotoStateTogether) {
                photo.alpha = photo.normalAlpha;
                photo.frame = photo.normalFrame;
                photo.speed = photo.normalSpeed;
                photo.imageView.frame = photo.bounds;
                photo.infoView.frame = photo.bounds;
                
                photo.infoView.info_Label.frame = CGRectMake(0,0,0,0);
                photo.infoView.goNext_btn.frame = CGRectMake(0, 0, 0, 0);
             //   photo.infoView.collect_btn.frame = CGRectMake(0, 0, 0, 0);
                
                photo.stateInVC = XYZPhotoStateNormal;
            }
        }
        
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end

