//
//  SetUpViewController.m
//  Footprint
//
//  Created by 张浩 on 15/5/26.
//  Copyright (c) 2015年 周德艺. All rights reserved.
//

#import "SetUpViewController.h"
#import "MMExampleDrawerVisualStateManager.h"
#import "UIViewController+MMDrawerController.h"
#import "MMNavigationController.h"
#import "ChangeUseInfoViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
typedef NS_ENUM(NSInteger, MMCenterViewControllerSection){
    MMCenterViewControllerSectionLeftViewState,
    MMCenterViewControllerSectionLeftDrawerAnimation,
    MMCenterViewControllerSectionRightViewState,
    MMCenterViewControllerSectionRightDrawerAnimation,
};

@interface SetUpViewController ()

@end

@implementation SetUpViewController
- (id)init
{
    self = [super init];
    if (self) {
        [self setRestorationIdentifier:@"MMExampleCenterControllerRestorationKey"];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.user = [[UserObject alloc]init];
    self.trueName = [[UILabel alloc]init];
    self.userName = [[UILabel alloc]init];
    self.sex = [[UILabel alloc]init];
    self.age = [[UILabel alloc]init];
    self.tel = [[UILabel alloc]init];
    self.photo = [UIImage imageNamed:@"userphoto"];
}

-(void)viewWillAppear:(BOOL)animated{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *userDic = [defaults objectForKey:USERINFO];
    self.user = [UserObject objectWithKeyValues:userDic];
    [self getUserInfoByUserName:self.user.username];
}

#pragma mark - 获取数据 - 用户信息
-(void)getUserInfoByUserName :(NSString *)userName{
    NSString *parameters = [NSString stringWithFormat:@"%@",userName];
    [FtService GETmethod:kFinduserbyname andParameters:parameters andHandle:^(NSDictionary *myresult) {
        NSDictionary *result = myresult;
        int status = [[result objectForKey:@"status"]intValue];
        if (status == 1) {
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSDictionary *userDic = [result objectForKey:@"result"];
            self.user = [UserObject objectWithKeyValues:userDic];
            NSDictionary *userInfo = self.user.keyValues;
            [defaults setObject:userInfo forKey:USERINFO];
            [defaults synchronize];
            NSLog(@"%@",self.user);
            [self.tableView reloadData];
        }
        else{
            NSLog(@"失败");
        }
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 3;
            break;
        case 1:
            return 3;
            break;
        default:
            return 0;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleBlue];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    switch (indexPath.section) {
        case 0:
            if(indexPath.row == 0){
                
                //头像
                self.iconBtn = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-100)/2, 20, 100, 100)];
                self.iconBtn.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
                self.iconBtn.layer.borderWidth = 3.0f;
                self.iconBtn.layer.rasterizationScale = [UIScreen mainScreen].scale;
                self.iconBtn.layer.shouldRasterize = YES;
                self.iconBtn.clipsToBounds = YES;
                self.iconBtn.layer.masksToBounds = YES;
                self.iconBtn.layer.cornerRadius = self.iconBtn.frame.size.width / 2;
                [self.iconBtn addTarget:self action:@selector(changePhoto:) forControlEvents:UIControlEventTouchUpInside];
                NSString *imgurl = [NSString stringWithFormat:@"%@%@",KGetImage_URL,self.user.photourl];
                [self.iconBtn sd_setImageWithURL:[NSURL URLWithString:imgurl] forState:UIControlStateNormal placeholderImage:self.photo];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                [cell addSubview:self.iconBtn];
            }
            if (indexPath.row == 1) {
                //真实姓名
                UILabel *trueNameLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 4, 60, 40)];
                trueNameLab.text = @"昵称";
                trueNameLab.textColor = [UIColor blackColor];
                [cell addSubview:trueNameLab];
                
                [self.trueName setFrame:CGRectMake(20, 4, SCREEN_WIDTH-50, 40)];
                self.trueName.textAlignment = NSTextAlignmentRight;
                self.trueName.text = self.user.truename;
                self.trueName.textColor = [UIColor grayColor];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                [cell addSubview:self.trueName];
            }
            if (indexPath.row == 2) {
                //用户名
                UILabel *userNameLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 4, 60, 40)];
                userNameLab.text = @"用户名";
                userNameLab.textColor = [UIColor blackColor];
                [cell addSubview:userNameLab];
                
                [self.userName setFrame:CGRectMake(20, 4, SCREEN_WIDTH-50, 40)];
                self.userName.textAlignment = NSTextAlignmentRight;
                self.userName.text = self.user.username;
                self.userName.textColor = [UIColor grayColor];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                [cell addSubview:self.userName];
            }
            break;
        case 1:
            if (indexPath.row == 0) {
                //性别
                UILabel *sexLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 4, 60, 40)];
                sexLab.text = @"性别";
                sexLab.textColor = [UIColor blackColor];
                [cell addSubview:sexLab];
                
                [self.sex setFrame:CGRectMake(20, 4, SCREEN_WIDTH-50, 40)];
                self.sex.textAlignment = NSTextAlignmentRight;
                self.sex.text = self.user.sex;
                self.sex.textColor = [UIColor grayColor];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                [cell addSubview:self.sex];
            }
            if (indexPath.row == 1){
                //年龄
                UILabel *ageLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 4, 60, 40)];
                ageLab.text = @"年龄";
                ageLab.textColor = [UIColor blackColor];
                [cell addSubview:ageLab];
                
                [self.age setFrame:CGRectMake(20, 4, SCREEN_WIDTH-50, 40)];
                self.age.textAlignment = NSTextAlignmentRight;
                self.age.text = [NSString stringWithFormat:@"%i",self.user.age];
                self.age.textColor = [UIColor grayColor];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                [cell addSubview:self.age];
            }
            if (indexPath.row == 2) {
                //电话
                UILabel *telLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 4, 60, 40)];
                telLab.text = @"电话";
                telLab.textColor = [UIColor blackColor];
                [cell addSubview:telLab];
                
                [self.tel setFrame:CGRectMake(20, 4, SCREEN_WIDTH-50, 40)];
                self.tel.textAlignment = NSTextAlignmentRight;
                self.tel.text = self.user.tel;
                self.tel.textColor = [UIColor grayColor];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                [cell addSubview:self.tel];
                
            }
            break;
        default:
            break;
    }
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *groupName = [[NSString alloc]init];
    switch (section) {
        case 1:
            groupName = @"其他资料";
            return groupName;
            break;
            
        default:
            return nil;
            break;
    }
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.0001;
    }
    else{
        return 23;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            if (indexPath.row == 0) {
                return 150;
            }
            else{
                return  44;
            }
            break;
        case 1:
            return 44;
            break;
        case 2:
            return 70;
            break;
        default:
            return 44;
            break;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        NSLog(@"%ld",(long)indexPath.row);
        switch (indexPath.section) {
            case 0:
                if(indexPath.row == 1){
                    ChangeUseInfoViewController *changeInfoVC = [[ChangeUseInfoViewController alloc]initWithNibName:@"ChangeUseInfoViewController" bundle:nil];
                    changeInfoVC.title = @"昵称";
                    changeInfoVC.infoStr = self.user.truename;
                    changeInfoVC.isTrueName = YES;
                    changeInfoVC.isSex = NO;
                    changeInfoVC.isAge = NO;
                    changeInfoVC.isTel = NO;
                    [self.navigationController pushViewController:changeInfoVC animated:YES];
                }
                break;
            case 1:
                if (indexPath.row == 0) {
                    ChangeUseInfoViewController *changeInfoVC = [[ChangeUseInfoViewController alloc]initWithNibName:@"ChangeUseInfoViewController" bundle:nil];
                    changeInfoVC.title = @"性别";
                    changeInfoVC.infoStr = self.user.sex;
                    changeInfoVC.isTrueName = NO;
                    changeInfoVC.isSex = YES;
                    changeInfoVC.isAge = NO;
                    changeInfoVC.isTel = NO;
                    [self.navigationController pushViewController:changeInfoVC animated:YES];
                }
                if (indexPath.row == 1) {
                    ChangeUseInfoViewController *changeInfoVC = [[ChangeUseInfoViewController alloc]initWithNibName:@"ChangeUseInfoViewController" bundle:nil];
                    changeInfoVC.title = @"年龄";
                    changeInfoVC.infoStr = [NSString stringWithFormat:@"%i",self.user.age];
                    changeInfoVC.isTrueName = NO;
                    changeInfoVC.isSex = NO;
                    changeInfoVC.isAge = YES;
                    changeInfoVC.isTel = NO;
                    [self.navigationController pushViewController:changeInfoVC animated:YES];
                }
                if (indexPath.row == 2) {
                    ChangeUseInfoViewController *changeInfoVC = [[ChangeUseInfoViewController alloc]initWithNibName:@"ChangeUseInfoViewController" bundle:nil];
                    changeInfoVC.title = @"电话";
                    changeInfoVC.infoStr = self.user.tel;
                    changeInfoVC.isTrueName = NO;
                    changeInfoVC.isSex = NO;
                    changeInfoVC.isAge = NO;
                    changeInfoVC.isTel = YES;
                    [self.navigationController pushViewController:changeInfoVC animated:YES];
                }
                break;
            case 3:
                if(indexPath.row == 0){
                    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                    LoginViewController *loginVC = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
                    UINavigationController *loginNavi = [[UINavigationController alloc] initWithRootViewController:loginVC];
                    
                    
                    appDelegate.window.rootViewController = loginNavi;

                }
                break;
            default:
                break;
        }
}


- (IBAction)changePhoto:(id)sender {
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
    UIImage *selectImage = [info objectForKey:UIImagePickerControllerEditedImage];
    
    UIImage* newImage = [PublicObject fixOrientation:selectImage];
    
    NSData *imageData = UIImageJPEGRepresentation(newImage,0.5);
    UIImage *newImg = [UIImage imageWithData:imageData];
    self.photo = newImg;

    NSDateFormatter *tFormat=[[NSDateFormatter alloc] init];
    [tFormat setDateFormat:@"yyyyMMddHHmmss"];
    NSString *fileName = [NSString stringWithFormat:@"%@%@.png",self.user.username,[tFormat stringFromDate:[NSDate date]]];
    [[MBProgressView shareMBProgressView] showProgressHUD:self.view title:@"正在上传"];
    [[FootService getFootService]postUploadWithUrl:[KImageUpload_URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] fileImage:newImg fileName:fileName success:^(id responseObject) {
        [[FootService getFootService]GETmethod:kUpdatePhoto andParameters:[NSString stringWithFormat:@"%@,%@",self.user.username,fileName] andHandle:^(NSDictionary *myresult) {
            NSDictionary *result = myresult;
            int status = [[result objectForKey:@"status"]intValue];
            [[MBProgressView shareMBProgressView] dissMissProgressHUD];
            if (status == 1) {
                [self getUserInfoByUserName:self.user.username];
                [PublicObject showHUDView:self.view title:@"提示" content:@"上传成功" time:kHUDTime];
            }
            else{
                NSLog(@"失败");
                [PublicObject showHUDView:self.view title:@"提示" content:@"修改失败" time:kHUDTime];
            }
        }];
    } fail:^{
        NSLog(@"777777777777");
    }];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}

@end
