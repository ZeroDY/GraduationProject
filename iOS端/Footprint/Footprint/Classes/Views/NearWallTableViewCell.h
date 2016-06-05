//
//  NearWallTableViewCell.h
//  Footprint
//
//  Created by 周德艺 on 15/5/2.
//  Copyright (c) 2015年 周德艺. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, XYZPhotoState) {
    XYZPhotoStateNormal,
    XYZPhotoStateBig,
    XYZPhotoStateDraw,
    XYZPhotoStateTogether
};
@interface NearWallTableViewCell : UITableViewCell<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *tagImgBtn;
@property (weak, nonatomic) IBOutlet UIImageView *wallImage;
@property (weak, nonatomic) IBOutlet UILabel *wallName_Label;
@property (weak, nonatomic) IBOutlet UILabel *wallInfo_Label;
@property (weak, nonatomic) IBOutlet UILabel *wallLocation_Label;
@property (weak, nonatomic) IBOutlet UILabel *wallTime_Label;
@property (weak, nonatomic) IBOutlet UIButton *collect_btn;

//查看大图
@property (nonatomic, strong) UIImage *bigImage;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIScrollView *backScrollView;
@property (nonatomic, strong) UIImageView *bigImageView;
- (IBAction)tapImage:(id)sender;

@end
