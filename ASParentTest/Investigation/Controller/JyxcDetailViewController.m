//
//  JyxcDetailViewController.m
//  ASParentTest
//
//  Created by 张浩 on 15/11/20.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "JyxcDetailViewController.h"
#import "JyxcDetailObject.h"
//接口
#import "DYRequestBase+GetSuggestionDetail.h"
@interface JyxcDetailViewController ()

@end

@implementation JyxcDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"建言详情";
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self getJyxcDetail];
}
-(void)getJyxcDetail{
    [DYRequestBase getSuggestionDetailBySuggestId:self.idCode requestStartBlock:^{
        [PublicObject showHUDBegain:self.view title:@"正在获取……"];
    } responseBlock:^(id dataObj, NSError *error) {
        [PublicObject dissMissHUDEnd];
        if (dataObj) {
            int status = [[dataObj objectForKey:@"status"] intValue];
            NSString *msg = [PublicObject convertNullString:[dataObj objectForKey:@"msg"]];
            if (status == 0) {
                NSArray *objArr = [dataObj objectForKey:@"obj"];
                NSLog(@"%@",objArr);
                NSDictionary *objDic = [objArr objectAtIndex:0];
                self.jyxcDetailObj = [JyxcDetailObject mj_objectWithKeyValues:objDic];
                self.titleLab.text = self.jyxcDetailObj.sheader;
                self.objLab.text = self.jyxcDetailObj.getpeoplestyle;
                self.timeLab.text = self.jyxcDetailObj.addtime;
                self.contentLab.text = self.jyxcDetailObj.suggestion;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
