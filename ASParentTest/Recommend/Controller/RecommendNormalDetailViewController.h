//
//  RecommendNormalDetailViewController.h
//  ASParentTest
//
//  Created by 张浩 on 15/12/21.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecommendNormalDetailViewController : UIViewController<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic , strong)NSString *idCode;
@end
