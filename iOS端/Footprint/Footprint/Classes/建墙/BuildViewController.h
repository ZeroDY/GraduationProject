//
//  BuildViewController.h
//  FootprintWall
//
//  Created by 张浩 on 15/4/15.
//  Copyright (c) 2015年 张浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuildViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, strong) NSString *wallid;
@property (nonatomic, strong) NSString *wallImageName;
@property (nonatomic, strong) UserObject *user;
@property (nonatomic) int wallType;

@property (weak, nonatomic) IBOutlet UILabel *title_Label;
@property (weak, nonatomic) IBOutlet UILabel *titleInfo_Label;

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIButton *addImageBtn;
@property (weak, nonatomic) IBOutlet UIButton *createWall_btn;
@property (weak, nonatomic) IBOutlet UILabel *locationLab;
@property (weak, nonatomic) IBOutlet UITextField *wallNameLab;
@property (weak, nonatomic) IBOutlet UITextField *wallInfoTextView;

- (IBAction)addImage:(id)sender;
- (IBAction)cancelClick:(id)sender;
- (NSString*)getTimeAndRandom;
- (IBAction)createWall:(id)sender;
- (IBAction)refreshLocation:(id)sender;

@end
