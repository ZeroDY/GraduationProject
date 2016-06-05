//
//  MessagePhotoView.m
//  Footprint
//
//  Created by 周德艺 on 15/5/4.
//  Copyright (c) 2015年 周德艺. All rights reserved.
//

#import "MessagePhotoView.h"
#import "MessageInfoView.h"
#import "CommentViewController.h"

@implementation MessagePhotoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor blackColor];
        self.imageView = [[UIImageView alloc]initWithFrame:self.bounds];
        self.infoView = [[MessageInfoView alloc]initWithFrame:self.bounds];
        [self.infoView.goNext_btn addTarget:self action:@selector(goNextView:) forControlEvents:UIControlEventTouchUpInside];
        
//        [self.infoView.collect_btn addTarget:self action:@selector(isCollect:) forControlEvents:UIControlEventTouchUpInside];
        
//        self.button = [[UIButton alloc]initWithFrame:CGRectMake(0, self.frame.size.height-40, self.frame.size.width, 40)];
//        [self.button setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.4]];
//        [self.button setTitle:@"进  入" forState:UIControlStateNormal];
//        [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [self.button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
        
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.infoView.contentMode = UIViewContentModeScaleAspectFit;
        
        
        //[self.drawView addSubview:self.imageView];
        [self addSubview:self.infoView];
        [self addSubview:self.imageView];
        [self.infoView setHidden:YES];
        //[self addSubview:self.button];
        
        NSTimer *timer = [NSTimer timerWithTimeInterval:0.02 target:self selector:@selector(movePhotos) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:@"NSDefaultRunLoopMode"];
        
        self.layer.borderWidth = 2;
        self.layer.borderColor = [[UIColor whiteColor] CGColor];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImage)];
        [self addGestureRecognizer:tap];
        
        UISwipeGestureRecognizer *swip = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipImage)];
        [swip setDirection:UISwipeGestureRecognizerDirectionLeft | UISwipeGestureRecognizerDirectionRight];
        [self addGestureRecognizer:swip];
        
        
    }
    return self;
}



- (void)tapImage {
    
    [UIView animateWithDuration:0.5 animations:^{
        if (self.state == XYZPhotoStateNormal) {
            if (self.isOld == 0) {
                self.normalFrame = self.frame;
                self.normalAlpha = self.alpha;
                self.normalSpeed = self.speed;
                self.isOld = 1;
            }
            self.oldFrame = self.frame;
            self.oldAlpha = self.alpha;
            self.oldSpeed = self.speed;
            self.frame = CGRectMake(20, 80, self.superview.bounds.size.width - 40, self.superview.bounds.size.height - 100);
            self.imageView.frame = self.bounds;
            
            self.infoView.frame = self.bounds;
            self.infoView.info_Label.frame = CGRectMake(self.infoView.frame.size.width/2-100, self.infoView.frame.size.height/2-120, 200, 180);
            [self.infoView.info_Label setText:self.msg.msgcontent];
            self.infoView.goNext_btn.frame = CGRectMake(0, self.infoView.frame.size.height-48, self.infoView.frame.size.width, 48);
           // self.infoView.collect_btn.frame = CGRectMake(self.infoView.frame.size.width-30, 0, 30, 30);
            
            [self.superview bringSubviewToFront:self];
            self.speed = 0;
            self.alpha = 1;
            self.state = XYZPhotoStateBig;
            
        } else if (self.state == XYZPhotoStateBig || self.state == XYZPhotoStateDraw) {
            if (self.state == XYZPhotoStateDraw) {
                [self.infoView setHidden:YES];
                [self exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
            }
            self.frame = self.oldFrame;
            self.alpha = self.oldAlpha;
            self.speed = self.oldSpeed;
            self.imageView.frame = self.bounds;
            self.infoView.frame = self.bounds;
            self.infoView.info_Label.frame = CGRectMake(0, 0, 0, 0);
            self.infoView.goNext_btn.frame = CGRectMake(0, 0, 0, 0);
          //  self.infoView.collect_btn.frame = CGRectMake(0, 0, 0, 0);
            self.state = XYZPhotoStateNormal;
        }
        
    }];
    
}

- (void)swipImage {
    
    if (self.state == XYZPhotoStateBig) {
        [self.infoView setHidden:NO];
        [self exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
        self.state = XYZPhotoStateDraw;
    } else if (self.state == XYZPhotoStateDraw){
        [self.infoView setHidden:YES];
        [self exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
        self.state = XYZPhotoStateBig;
    }
}


- (IBAction)goNextView:(id)sender {
    NSLog(@"aaaaaaaa");
    CommentViewController *commentVC = [[CommentViewController alloc]initWithNibName:@"CommentViewController" bundle:nil];
    commentVC.msg = self.msg;
    MessageViewController *vc = (MessageViewController *)self.msgVC;
    [vc.navigationController pushViewController:commentVC animated:YES];
}

- (IBAction)isCollect:(id)sender {
    NSLog(@"dddddd");
    UIButton *button = (UIButton *)sender;
    NoteObject *msg = [self.msgArr objectAtIndex:button.tag];
    NSString *params = [NSString stringWithFormat:@"%@,%@",self.user.username,msg.msgid];
    
    [FtService GETmethod:KCollectMsg andParameters:params andHandle:^(NSDictionary *myresult) {
        NSDictionary *result = myresult;
        int status = [[result objectForKey:@"status"]intValue];
        if (status == 1) {
            MessageViewController *vc = (MessageViewController *)self.msgVC;
            [vc reloadCollectMsgArr];

            NSString *resultStr = [result objectForKey:@"result"];
//            if ([resultStr isEqualToString:@"collect"]) {
//                for (int i = 0 ; i < vc.photos.count ; i++) {
//                    if (i == button.tag) {
//                        [self.infoView.collect_btn setImage:[UIImage imageNamed:@"shoucang1"] forState:UIControlStateNormal];
//                    }
//                }
//            }else{
//                for (int i = 0 ; i < vc.photos.count ; i++) {
//                    if (i == button.tag) {
//                        [self.infoView.collect_btn setImage:[UIImage imageNamed:@"shoucang2"] forState:UIControlStateNormal];
//                    }
//                }
//            }
            
        }
        else{
            NSLog(@"失败");
        }
    }];
}


- (void)updateImage:(UIImage *)image {
    self.imageView.image = image;
    NSLog(@"image......");
}

-(void)updateImageWithURL:(NSURL *)imageUrl{
    [self.imageView sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"1364210605418.jpg"]];
}


- (void)setImageAlphaAndSpeedAndSize:(float)alpha {
    self.alpha = alpha;
    self.speed = alpha;
    self.transform = CGAffineTransformScale(self.transform, alpha, alpha);
}

-(void)setImageAlphaAndSpeedAndSize:(float)alpha speed:(float)speed framex:(float)frameX framey:(float)frameY{
    self.alpha = alpha;
    self.speed = speed;
    self.transform = CGAffineTransformScale(self.transform, frameX, frameY);
}

- (void)movePhotos {
    self.center = CGPointMake(self.center.x + self.speed, self.center.y);
    if (self.center.x > self.superview.bounds.size.width + self.frame.size.width/2) {
        self.center = CGPointMake(-self.frame.size.width/2, arc4random()%(int)(self.superview.bounds.size.height - self.bounds.size.height) + self.bounds.size.height/2);
    }
}


@end
