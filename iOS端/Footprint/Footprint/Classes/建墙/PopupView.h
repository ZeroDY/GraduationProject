//
//  PopupView.h
//  LewPopupViewController
//
//  Created by deng on 15/3/5.
//  Copyright (c) 2015年 pljhonglu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WallObject.h"

@interface PopupView : UIView<UITextViewDelegate>
@property (nonatomic, strong)IBOutlet UIView *innerView;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIView *boxView;

@property (nonatomic, weak) UIViewController<UIImagePickerControllerDelegate> *parentVC;
@property (nonatomic, strong) UIImageView *imageView;
@property (strong, nonatomic) UITextView *note_textView;
@property (strong, nonatomic) UserObject *user;
@property (strong, nonatomic) WallObject *wall;
@property (strong, nonatomic) NSString *msgid;
@property (strong, nonatomic) NSString *msgcontent;
@property (strong, nonatomic) NSString *msgimgName;
@property (strong, nonatomic) UIImage *image;
@property (nonatomic) CGSize imgSize;

+ (instancetype)defaultPopupView;
@end
