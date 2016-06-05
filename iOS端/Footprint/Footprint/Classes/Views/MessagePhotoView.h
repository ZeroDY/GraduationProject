//
//  MessagePhotoView.h
//  Footprint
//
//  Created by 周德艺 on 15/5/4.
//  Copyright (c) 2015年 周德艺. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageInfoView.h"
#import "NoteObject.h"
#import "MessageViewController.h"

typedef NS_ENUM(NSInteger, XYZPhotoState) {
    XYZPhotoStateNormal,
    XYZPhotoStateBig,
    XYZPhotoStateDraw,
    XYZPhotoStateTogether
};

@interface MessagePhotoView : UIView

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) MessageInfoView *infoView;
//@property (nonatomic, strong) UIButton *button;
@property (nonatomic) float speed;
@property (nonatomic) CGRect oldFrame;
@property (nonatomic) float oldSpeed;
@property (nonatomic) float oldAlpha;

@property (nonatomic) int isOld;
@property (nonatomic)  CGRect normalFrame;
@property (nonatomic)  float normalSpeed;
@property (nonatomic)  float normalAlpha;
@property (nonatomic,strong) NoteObject *msg;

@property(nonatomic, strong) NSMutableArray *msgArr;
@property(nonatomic, strong) UserObject *user;
@property(nonatomic, strong) MessageViewController *msgVC;

@property (nonatomic) int state;
@property (nonatomic) int stateInVC;


- (void)updateImage:(UIImage *)image;
- (void)updateImageWithURL:(NSURL *)imageUrl;
- (void)setImageAlphaAndSpeedAndSize:(float)alpha;
- (void)setImageAlphaAndSpeedAndSize:(float)alpha speed:(float)speed framex:(float)frameX framey:(float)frameY;

@end
