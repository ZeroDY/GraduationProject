//
//  HomeworkInfoViewController.m
//  ASTeacher
//
//  Created by 周德艺 on 15/11/23.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "HomeworkInfoViewController.h"
#import "UIButton+AFNetworking.h"

@interface HomeworkInfoViewController ()

@property (weak, nonatomic) IBOutlet UILabel *homeworkTitle_label;
@property (weak, nonatomic) IBOutlet UILabel *jieShouZhe_label;
@property (weak, nonatomic) IBOutlet UILabel *date_label;
@property (weak, nonatomic) IBOutlet UILabel *homeworkInfo_label;
@property (weak, nonatomic) IBOutlet UILabel *zhongDian_label;
@property (weak, nonatomic) IBOutlet UIView *imageBackgroundView;
@property (weak, nonatomic) IBOutlet UIView *statusView;

@property (nonatomic, strong) NSMutableArray *imageList;

@end

@implementation HomeworkInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"作业详情";
//    self.homeworkTitle_label.text = @"语文-做课后习题 P25";
//    self.jieShouZhe_label.text = @"初一3班、初一4班";
//    self.date_label.text = @"发布时间：2015-12-01 18:00";
//    self.homeworkInfo_label.text = @"梅花是中国古代文人墨客千年吟咏不绝的主题。宋代林和靖，这位赏梅爱梅的大隐士就有不断吟唱梅花的诗篇。以“妻梅子鹤”的感情寄寓于梅花之中，可谓爱梅之最的文人了。毛主席在这里所据陆游咏梅词，反其意而用之的《卜算子·咏梅》的确与陆游所写大相径庭。陆游写梅花的寂寞高洁，孤芳自赏，引来群花的羡慕与嫉妒。而主席这首诗却是写梅花的美丽、积极、坚贞，不是愁而是笑，不是孤傲而是具有新时代革命者的操守与傲骨。中国写梅之诗不计其数，大意境与大调子都差不多；毛主席的确以一代大诗人的风范，出手不凡，一首咏梅诗力扫过去文人那种哀怨、颓唐、隐逸之气，创出一种新的景观与新的气象，令人叹为观止，心服口服。";
//    self.zhongDian_label.text = @"风雨送春归，飞雪迎春到。 已是悬崖百丈冰，犹有花枝俏。 俏也不争春，只把春来报。 待到山花烂漫时，她在丛中笑。 在诗人毛泽东心目中，这梅魂梅骨，梅趣梅神，不正是在多事之秋，那些始终有骨气、有理想的马克思主义战士应有的风采吗？";
    self.homeworkTitle_label.text = [NSString stringWithFormat:@"[%@]-%@",self.workDetailObj.name, self.workDetailObj.header];
    self.jieShouZhe_label.text = self.workDetailObj.stcont;
    self.date_label.text = self.workDetailObj.addtime;
    self.homeworkInfo_label.text = self.workDetailObj.miaoshu;
    self.zhongDian_label.text = self.workDetailObj.zongdian;
    self.statusView.layer.masksToBounds = YES;
    self.statusView.layer.cornerRadius = self.statusView.frame.size.width/2;
}

- (void)viewWillAppear:(BOOL)animated{
    //[self reloadPhotosView];
    if (self.imageList == nil) {
        self.imageList = [[NSMutableArray alloc]init];
    }
    self.imageList = [PublicObject getImageList:self.workDetailObj.picList];
    [self reloadPhotosView];
}



- (void)reloadPhotosView{
    [self.imageBackgroundView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UIView *lastView;
    for (int i = 0; i < self.imageList.count; i++) {
        int lie = i%3;
        NSURL *imageUrl = [NSURL URLWithString:self.imageList[i]];
        
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
            
            make.width.height.mas_equalTo((SCREEN_WIDTH-44)/3);
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
