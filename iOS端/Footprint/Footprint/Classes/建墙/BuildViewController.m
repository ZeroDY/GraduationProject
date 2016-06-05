//
//  BuildViewController.m
//  FootprintWall
//
//  Created by 张浩 on 15/4/15.
//  Copyright (c) 2015年 张浩. All rights reserved.
//

#import "BuildViewController.h"
@interface BuildViewController()

@end

@implementation BuildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    switch (self.wallType) {
        case 1:
            self.title_Label.text = @"新建公开墙";
            self.titleInfo_Label.text = @"公开墙所有人都看的到哟";
            break;
        case 0:
            self.title_Label.text = @"新建私密墙";
            self.titleInfo_Label.text = @"私密墙只有你自己看得到哟";
            break;
        case 3:
            self.title_Label.text = @"新建签到墙";
            self.titleInfo_Label.text = @"签到墙";
            self.addImageBtn.hidden = YES;
            self.wallInfoTextView.hidden = YES;
            [self.backgroundImage setImage:[UIImage imageNamed:@"wall_image01"]];
            break;
        default:
            break;
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *userDic = [defaults objectForKey:USERINFO];
    self.user = [UserObject objectWithKeyValues:userDic];
    //生成wallid
    self.wallid = [self getTimeAndRandom];
    
    self.createWall_btn.backgroundColor = NavigationColor;
    self.createWall_btn.layer.cornerRadius = 2;
    self.createWall_btn.layer.masksToBounds = YES;
    self.createWall_btn.layer.borderWidth = 1;
    self.createWall_btn.layer.borderColor = (__bridge CGColorRef)([UIColor redColor]);    
   // self.wallNameLab.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    
    self.locationLab.text = KLocation;
    
    // handleSwipeFrom 是偵測到手势，所要呼叫的方法
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidenKeyboard)];
    gesture.numberOfTapsRequired = 1;
    
    [self.view addGestureRecognizer:gesture];
}

#pragma mark - 生成随机数wallid
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

- (IBAction)createWall:(id)sender {
    NSString *wallName = self.wallNameLab.text;
    NSString *wallinfo = self.wallInfoTextView.text;
    NSString *walladdress = self.locationLab.text;
    NSString *imageUrl = [NSString stringWithFormat:@"%@.png",self.wallid];
    //判断非空提示
    if ([wallName isEqualToString:@""]) {
        //请输入留言墙名称
        [PublicObject showHUDView:self.view title:@"提示" content:@"请填写留言墙名称" time:kHUDTime];
        [self performSelector:@selector(shownKeyboard:) withObject:self.wallNameLab afterDelay:kHUDTime];
        return;
    }

    if (self.wallType == 3) {
        NSString *parameters = [NSString stringWithFormat:@"%@,%@,%f,%f",wallName,self.user.username,KLongitude,KLatitude];
        [FtService GETmethod:KCreateAtdWall andParameters:parameters andHandle:^(NSDictionary *myresult) {
            NSDictionary *result = myresult;
            int status = [[result objectForKey:@"status"]intValue];
            if (status == 1) {
                self.tabBarController.selectedIndex = 1;
                [PublicObject showHUDView:self.view title:@"提示" content:@"提交成功" time:kHUDTime];
            }
            else{
                NSLog(@"失败");
                [PublicObject showHUDView:self.view title:@"提示" content:@"提交失败" time:kHUDTime];
            }
            [self dismissViewControllerAnimated:YES completion:^{
            }];
        }];
    }else{
        NSString *parameters = [NSString stringWithFormat:@"wallid=%@&wallname=%@&wallsignature=%@&username=%@&walltype=%d&x=%f&y=%f&wallimage=%@&walladress=%@",self.wallid,wallName,wallinfo,self.user.username,self.wallType,KLongitude,KLatitude,imageUrl,walladdress];
        [FtService GETmethod:KCreateWall andParameters:parameters andHandle:^(NSDictionary *myresult) {
            NSDictionary *result = myresult;
            int status = [[result objectForKey:@"status"]intValue];
            if (status == 1) {
                self.tabBarController.selectedIndex = 1;
                [PublicObject showHUDView:self.view title:@"提示" content:@"提交成功" time:kHUDTime];
            }
            else{
                NSLog(@"失败");
                [PublicObject showHUDView:self.view title:@"提示" content:@"提交失败" time:kHUDTime];
            }
            [self dismissViewControllerAnimated:YES completion:^{
            }];
        }];
    }
}

- (IBAction)refreshLocation:(id)sender {
    self.locationLab.text = @"正在刷新地址……";
    [[RefreshLocation shareInstance]RefreshLocationLable:self.locationLab andBlock:^{
    }];
}


- (IBAction)cancelClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

- (IBAction)addImage:(id)sender {
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
    
    [self.backgroundImage setImage:newImg];
    NSString *fileName = [NSString stringWithFormat:@"%@.png",self.wallid];
    [[MBProgressView shareMBProgressView] showProgressHUD:self.view title:@"正在上传"];
    [[FootService getFootService]postUploadWithUrl:[KImageUpload_URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] fileImage:newImg fileName:fileName success:^(id responseObject) {

        NSLog(@"成功");

        [[MBProgressView shareMBProgressView] dissMissProgressHUD];
        [PublicObject showHUDView:self.view title:@"提示" content:@"上传成功" time:kHUDTime];

    } fail:^{
        NSLog(@"失败");
        [[MBProgressView shareMBProgressView] dissMissProgressHUD];
        [PublicObject showHUDView:self.view title:@"提示" content:@"上传失败" time:kHUDTime];
    }];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}
//隐藏键盘的方法
- (void)hidenKeyboard {
    [self.wallNameLab resignFirstResponder];
    [self.wallInfoTextView resignFirstResponder];
}
//显示键盘的方法
- (BOOL)shownKeyboard:(UITextField *)textFiled {
    [super becomeFirstResponder];
    return [textFiled becomeFirstResponder];
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    UITextRange *selectedRange = textField.markedTextRange;
    if (selectedRange == nil || selectedRange.empty) {
        if (self.wallNameLab == textField) {//判断是否时我们想要限定的那个输入框
            if ([textField.text length] > kTitleLength) { //如果输入框内容16则弹出警告
                textField.text = [textField.text substringToIndex:kTitleLength];
                [PublicObject showHUDView:self.view title:@"注意" content:@"字数超过限制" time:kHUDTime];
            }
        }
        if (self.wallInfoTextView == textField) {//判断是否时我们想要限定的那个输入框
            if ([textField.text length] > kContentLength) { //如果输入框内容大于200则弹出警告
                textField.text = [textField.text substringToIndex:kTitleLength];
                [PublicObject showHUDView:self.view title:@"注意" content:@"字数超过限制" time:kHUDTime];
            }
        }
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@"\n"]) {//按会车可以改变
        return YES;
    }
    UITextRange * selectedRange = textField.markedTextRange;
    if (selectedRange == nil || selectedRange.empty) {
        NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
        if (self.wallNameLab == textField) {//判断是否时我们想要限定的那个输入框
            if ([toBeString length] > kTitleLength) { //如果输入框内容大于16则弹出警告
                textField.text = [toBeString substringToIndex:kTitleLength];
                [self hidenKeyboard];
                [PublicObject showHUDView:self.view title:@"注意" content:@"字数超过限制" time:kHUDTime];
                return NO;
            }
        }
        if (self.wallInfoTextView == textField) {//判断是否时我们想要限定的那个输入框
            if ([toBeString length] > kContentLength) { //如果输入框内容大于200则弹出警告
                textField.text = [toBeString substringToIndex:kTitleLength];
                [self hidenKeyboard];
                [PublicObject showHUDView:self.view title:@"注意" content:@"字数超过限制" time:kHUDTime];
                return NO;
            }
        }
    }
    return YES;
}

@end
