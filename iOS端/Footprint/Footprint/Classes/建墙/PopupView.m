//
//  PopupView.m
//  LewPopupViewController
//
//  Created by deng on 15/3/5.
//  Copyright (c) 2015年 pljhonglu. All rights reserved.
//

#import "PopupView.h"
#import "UIViewController+LewPopupViewController.h"
#import "LewPopupViewAnimationFade.h"
#import "LewPopupViewAnimationSlide.h"
#import "LewPopupViewAnimationSpring.h"
#import "LewPopupViewAnimationDrop.h"
#import "MessageCollectionViewController.h"

@implementation PopupView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [[NSBundle mainBundle] loadNibNamed:[[self class] description] owner:self options:nil];
        _innerView.frame = frame;
        self.note_textView = [[UITextView alloc]initWithFrame: CGRectMake(8, 8, [UIScreen mainScreen].bounds.size.width*0.85-16 , self.boxView.frame.size.height)];
        [self.note_textView setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
        [self.note_textView setTextAlignment:NSTextAlignmentCenter];
        [self.note_textView setFont:[UIFont systemFontOfSize:16]];
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        [self.imageView setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
        [self.boxView addSubview:self.note_textView];
        [self.boxView addSubview:self.imageView];
        self.msgid = [self getTimeAndRandom];
        [self addSubview:_innerView];
        
        self.image = [[UIImage alloc]init];
        self.imgSize = self.image.size;
        self.msgimgName = @"defaultx200x200.png";
        
        self.note_textView.textColor = [UIColor grayColor];
        self.note_textView.text = @"这一刻的想法......";
        self.note_textView.delegate = self;
//        // handleSwipeFrom 是偵測到手势，所要呼叫的方法
//        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidenKeyboard)];
//        gesture.numberOfTapsRequired = 1;
//        
//        [self addGestureRecognizer:gesture];
        //在弹出的键盘上面加一个view来放置退出键盘的Done按钮
        UIToolbar * topView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
        [topView setBarStyle:UIBarStyleDefault];
        UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        UIBarButtonItem * doneButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(hidenKeyboard1)];
        
        NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace, doneButton, nil];
        [topView setItems:buttonsArray];
        [self.note_textView setInputAccessoryView:topView];
    }
    return self;
}


+ (instancetype)defaultPopupView{
    PopupView *view = [[PopupView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width*0.85 , [UIScreen mainScreen].bounds.size.height*0.4)];
    return view;
}

- (IBAction)dismissAction:(id)sender{
    [_parentVC lew_dismissPopupView];
}

-(IBAction)addImage:(id)sender{
    
    UIActionSheet *sheet;
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        sheet  = [[UIActionSheet alloc] initWithTitle:@"选择留言墙图片" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选择", nil];
    }
    else {
        sheet = [[UIActionSheet alloc] initWithTitle:@"选择留言墙图片" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相册选择", nil];
    }
    sheet.tag = 255;
    [sheet showInView:self];
}

- (IBAction)dismissViewSpringAction:(id)sender{
    NSString *contentView = self.note_textView.text;
    if ([contentView isEqualToString:@""]||[contentView isEqualToString:@"这一刻的想法......"]) {
        //请输入小纸条内容
        [PublicObject showHUDView:self title:@"提示" content:@"请输入小纸条内容" time:kHUDTime];
        [self performSelector:@selector(shownKeyboard:) withObject:self.note_textView afterDelay:kHUDTime];
        return;
    }
    if (self.image.size.height != 0) {
        [[MBProgressView shareMBProgressView] showProgressHUD:self title:@"正在上传"];
        [FtService postUploadWithUrl:[KImageUpload_URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] fileImage:self.image fileName:self.msgimgName success:^(id responseObject) {
            [[MBProgressView shareMBProgressView] dissMissProgressHUD];
            [PublicObject showHUDView:self title:@"提示" content:@"上传成功" time:kHUDTime];
            NSLog(@"66666666666");
        } fail:^{
            NSLog(@"777777777777");
            [[MBProgressView shareMBProgressView] dissMissProgressHUD];
            [PublicObject showHUDView:self title:@"提示" content:@"上传失败" time:kHUDTime];
        }];
    }

    
    NSString *msgcontent = self.note_textView.text;
    NSString *parameters = [NSString stringWithFormat:@"msgid=%@&wallid=%@&msgContent=%@&username=%@&&msgImage=%@",self.msgid,self.wall.wallid,msgcontent,self.user.username,self.msgimgName];
    [FtService GETmethod:KCreateNote andParameters:parameters andHandle:^(NSDictionary *myresult) {
        NSDictionary *result = myresult;
        int status = [[result objectForKey:@"status"]intValue];
        if (status == 1) {
            NSLog(@"chenggong");
            [PublicObject showHUDView:self title:@"提示" content:@"提交成功" time:kHUDTime];
        }
        else{
            NSLog(@"失败");
            [PublicObject showHUDView:self title:@"提示" content:@"提交失败" time:kHUDTime];
        }
        MessageCollectionViewController *mVC = (MessageCollectionViewController*)_parentVC;
        [mVC getMsgArr];
        [_parentVC lew_dismissPopupViewWithanimation:[LewPopupViewAnimationSpring new]];
    }];
}


#pragma mark - 生成随机数noteid
-(NSString*)getTimeAndRandom{
    int iRandom=arc4random()%10000;
    if (iRandom<0) {
        iRandom=-iRandom;
    }
    NSDateFormatter *tFormat=[[NSDateFormatter alloc] init];
    [tFormat setDateFormat:@"yyyyMMddHHmmss"];
    NSString *tResult=[NSString stringWithFormat:@"%@%d",[tFormat stringFromDate:[NSDate date]],iRandom];
    return tResult;
}
#pragma mark 选择照片
//上传图片
-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 255) {
        NSUInteger sourceType = 0;
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            switch (buttonIndex) {
                case 0:
                    // 取消
                    return;
                case 1:
                    // 相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                case 2:
                    // 相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
            }
        }
        else {
            if (buttonIndex == 0) {
                return;
            } else {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.sourceType = sourceType;
        [self.parentVC presentViewController:imagePickerController animated:YES completion:^{}];
    }
}

#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    UIImage *selectImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    UIImage* newImage = [PublicObject fixOrientation:selectImage];
    NSData *imageData = UIImageJPEGRepresentation(newImage,0.5);
    self.image = [UIImage imageWithData:imageData];
    self.imgSize = self.image.size;
    self.msgimgName = [NSString stringWithFormat:@"%@x%dx%d.png",self.msgid,(int)self.imgSize.width,(int)self.imgSize.height];
    /**
     *  修改大小
     */
    self.note_textView.frame = CGRectMake(self.note_textView.frame.origin.x, self.note_textView.frame.origin.y, self.note_textView.frame.size.width , 40);
    self.imageView.frame = CGRectMake(self.note_textView.frame.origin.x, self.note_textView.frame.origin.y+self.note_textView.frame.size.height+5, self.note_textView.frame.size.width , self.note_textView.frame.size.width*self.imgSize.height/self.imgSize.width);
    self.frame = CGRectMake(self.frame.origin.x, ([UIScreen mainScreen].bounds.size.height-(self.imageView.frame.size.height+160))/2, self.frame.size.width , self.imageView.frame.size.height+160);
    [self.imageView setImage:self.image];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.parentVC dismissViewControllerAnimated:YES completion:^{}];
}
#pragma mark textView/textField的delegate

//实现textView代理，实现placrhold效果
-(void)textViewDidBeginEditing:(UITextView *)textView{
    if (textView.text.length == 0) {
        self.note_textView.text = @"这一刻的想法......";
        self.note_textView.textColor = [UIColor grayColor];
        //        self.noteTextView.text = @"这一刻的想法......";
    } else {
        self.note_textView.text = @"";
        self.note_textView.textColor = [UIColor blackColor];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    UITextRange *selectedRange = textView.markedTextRange;
    if (selectedRange == nil || selectedRange.empty) {
        if ([textView.text length] > kContentLength) { //如果输入框内容大于200则弹出警告
            textView.text = [textView.text substringToIndex:kContentLength];
            [PublicObject showHUDView:self title:@"注意" content:@"字数超过限制" time:kHUDTime];
        }
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {//按会车可以改变
        return YES;
    }
    
    UITextRange * selectedRange = textView.markedTextRange;
    if (selectedRange == nil || selectedRange.empty) {
        NSString * toBeString = [textView.text stringByReplacingCharactersInRange:range withString:text]; //得到输入框的内容
        if (self.note_textView == textView) {//判断是否时我们想要限定的那个输入框
            if ([toBeString length] > kContentLength) { //如果输入框内容大于200则弹出警告
                textView.text = [toBeString substringToIndex:kContentLength];
                [self hidenKeyboard1];
                [PublicObject showHUDView:self title:@"注意" content:@"字数超过限制" time:kHUDTime];
                
                return NO;
            }
        }
    }
    return YES;
}
//隐藏键盘的方法
- (void)hidenKeyboard1 {
    [self.note_textView resignFirstResponder];
    if (self.note_textView.text.length == 0) {
        self.note_textView.textColor = [UIColor grayColor];
        self.note_textView.text = @"这一刻的想法......";
    }
}
//显示键盘的方法
- (BOOL)shownKeyboard:(UITextView *)textView {
    [super becomeFirstResponder];
    return [textView becomeFirstResponder];
}
@end
