//
//  ReportViewController.m
//  Footprint
//
//  Created by 张浩 on 15/6/9.
//  Copyright (c) 2015年 周德艺. All rights reserved.
//

#import "ReportViewController.h"
#import "UIViewController+MMDrawerController.h"

@interface ReportViewController ()

@end

@implementation ReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"举报";
    self.reportContentTextView.delegate = self;
    //导航栏右侧的新建按钮
//    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
//    [rightBtn setTitle:@"新建" forState:UIControlStateNormal];
//    [rightBtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
//    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//    [rightBtn addTarget:self action:@selector(buildNewWall) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 38, 38)];
    [leftBtn setImage:[UIImage imageNamed:@"leftMenu"] forState:UIControlStateNormal];
    //leftBtn.layer.shouldRasterize = YES;
//    leftBtn.clipsToBounds = YES;
//    leftBtn.layer.masksToBounds = YES;
//    leftBtn.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
//    leftBtn.layer.borderWidth = 2.0f;
//    leftBtn.layer.cornerRadius = leftBtn.frame.size.width / 2;
    //    [leftBtn setTitle:@"个人" forState:UIControlStateNormal];
    //    [leftBtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
    //    [leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [leftBtn addTarget:self action:@selector(leftDrawerButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    
    self.reportContentTextView.text = @"请填写举报内容......";
    self.reportContentTextView.textColor = [UIColor grayColor];
    self.submitBtn.backgroundColor = DominantColor;

    
    // handleSwipeFrom 是偵測到手势，所要呼叫的方法
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidenKeyboard)];
    gesture.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:gesture];
}
#pragma mark ToolBar -textView/textField的delegate

//实现textView代理，实现placrhold效果
-(void)textViewDidBeginEditing:(UITextView *)textView{
    if (textView.text.length == 0) {
        self.reportContentTextView.text = @"请填写举报内容......";
        self.reportContentTextView.textColor = [UIColor grayColor];
    } else {
        self.reportContentTextView.text = @"";
        self.reportContentTextView.textColor = [UIColor blackColor];
        UITextRange *selectedRange = textView.markedTextRange;
        if (selectedRange == nil || selectedRange.empty) {
            if ([textView.text length] > kContentLength) { //如果输入框内容大于200则弹出警告
                textView.text = [textView.text substringToIndex:kContentLength];
                [PublicObject showHUDView:self.view title:@"注意" content:@"字数超过限制" time:kHUDTime];
            }
        }
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
        if (self.reportContentTextView == textView) {//判断是否时我们想要限定的那个输入框
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
#pragma mark - Button Handlers
-(void)leftDrawerButtonPress:(id)sender{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)submitClick:(id)sender {
    if (self.reportContentTextView.text.length == 0) {
        [PublicObject showHUDView:self.view title:@"请输入举报内容" content:@"" time:kHUDTime];
        return;
    }
    [PublicObject showHUDView:self.view title:@"提示" content:@"举报成功" time:kHUDTime];

}
#pragma mark - 生成随机数reportId
-(NSString*)getTimeAndRandom{
    int iRandom=arc4random()%10000;
    if (iRandom<0) {
        iRandom=-iRandom;
    }
    NSDateFormatter *tFormat=[[NSDateFormatter alloc] init];
    [tFormat setDateFormat:@"yyyyMMddHHmmss"];
    NSString *tResult=[NSString stringWithFormat:@"%d%@",iRandom,[tFormat stringFromDate:[NSDate date]]];
    return tResult;
}
//隐藏键盘的方法
- (void)hidenKeyboard {
    [self.reportContentTextView resignFirstResponder];
}
//显示键盘的方法
- (BOOL)shownKeyboard:(UITextView *)textView{
    [super becomeFirstResponder];
    return [textView becomeFirstResponder];
}

- (IBAction)imageClick:(id)sender {
    UIActionSheet *sheet;
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        sheet  = [[UIActionSheet alloc] initWithTitle:@"选择图片" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选择", nil];
    }
    else {
        sheet = [[UIActionSheet alloc] initWithTitle:@"选择图片" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相册选择", nil];
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
    UIImage *selectImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    UIImage* newImage = [PublicObject fixOrientation:selectImage];
    NSData *imageData = UIImageJPEGRepresentation(newImage,0.5);
    UIImage *newImg = [UIImage imageWithData:imageData];
    //    CGSize imgSize = newImg.size;
    //    self.wallImageName = [NSString stringWithFormat:@"%@x%fx%f",self.wallid,imgSize.width,imgSize.height];
    
    [self.imageBtn setImage:newImg forState:UIControlStateNormal];
    self.reportid = [self getTimeAndRandom];
    NSString *fileName = [NSString stringWithFormat:@"%@.png",self.reportid];
    [[MBProgressView shareMBProgressView] showProgressHUD:self.view title:@"正在上传"];
    [[FootService getFootService]postUploadWithUrl:[KImageUpload_URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] fileImage:newImg fileName:fileName success:^(id responseObject) {
        [[MBProgressView shareMBProgressView] dissMissProgressHUD];
        [PublicObject showHUDView:self.view title:@"提示" content:@"上传成功" time:kHUDTime];
        NSLog(@"66666666666");
    } fail:^{
        NSLog(@"777777777777");
        [[MBProgressView shareMBProgressView] dissMissProgressHUD];
        [PublicObject showHUDView:self.view title:@"提示" content:@"上传失败" time:kHUDTime];
    }];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}

@end
