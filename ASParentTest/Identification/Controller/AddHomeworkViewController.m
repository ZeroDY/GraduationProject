//
//  AddHomeworkViewController.m
//  ASTeacher
//
//  Created by 周德艺 on 15/11/23.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "AddHomeworkViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "HomeworkInfoViewController.h"
//接口
#import "DYRequestBase+SearchHomeWorkDetail.h"

@interface AddHomeworkViewController ()<UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *jiezhiTime_btn;
@property (weak, nonatomic) IBOutlet UITextView *info_textView;

@property (weak, nonatomic) IBOutlet UIView *imageBackgroundView;

@property (weak, nonatomic) IBOutlet UIView *homeWorkInfoView;

@property (nonatomic ,strong) ALAssetsLibrary *assetslibrary;
@property (strong, nonatomic) UIButton *addImage_btn;
@property (nonatomic, strong) UIBarButtonItem *saveHomeworkItem;

@property (nonatomic, strong) NSString *classCode;
@property (nonatomic, strong) NSMutableArray *classArray;
@property (nonatomic, strong) NSMutableArray *imageList;

@end

@implementation AddHomeworkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"拍照答题";
    
    self.navigationItem.rightBarButtonItem = self.saveHomeworkItem;
    
        //一个点击事件
    self.homeWorkInfoView.userInteractionEnabled = YES;
    UITapGestureRecognizer *click = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addClassAction:)];
    [self.homeWorkInfoView addGestureRecognizer:click];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getClassInfo];
    [self reloadPhotosView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)getClassInfo{
    AccoutObject *userObj = [PublicObject getUserInfoDefault];
    
    [DYRequestBase SearchHomeWorkDetailByUserId:userObj.idcode HomeWorkId:self.homeworkId requestStartBlock:^{
        [PublicObject showHUDBegain:self.view title:@"正在获取……"];
    } responseBlock:^(id dataObj, NSError *error) {
        [PublicObject dissMissHUDEnd];
        if (dataObj) {
            int status = [[dataObj objectForKey:@"status"] intValue];
            NSString *msg = [PublicObject convertNullString:[dataObj objectForKey:@"msg"]];
            if (status == 0) {
                NSDictionary *objDic = [dataObj objectForKey:@"obj"];
                NSLog(@"%@",objDic);
                //json转对象
                self.workDetailObj= [WorkPushDetailObject mj_objectWithKeyValues:objDic];
                [self.jiezhiTime_btn setTitle:self.workDetailObj.lastname forState:UIControlStateNormal];
            } else {
                [PublicObject showHUDView:self.view title:msg content:@"" time:kHUDTime andCodes:^{
                }];
            }
        }else{
            [PublicObject showHUDView:self.view title:@"请求失败" content:@"" time:kHUDTime andCodes:^{
            }];
        }
    }];
}


- (IBAction)saveImages:(id)sender{
//    if ([self.title_fd.text isEqualToString:@""] ||
//        //self.zuCode == nil ||
//        [self.info_textView.text isEqualToString:@""]) {
//        [MBProgressHUD showError:@"请完善发布信息"];
//        return;
//    }
//    [MBProgressHUD showMessage:@"正在上传图片……"];
//    [[DYNetworkRequest shareDYNetworkRequest]uploadImageListRequest:kImageUpload_URL params:nil imageList:self.imageList successAndProgress:^(int64_t bytesWritten, int64_t totalBytesWritten, int64_t totalBytesExpectedToWrite) {
//        NSLog(@"----------------------------------------------------------------------------------------");
//        NSLog(@"bytesWritten-----%lld",bytesWritten);
//        NSLog(@"totalBytesWritten-----%lld",totalBytesWritten);
//        NSLog(@"totalBytesExpectedToWrite-----%lld",totalBytesExpectedToWrite);
//        NSLog(@"persent-----%.2f",(totalBytesWritten*1.0)/(totalBytesExpectedToWrite*1.0) * 100.0);
//        NSLog(@"----------------------------------------------------------------------------------------");
//    } complete:^(id dataObj, NSError *error) {
//        [MBProgressHUD hideHUD];
//        if (dataObj) {
//            NSDictionary *dic = (NSDictionary*)dataObj;
//            NSString * result = [NSString stringWithFormat:@"%@",dic];
//            NSLog(@"dic==================>%@",dic);
//            NSLog(@"result==================>%@",result);
//            if ([dic[@"status"] intValue] == 0) {
//           //     [self saveNotice:dic[@"pictureUrl"]];
//            }
//        }else{
//            NSLog(@"error------------------>%@",error);
//        }
//    }];
    
}

- (IBAction)saveHomework:(id)sender{
//    if ([self.title_fd.text isEqualToString:@""] ||
//        self.classCode == nil ||
//        [self.info_textView.text isEqualToString:@""]) {
//        [MBProgressHUD showError:@"请完善发布信息"];
//        return;
//    }
//    NSDictionary *param = @{
//                          @"title":[self.title_fd.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
//                          @"content":[self.info_textView.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
//                          @"nanZhongdian":[self.zhongdian_textView.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
//                          @"classString":self.classCode,
//                          @"teacherId":kTeacherObject.idcode
//                          };
//    [AddHomeworkData getWithMethodName:@"api.homework.saveHomeWork.do" param:param modelClass:nil requestStartBlock:^{
//        [MBProgressHUD showMessage:@"正在发布"];
//    } responseBlock:^(id dataObj, NSError *error) {
//        if (dataObj) {
//            [MBProgressHUD showSuccess:@"发布成功"];
//            [self.navigationController popViewControllerAnimated:YES];
//        }else{
//            [MBProgressHUD showError:@"发布失败"];
//        }
//    }];
}
//作业详情
- (IBAction)addClassAction:(id)sender {
    HomeworkInfoViewController *homeWorkInfoVC = [[HomeworkInfoViewController alloc]initWithNibName:@"HomeworkInfoViewController" bundle:nil];
    homeWorkInfoVC.workDetailObj = self.workDetailObj;
    [self.navigationController pushViewController:homeWorkInfoVC animated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)reloadPhotosView{
    [self.imageBackgroundView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.imageBackgroundView addSubview:self.addImage_btn];
    if (self.imageList.count == 0) {
        [self.addImage_btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(0);
            make.width.height.mas_equalTo((SCREEN_WIDTH-40)/3);
        }];
    }else{
        UIView *lastView;
        for (int i = 0; i < self.imageList.count; i++) {
            int lie = i%3;
            
            UIButton  *button = [UIButton new];
            [button setBackgroundColor:MainColor];
            [button setBackgroundImage:self.imageList[i] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(deleteImage:) forControlEvents:UIControlEventTouchUpInside];
            [self.imageBackgroundView addSubview:button];
            
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                if (lastView) {
                    if (lie == 0) {
                        make.top.mas_equalTo(lastView.mas_bottom).offset(4);
                        make.left.mas_equalTo(0);
                    }else{
                        make.top.mas_equalTo(lastView.mas_top);
                        make.left.mas_equalTo(lastView.mas_right).offset(4);
                    }
                }else{
                    make.top.left.mas_equalTo(0);
                }
                make.width.height.mas_equalTo((SCREEN_WIDTH-40)/3);
            }];
            lastView = button;
        }
        [self.addImage_btn mas_makeConstraints:^(MASConstraintMaker *make) {
            if (self.imageList.count%3 == 0) {
                make.top.mas_equalTo(lastView.mas_bottom).offset(4);
                make.left.mas_equalTo(0);
            }else{
                make.top.mas_equalTo(lastView.mas_top);
                make.left.mas_equalTo(lastView.mas_right).offset(4);
            }
            make.width.height.mas_equalTo((SCREEN_WIDTH-40)/3);
        }];
    }
    
    [self.imageBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.addImage_btn.mas_bottom);
    }];
}

- (IBAction)deleteImage:(id)sender{
    UIButton *btn = (UIButton *)sender;
    NSInteger tag = btn.tag;
    NSMutableArray *newImageList = [[NSMutableArray alloc]init];
    
    for (int i=0; i<self.imageList.count; i++) {
        if (i!=tag) {
            UIImage *image = self.imageList[i];
            [newImageList addObject:image];
        }
    }
    self.imageList = newImageList;
    [self reloadPhotosView];
}

- (void)addImages{
    UIActionSheet *sheet;
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        sheet  = [[UIActionSheet alloc] initWithTitle:@"选择图片" delegate:self cancelButtonTitle:nil destructiveButtonTitle: nil otherButtonTitles:@"拍照",@"从相册选择",@"取消", nil];
    }
    else {
        sheet = [[UIActionSheet alloc] initWithTitle:@"选择图片" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"从相册选择",@"取消", nil];
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
                case 0:// 相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                case 1:// 相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
                case 2:// 取消
                    return;
                    break;
            }
        }
        else {
            if (buttonIndex == 0) {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            } else {
                return;
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
    NSURL *imageURL = [info valueForKey:UIImagePickerControllerReferenceURL];
    NSData *selectImageData;
    if (imageURL == nil) {
        UIImage *selectImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        selectImageData = UIImageJPEGRepresentation(selectImage,0.3);
    }
    
    if(self.assetslibrary == nil){
        self.assetslibrary = [[ALAssetsLibrary alloc] init];
    }
    
    ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *myasset){
        ALAssetRepresentation *representation = [myasset defaultRepresentation];
        NSString *fileName = [representation filename];
        NSString *tempPath = NSTemporaryDirectory();
        NSData *imageData = UIImageJPEGRepresentation([UIImage imageWithCGImage:representation.fullScreenImage],0.3);
        NSString *filePath = [tempPath stringByAppendingPathComponent:@"TempImages"];
        if(![[NSFileManager defaultManager] fileExistsAtPath:filePath]){
            [[NSFileManager defaultManager] createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        BOOL success = NO;
        if (selectImageData) {
            NSDate *date = [NSDate date];
            NSString *str = [NSString stringWithFormat:@"%@",date];
            NSString *fileNewName = [NSString stringWithFormat:@"%@.jpg",[str componentsSeparatedByString:@"."][0]];
            filePath = [filePath stringByAppendingPathComponent:fileNewName];
            success = [selectImageData writeToFile:filePath atomically:YES];
        }else{
            filePath = [filePath stringByAppendingPathComponent:fileName];
            success = [imageData writeToFile:filePath atomically:YES];
        }
        
        if(success){
            if(self.imageList == nil){
                self.imageList = [[NSMutableArray alloc]init];
            }
            UIImage *newImg;
            if (selectImageData) {
                newImg = [UIImage imageWithData:selectImageData];
            }else{
                newImg = [UIImage imageWithData:imageData];
                
            }
            //[self.m_fileArray addObject:filePath];
            [self.imageList addObject:newImg];
            [self reloadPhotosView];
        }
        [picker dismissViewControllerAnimated:YES completion:nil];
    };
    [self.assetslibrary assetForURL:imageURL
                        resultBlock:resultblock
                       failureBlock:nil];
}

#pragma mark - getters and setters

//- (UIBarButtonItem *)saveHomeworkItem{
//    if (_saveHomeworkItem == nil) {
//        _saveHomeworkItem = [[UIBarButtonItem alloc] initWithTitle:@"保存"
//                                                             style:UIBarButtonItemStylePlain target:self
//                                                            action:@selector(saveImages:)];
//    }
//    return _saveHomeworkItem;
//}

- (UIButton *)addImage_btn{
    if (_addImage_btn == nil) {
        _addImage_btn = [[UIButton alloc]init];
        [_addImage_btn setBackgroundImage:[UIImage imageNamed:@"addImageBtn"] forState:UIControlStateNormal];
        [_addImage_btn addTarget:self action:@selector(addImages) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addImage_btn;
}




@end
