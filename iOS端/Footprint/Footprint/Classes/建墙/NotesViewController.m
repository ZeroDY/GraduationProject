//
//  NotesViewController.m
//  Footprint
//
//  Created by 张浩 on 15/5/4.
//  Copyright (c) 2015年 周德艺. All rights reserved.
//

#import "NotesViewController.h"

@interface NotesViewController ()

@end

@implementation NotesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //生成noteid
    self.noteid = [self getTimeAndRandom];
    
    self.noteTextView.delegate = self;
    
    // handleSwipeFrom 是偵測到手势，所要呼叫的方法
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidenKeyboard)];
    gesture.numberOfTapsRequired = 1;
    
    [self.view addGestureRecognizer:gesture];
}
//隐藏键盘的方法
- (void)hidenKeyboard {
    [self.noteTextView resignFirstResponder];
    if (self.noteTextView.text.length == 0) {
        self.noteTextView.textColor = [UIColor grayColor];
        self.noteTextView.text = @"这一刻的想法......";
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *userDic = [defaults objectForKey:USERINFO];
    self.user = [UserObject objectWithKeyValues:userDic];
}

#pragma mark textView/textField的delegate

//实现textView代理，实现placrhold效果
-(void)textViewDidBeginEditing:(UITextView *)textView{
    if (textView.text.length == 0) {
        self.noteTextView.text = @"这一刻的想法......";
        self.noteTextView.textColor = [UIColor grayColor];
        //        self.noteTextView.text = @"这一刻的想法......";
    } else {
        self.noteTextView.text = @"";
        self.noteTextView.textColor = [UIColor blackColor];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    UITextRange *selectedRange = textView.markedTextRange;
    if (selectedRange == nil || selectedRange.empty) {
        if ([textView.text length] > kContentLength) { //如果输入框内容大于200则弹出警告
            textView.text = [textView.text substringToIndex:kContentLength];
            [PublicObject showHUDView:self.view title:@"注意" content:@"字数超过限制" time:kHUDTime];
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
        if (self.noteTextView == textView) {//判断是否时我们想要限定的那个输入框
            if ([toBeString length] > kContentLength) { //如果输入框内容大于200则弹出警告
                textView.text = [toBeString substringToIndex:kContentLength];
                [self hidenKeyboard];
                [PublicObject showHUDView:self.view title:@"注意" content:@"字数超过限制" time:kHUDTime];
                
                return NO;
            }
        }
    }
    return YES;
}
/**
 *  生成noteid
 *
 *  @return noteid
 */
#pragma mark - 生成随机数
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

- (IBAction)publishClick:(id)sender {
    //http://192.168.191.1:8080/FootMarkWall/jaxrs/msgservice/createmsg/{noteid},{username},{wallid},{msgContent},{msgType},{msgStatus},{msgImage}
    NSString *noteText = self.noteTextView.text;
    NSString *wallid = @"201505032151523704";
    NSString *imageUrl = [NSString stringWithFormat:@"%@.png",self.noteid];
    NSString *parameters = [NSString stringWithFormat:@"msgid=%@&username=%@&wallid=%@&msgContent=%@&msgType=1&msgStatus=1&msgImage=%@",self.noteid,self.user.username,wallid,noteText,imageUrl];
    [FtService GETmethod:KCreateNote andParameters:parameters andHandle:^(NSDictionary *myresult) {
        NSDictionary *result = myresult;
        int status = [[result objectForKey:@"status"]intValue];
        if (status == 1) {
            self.tabBarController.selectedIndex = 1;
            [PublicObject showHUDView:self.view title:@"添加小纸条成功" content:@"" time:kHUDTime];
        }
        else{
            [PublicObject showHUDView:self.view title:@"添加小纸条失败" content:@"" time:kHUDTime];
            NSLog(@"失败");
        }
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }];
    
}

- (IBAction)cancelClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

- (IBAction)addImgClick:(id)sender {
    UIActionSheet *sheet;
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        sheet  = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选择", nil];
    }
    else {
        sheet = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相册选择", nil];
    }
    sheet.tag = 255;
    [sheet showInView:self.view];
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
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = sourceType;
        [self presentViewController:imagePickerController animated:YES completion:^{}];
    }
}
#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    /* 此处info 有六个值
     * UIImagePickerControllerMediaType; // an NSString UTTypeImage)
     * UIImagePickerControllerOriginalImage;  // a UIImage 原始图片
     * UIImagePickerControllerEditedImage;    // a UIImage 裁剪后图片
     * UIImagePickerControllerCropRect;       // an NSValue (CGRect)
     * UIImagePickerControllerMediaURL;       // an NSURL
     * UIImagePickerControllerReferenceURL    // an NSURL that references an asset in the AssetsLibrary framework
     * UIImagePickerControllerMediaMetadata    // an NSDictionary containing metadata from a captured photo
     */
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    NSData *imageData = UIImageJPEGRepresentation(image,0.5);
    UIImage *newImg = [UIImage imageWithData:imageData];
    
    [self.backImage setImage:image];
    NSString *fileName = [NSString stringWithFormat:@"%@.png",self.noteid];
    [[FootService getFootService]postUploadWithUrl:[KImageUpload_URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] fileImage:newImg fileName:fileName success:^(id responseObject) {
        NSLog(@"66666666666");
    } fail:^{
        NSLog(@"777777777777");
    }];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}
- (IBAction)delImgClick:(id)sender {
}
@end
