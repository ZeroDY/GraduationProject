//
//  RecommendNormalDetailViewController.m
//  ASParentTest
//
//  Created by 张浩 on 15/12/21.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "RecommendNormalDetailViewController.h"

@interface RecommendNormalDetailViewController ()

@end

@implementation RecommendNormalDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",kPublic_URL,self.idCode];
    NSLog(@"%@",urlStr);
    NSURL *url = [NSURL URLWithString:urlStr];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];

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
