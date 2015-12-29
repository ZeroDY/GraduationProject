//
//  NoticeInfoViewController.m
//  ASTeacher
//
//  Created by 周德艺 on 15/11/24.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "NoticeInfoViewController.h"
#import "UIButton+AFNetworking.h"
//接口
#import "DYRequestBase+GetMessageSummary.h"
@interface NoticeInfoViewController ()

@property (weak, nonatomic) IBOutlet UILabel *title_label;
@property (weak, nonatomic) IBOutlet UILabel *fabu_label;
@property (weak, nonatomic) IBOutlet UILabel *date_label;
@property (weak, nonatomic) IBOutlet UILabel *info_label;
@property (weak, nonatomic) IBOutlet UIView *imageBackgroundView;

@property (nonatomic, strong) NSMutableArray *imageList;
@property (nonatomic, strong) NoticeDetailObject *notice;

@end

@implementation NoticeInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"通知详情";
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getNoticeInfo];
}

- (void)getNoticeInfo{
    NSMutableDictionary *parametersDic = [[NSMutableDictionary alloc]init];
    [parametersDic setValue:self.noticeid forKey:@"messageId"];
    [DYRequestBase getMessageSummaryByMessageId:self.noticeid requestStartBlock:^{
        [PublicObject showHUDBegain:self.view title:@"正在获取……"];
    } responseBlock:^(id dataObj, NSError *error) {
        [PublicObject dissMissHUDEnd];
        if (dataObj) {
            int status = [[dataObj objectForKey:@"status"] intValue];
            NSString *msg = [PublicObject convertNullString:[dataObj objectForKey:@"msg"]];
            if (status == 0) {
                NSDictionary *objDic = [dataObj objectForKey:@"obj"];
                NSLog(@"%@",objDic);
                self.notice = [NoticeDetailObject mj_objectWithKeyValues:objDic];
                
                if (self.imageList == nil) {
                    self.imageList = [[NSMutableArray alloc]init];
                }
                self.imageList = [PublicObject getImageList:self.notice.picList];
                [self reloadPhotosView];
            }
            else {
                [PublicObject showHUDView:self.view title:msg content:@"" time:kHUDTime andCodes:^{
                }];
            }
        }else{
            [PublicObject showHUDView:self.view title:@"请求失败" content:@"" time:kHUDTime andCodes:^{
            }];
            
        }
    }];
    
}

- (void)reloadPhotosView{
    self.title_label.text = self.notice.theader;
    self.fabu_label.text = [NSString stringWithFormat:@"发布者：%@",[PublicObject convertNullString:self.notice.teaname]];
    self.date_label.text = [NSString stringWithFormat:@"发布时间：%@",[PublicObject convertNullString:self.notice.addtime]];
    self.info_label.text = [PublicObject convertNullString:self.notice.tcontent];
    
    [self.imageBackgroundView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UIView *lastView;
    for (int i = 0; i < self.imageList.count; i++) {
        int lie = i%3;
        
        NSURL *imageUrl = [NSURL URLWithString:self.imageList[i]];
        NSLog(@"%@",imageUrl);
        UIButton  *button = [UIButton new];
        [button setBackgroundColor:MainColor];
        [button sd_setImageWithURL:imageUrl forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"default"]];
        [button addTarget:self action:@selector(magnifyImage:) forControlEvents:UIControlEventTouchUpInside];
        [self.imageBackgroundView addSubview:button];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            if (lastView) {
                if (lie == 0) {
                    make.top.mas_equalTo(lastView.mas_bottom).offset(2);
                    make.left.mas_equalTo(0);
                }else{
                    make.top.mas_equalTo(lastView.mas_top);
                    make.left.mas_equalTo(lastView.mas_right).offset(2);
                }
            }else{
                make.top.left.mas_equalTo(0);
            }
            
            make.height.mas_equalTo(button.mas_width);
            make.width.mas_equalTo((SCREEN_WIDTH-44)/3);
        }];
        lastView = button;
    }
    [lastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.imageBackgroundView.mas_bottom);
    }];
}

-(IBAction)magnifyImage:(id)sender
{
    UIButton *imgView = (UIButton *)sender;
    [PublicObject showImage:imgView];//调用方法
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
