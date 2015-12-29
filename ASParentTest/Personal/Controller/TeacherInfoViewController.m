//
//  TeacherInfoViewController.m
//  ASTeacher
//
//  Created by 周德艺 on 15/11/23.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "TeacherInfoViewController.h"
#import "TeacherInfoViewCell.h"

@interface TeacherInfoViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation TeacherInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的信息";
    [self.view addSubview:self.tableView];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

#pragma mark - tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return 4;
    }else{
        return 2;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (IS_IOS8_OR_ABOVE) {
        return UITableViewAutomaticDimension;
    }else{
        return 60;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 20;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    static NSString *cellIdentifier = @"TeacherInfoViewCell";
    TeacherInfoViewCell *cell = (TeacherInfoViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        NSBundle *bundle = [NSBundle mainBundle];
        NSArray *nibArray = [bundle loadNibNamed:cellIdentifier owner:nil options:nil];
        cell = (TeacherInfoViewCell *)[nibArray objectAtIndex:0];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    //加载数据
    AccoutObject *userObj = [PublicObject getUserInfoDefault];
    if (indexPath.section == 0) {
        switch (row) {
            case 0:{
                cell.key_label.text = @"头像";
                cell.head_imageView.hidden = NO;
                cell.info_label.hidden = YES;
                //                [cell.head_imageView setImage:[UIImage imageNamed:@"mid_tb1"]];
                
                //给imageView一个点击事件
                cell.head_imageView.userInteractionEnabled = YES;
                UITapGestureRecognizer *click = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageShowClick)];
                [cell.head_imageView addGestureRecognizer:click];
                //加载图片
                NSString *imgURL = @"";
                imgURL = [PublicObject convertNullString:@""];///!!!!!
                if ([imgURL isEqualToString:@""]||imgURL == nil) {
                    [cell.head_imageView setImage:[UIImage imageNamed:@"mid_tb1"]];
                } else {
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        NSString *urlString = [NSString stringWithFormat:@"%@",imgURL];
                        NSURL *imageUrl = [NSURL URLWithString:urlString];
                        NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
                        UIImage *img = [UIImage imageWithData:imageData];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [cell.head_imageView setImage:img];
                        });
                    });
                }
            }
                break;
            case 1:
                cell.key_label.text = @"姓名";
                cell.info_label.text = userObj.truname;
                break;
            case 2:
                cell.key_label.text = @"性别";
                cell.info_label.text = @"男";
                break;
            case 3:
                cell.key_label.text = @"生日";
                cell.info_label.text = @"1988-11-11";
                break;
            default:
                break;
        }
    }else{
        switch (row) {
            case 0:
                cell.key_label.text = @"学科";
                cell.info_label.text = @"高中 数学";
                break;
            case 1:
                cell.key_label.text = @"所在学校";
                cell.info_label.text = @"济南槐荫中学";
                break;
            default:
                break;
        }
    }
    
    
    return cell;
}

#pragma mark - getter and setter
-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView setTableFooterView:[[UIView alloc]init]];
        //[_tableView setSeparatorColor:[UIColor clearColor]];
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 50;
    }
    return _tableView;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark ---头像
-(void)imageShowClick{
    UIActionSheet *sheet;
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        sheet  = [[UIActionSheet alloc] initWithTitle:@"选择头像" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选择", nil];
    }
    else {
        sheet = [[UIActionSheet alloc] initWithTitle:@"选择头像" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相册选择", nil];
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
    UIImage *selectImage = [info objectForKey:UIImagePickerControllerEditedImage];
    
    UIImage* newImage = [PublicObject fixOrientation:selectImage];
    
    NSData *imageData = UIImageJPEGRepresentation(newImage,0.5);
    UIImage *newImg = [UIImage imageWithData:imageData];
    
    //    [self.iconBtn setImage:newImg forState:UIControlStateNormal];
    /**
     *	上传一
     */
    NSMutableArray *temp = [[NSMutableArray alloc]initWithObjects:newImg, nil];
//    [HttpRequestService httpForPostImageData:kChangePhoto parameter:nil imageArray:temp start:^{
//        [PublicObject showHUDBegain:self.view title:@"正在获取……"];
//    } success:^(NSDictionary *successDictionary) {
//        [PublicObject dissMissHUDEnd];
//        NSLog(@"%@",successDictionary);
//        NSDictionary *result = successDictionary;
//        int status = [[result objectForKey:@"status"] intValue];
//        NSString *msg = [PublicObject convertNullString:[result objectForKey:@"msg"]];
//        if (status == 0) {
//            NSArray *objArr = [result objectForKey:@"list"];
//            NSLog(@"%@",objArr);
//            [self.tableView reloadData];
//        } else {
//            [PublicObject showHUDView:self.view title:msg content:@"" time:kHUDTime andCodes:^{
//            }];
//        }
//    } failed:^(NSError *err) {
//        [PublicObject dissMissHUDEnd];
//        [PublicObject showHUDView:self.view title:@"失败" content:@"" time:kHUDTime andCodes:^{
//        }];
//        
//    }];
    
}
#pragma mark -方法1图片转base64
- (BOOL) imageHasAlpha: (UIImage *) image
{
    CGImageAlphaInfo alpha = CGImageGetAlphaInfo(image.CGImage);
    return (alpha == kCGImageAlphaFirst ||
            alpha == kCGImageAlphaLast ||
            alpha == kCGImageAlphaPremultipliedFirst ||
            alpha == kCGImageAlphaPremultipliedLast);
}
- (NSString *) image2DataURL: (UIImage *) image
{
    NSData *imageData = nil;
    NSString *mimeType = nil;
    
    if ([self imageHasAlpha: image]) {
        imageData = UIImagePNGRepresentation(image);
        mimeType = @"image/png";
    } else {
        imageData = UIImageJPEGRepresentation(image, 0.5f);
        mimeType = @"image/jpeg";
    }
    
    return [NSString stringWithFormat:@"%@",
            [imageData base64EncodedStringWithOptions: 0]];
    
    //[NSString stringWithFormat:@"data:%@;base64,%@", mimeType,
    //[imageData base64EncodedStringWithOptions: 0]];
    
}



- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}

@end
