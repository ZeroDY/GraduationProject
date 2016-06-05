//
//  MessageViewController.m
//  Footprint
//
//  Created by 周德艺 on 15/5/4.
//  Copyright (c) 2015年 周德艺. All rights reserved.
//

#import "MessageViewController.h"
#import "MessagePhotoView.h"
#import "NoteObject.h"
#import "CollectMsgObject.h"
#import "CommentViewController.h"


#define IMAGEWIDTH 120
#define IMAGEHEIGHT 160

@interface MessageViewController ()
@end

@implementation MessageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.photos = [[NSMutableArray alloc]init];
    [self getMsgArr];
    
    UIImageView *bgImage = [[UIImageView alloc]initWithFrame:self.view.frame];
    bgImage.image = [UIImage imageNamed:@"wall_image04"];
    bgImage.contentMode =  UIViewContentModeScaleAspectFill;
    
    self.cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, 20, 38, 38)];
    [self.cancelBtn setImage:[UIImage imageNamed:@"cancel2"] forState:UIControlStateNormal];
    [self.cancelBtn addTarget:self action:@selector(cancelVC) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:bgImage];
    [self.view addSubview:self.cancelBtn];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [self getCollectMsgArr];

    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.hidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = NO;
    self.navigationController.navigationBar.hidden = NO;
}

- (void)cancelVC{
    [self.navigationController popViewControllerAnimated:YES];
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
            [self addReloadView];
        }
        else{
            NSLog(@"失败");
        }
    }];
}
#pragma mark - 刷新收藏数据
-(void)reloadCollectMsgArr{
    [FtService GETmethod:KFindCollectMsgsByUN andParameters:self.user.username andHandle:^(NSDictionary *myresult) {
        NSDictionary *result = myresult;
        int status = [[result objectForKey:@"status"]intValue];
        if (status == 1) {
            NSArray *wallDic = [result objectForKey:@"result"];
            NSArray *collectMsgs = [CollectMsgObject objectArrayWithKeyValuesArray:wallDic];
            self.collectMsgArr = [[NSMutableArray alloc]initWithArray:collectMsgs];
        }
        else{
            NSLog(@"失败");
        }
    }];
}
#pragma mark - 获取收藏数据
-(void)getCollectMsgArr{
    [FtService GETmethod:KFindCollectMsgsByUN andParameters:self.user.username andHandle:^(NSDictionary *myresult) {
        NSDictionary *result = myresult;
        int status = [[result objectForKey:@"status"]intValue];
        if (status == 1) {
            NSArray *wallDic = [result objectForKey:@"result"];
            NSArray *collectMsgs = [CollectMsgObject objectArrayWithKeyValuesArray:wallDic];
            self.collectMsgArr = [[NSMutableArray alloc]initWithArray:collectMsgs];
            [self addReloadView];
        }
        else{
            NSLog(@"失败");
        }
    }];
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
           // photo.infoView.collect_btn.tag = i;
            photo.infoView.goNext_btn.tag = i;
            NSString *urlStr = [NSString stringWithFormat:@"%@%@",KGetImage_URL,msg.msgimage];
            [photo updateImageWithURL:[NSURL URLWithString:urlStr]];
//            for (CollectMsgObject *cltMsg in self.collectMsgArr) {
//                if([cltMsg.msgid isEqualToString:msg.msgid]){
//                    [photo.infoView.collect_btn setImage:[UIImage imageNamed:@"shoucang1"] forState:UIControlStateNormal];
//                }
//            }
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
               // photo.infoView.collect_btn.frame = CGRectMake(0, 0, 0, 0);
                
                photo.stateInVC = XYZPhotoStateNormal;
            }
        }
        
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
