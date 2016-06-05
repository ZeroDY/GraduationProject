//
//  NotesViewController.h
//  Footprint
//
//  Created by 张浩 on 15/5/4.
//  Copyright (c) 2015年 周德艺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotesViewController : UIViewController<UITextViewDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, strong) NSString *noteid;
@property (nonatomic, strong) UserObject *user;

@property (weak, nonatomic) IBOutlet UIImageView *backImage;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *publishBtn;
@property (weak, nonatomic) IBOutlet UITextView *noteTextView;
@property (weak, nonatomic) IBOutlet UIButton *addImgBtn;



- (IBAction)publishClick:(id)sender;
- (IBAction)cancelClick:(id)sender;
- (IBAction)addImgClick:(id)sender;



@end
